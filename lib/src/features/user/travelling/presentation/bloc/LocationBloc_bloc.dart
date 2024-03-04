import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/usecases.dart';
import '../pages/success_page.dart';

part 'LocationBloc_event.dart';

part 'LocationBloc_state.dart';

class LocationBloc extends Bloc<GpsEvent, LocationState> {
  final SendRouteRecord sendRouteRecord;
  final GetTimelineById getTimeLineById;
  final IsCheckIn isCheckIn;

  LocationBloc(
      {required this.sendRouteRecord,
      required this.getTimeLineById,
      required this.isCheckIn})
      : super(LocationInitial()) {
    on<GetCurrentAddress>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      List<Placemark> address = await placemarkFromCoordinates(event.lat, event.lng);
      var res = await isCheckIn(event.idEmp);
      res.fold(
              (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
              (r) => emit(
              state.copyWith(status: FetchStatus.success, isCheckInData: r,isSetLocation: true,address: address,
                  lat: event.lat,
                  lng: event.lng)));
      // emit(state.copyWith(
      //     address: address,
      //     isSetLocation: true,
      //     lat: event.lat,
      //     lng: event.lng));
    });

    on<GetIsCheckIn>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var res = await isCheckIn(event.idEmp);
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) => emit(
              state.copyWith(status: FetchStatus.success, isCheckInData: r,isSetLocation: true)));
    });

    on<GetTimeLineDataById>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var res = await getTimeLineById(event.date, event.idEmp);
      res.fold(
          (l) => emit(state.copyWith(
              status: FetchStatus.failed, address: state.address ?? [],error: l)),
          (r) => emit(
              state.copyWith(status: FetchStatus.success, timeLineData: r)));
    });

    on<SendRouteRecordData>((event, emit) async {
      emit(state.copyWith(
          status: FetchStatus.fetching, location: event.location));
      var res = await sendRouteRecord(
        event.idCompany,
        event.idEmp,
        event.isCheckIn,
        event.lat,
        state.location,
        event.lng,
        event.mile,
        event.type,
      );
      res.fold((l) => emit(state.copyWith(status: FetchStatus.failed)), (r) {
        emit(state.copyWith(status: FetchStatus.success));
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => SuccessPage(
                isCheckIn: event.isCheckIn,
                date: event.date,
                locationName: state.location,
              ),
            ));
      });
    });
  }
}
