import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/is_checkin_entity.dart';
import '../../domain/use_cases/is_checkin.dart';
import '../../domain/use_cases/send_working_Record.dart';
import '../pages/end_page.dart';

part 'WorkRecord_event.dart';

part 'WorkRecord_state.dart';

class WorkRecordBloc extends Bloc<WorkRecordEvent, WorkRecordState> {
  final SendWorkingRecord sendWorkingRecord;

  final IsCheckInWorkRecord isCheckInWorkRecord;



  WorkRecordBloc({required this.sendWorkingRecord,required this.isCheckInWorkRecord}) : super(LocationInitial()) {
    on<GetCurrentAddress>((event, emit) async {
      List<Placemark> address = await placemarkFromCoordinates(event.lat, event.lng);
      emit(state.copyWith(
          address: address,
          isCheck: event.isCheck,
          lat: event.lat,
          lng: event.lng,
          isError: false));
    });

    on<GetIsCheckIn>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching, address: [], isError: state.isError));
      var res = await isCheckInWorkRecord(event.idEmp);
      res.fold(
              (l) => emit(state.copyWith(status: FetchStatus.failed, isError: true, address: [],error: l)),
              (r) => emit(
              state.copyWith(status: FetchStatus.success, address: [], isError: false,isCheckInData: r)));
    });

    on<SendWorkingRecordData>((event, emit) async {
      var res = await sendWorkingRecord(
        event.description,
        event.idCompany,
        event.idEmp,
        state.isCheck,
        state.lat!,
        state.lng!,
        state.location,
      );
      res.fold((l) {
        emit(state.copyWith(
          address: state.address!,
          isError: true,
        ));
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => EndPage(
                  date: DateTime.now(),
                  isError: state.isError,
                  address: state.address!,
                  isCheck: state.isCheck),
            ));
      }, (r) {
        emit(state.copyWith(address: state.address!, isError: false));
        if(state.isCheck){
          Navigator.push(
              event.context,
              MaterialPageRoute(
                builder: (context) => EndPage(
                    date: DateTime.now(),
                    isError: state.isError,
                    address: state.address!,
                    isCheck: state.isCheck),
              ));
        }
        else{
          Navigator.push(
              event.context,
              MaterialPageRoute(
                builder: (context) => EndPage(
                  date: DateTime.now(),
                  address: state.address!,
                  isError: state.isError,
                  isCheck: state.isCheck,
                  note: event.description,
                ),
              ));
        }

      });
    });
  }
}
