import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/use_cases/usecases.dart';

part 'gps_event.dart';

part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  final GetLocation getLocation;
  final SendLocation sendLocation;
  final GetBeacons getBeacons;
  final List<DropdownMenuItem<String>> menuItems = [];

  GpsBloc({required this.getLocation, required this.sendLocation,required this.getBeacons})
      : super(GpsInitial()) {
    on<GetGPSLocation>((event, emit) async {
      Map<int, List<Locations>> subLocations = {};
      List<GroupGpsLocation> groupGpsLocations = [];
      emit(state.copyWith(status: FetchStatus.fetching));
      var locationData = await getLocation(event.idEmp);
      locationData.fold((l) => emit(state.copyWith(status: FetchStatus.failed,error: l)),
          (r) async {
        if (r.methodAttendance == "main") {
          if (r.groupGpsLocations!.isNotEmpty) {
            for (var i = 0; i < r.groupGpsLocations!.length; i++) {
              groupGpsLocations.add(r.groupGpsLocations![i]);
              if (r.groupGpsLocations![i].isActive == 1 &&
                  r.mainWorkingLocationPoint ==
                      r.groupGpsLocations![i].idGroupGpsLocations!) {
                menuItems.add(DropdownMenuItem<String>(
                  value: "${r.groupGpsLocations![i].name}",
                  enabled: true,
                  child: Text(
                    "${r.groupGpsLocations![i].name}",
                    style: TextStyle(fontFamily: 'kanit', fontSize: 16),
                  ),
                ));
                for (var j = 0; j < r.groupGpsLocations![i].locations!.length; j++) {
                  int groupId = r.groupGpsLocations![i].idGroupGpsLocations!;
                  subLocations.putIfAbsent(groupId, () => []);
                  subLocations[groupId]!
                      .add(r.groupGpsLocations![i].locations![j]);
                }
              }
            }
          }
        }
        else if (r.methodAttendance == "all") {
          if (r.groupGpsLocations!.isNotEmpty) {
            for (var i = 0; i < r.groupGpsLocations!.length; i++) {
              groupGpsLocations.add(r.groupGpsLocations![i]);
              if (r.groupGpsLocations![i].isActive == 1) {
                menuItems.add(DropdownMenuItem<String>(
                  value: "${r.groupGpsLocations![i].name}",
                  enabled: true,
                  child: Text(
                    "${r.groupGpsLocations![i].name}",
                    style: TextStyle(fontFamily: 'kanit', fontSize: 16),
                  ),
                ));
                for (var j = 0; j < r.groupGpsLocations![i].locations!.length; j++) {
                  int groupId = r.groupGpsLocations![i].idGroupGpsLocations!;
                  subLocations.putIfAbsent(groupId, () => []);
                  subLocations[groupId]!
                      .add(r.groupGpsLocations![i].locations![j]);
                }
              }
            }
          }
        }
        emit(state.copyWith(
          status: FetchStatus.success,
          subLocations: subLocations,
          locationData: r,
          dropDownData: menuItems,
          groupGpsLocations: groupGpsLocations,
          isPoint: groupGpsLocations.isEmpty,
          isGps: r.isCheckGps??0,
          isBluetooth: r.isCheckBluetooth??0,
        ));
      });
    });

    on<GetBluetoothBeacons>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var data = await getBeacons();
      data.fold((l) => emit(state.copyWith(status: FetchStatus.failed,error: l)),
              (r){
        Map<String,List<dynamic>> beaconsData = {};
        r.forEach((element) {
          beaconsData[element.macAddress!] = [element.idBeacon!,element.name!];
        });
        emit(state.copyWith(status: FetchStatus.success,beacons: beaconsData));
      });
    });

    on<ChangeLocation>((event, emit) {
      emit(state.copyWith(
        selectedLocation: event.selectedLocation,
        status: FetchStatus.selected,
      ));
    });

    on<SendGPSLocation>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      String? addressText;
      if (state.address != null) {
        addressText =
            "${state.address!.reversed.last.name ?? ''} ${state.address!.reversed.last.street ?? ''} ${state.address!.reversed.last.subLocality ?? ''} "
            "${state.address!.reversed.last.locality ?? ''} ${state.address!.reversed.last.postalCode ?? ''} ${state.address!.reversed.last.country ?? ''}";
      }
      var sendLocationStatus = await sendLocation(
          event.attendanceDateTime,
          event.isCheckIn,
          event.idAttendanceType,
          event.idGpsLocation,
          event.idEmployee,
          event.idCompany,
          addressText,
          event.lat,
          event.lng);
      sendLocationStatus.fold((l) => emit(state.copyWith(error: l)), (r) {
        emit(state.copyWith(status: FetchStatus.success));

      });
    });

    on<GetCurrentAddress>((event, emit) async {
      // emit(state.copyWith(status: FetchStatus.fetching));
      List<Placemark> address = await placemarkFromCoordinates(event.lat, event.lng);
      emit(state.copyWith(address: address, status: FetchStatus.success));
    });
  }
}
