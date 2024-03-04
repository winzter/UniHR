import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/shift_change.dart';
import '../../domain/entities/enitities.dart';
import '../../domain/use_cases/use_cases.dart';
import '../pages/end_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'time_management_event.dart';

part 'time_management_state.dart';

class TimeManagementBloc
    extends Bloc<TimeManagementEvent, TimeManagementState> {
  final GetShift getShift;
  final GetTimeSchedule getTimeSchedule;
  final GetHoliday getHoliday;
  final GetHoliday getHolidayEn;
  final WithDrawChangeTime withDrawChangeTime;
  final GetCheckHoliday getShiftHoliday;
  final SendShiftChange sendShiftChange;
  final WithDrawChangeTime withdrawChangTime;

  TimeManagementBloc({
    required this.getShift,
    required this.withDrawChangeTime,
    required this.getTimeSchedule,
    required this.getHoliday,
    required this.getHolidayEn,
    required this.sendShiftChange,
    required this.withdrawChangTime,
    required this.getShiftHoliday,
  }) : super(TimeManagementInitial()) {
    // on<TimeManagementLoadShiftData>((event, emit) async {
    //   Map<int,String> shiftTypeName = {};
    //   List<ShiftEntity> shiftData = [];
    //   emit(state.copyWith(
    //     status: FetchStatus.fetching,
    //   ));
    //   Either<Failure, List<ShiftEntity>> responseShift = await getShift();
    //   Either<Failure, List<HolidayEntity>> responseHoliday = await getHoliday();
    //
    //   responseShift.fold(
    //       (l) => emit(state.copyWith(
    //             shiftData: state.shiftData,
    //             status: FetchStatus.failed,
    //           )), (r) {
    //     for(var i in r){
    //       if(i.idWorkingType == 2){
    //         shiftTypeName[i.idShiftGroup!] = i.shiftGroupName!;
    //       }
    //     }
    //     shiftTypeName[999] = "วันหยุดประจำสัปดาห์";
    //     shiftTypeName[1000] = "วันหยุดนักขัตฤกษ์";
    //     shiftData = r;
    //   });
    //   responseHoliday.fold(
    //       (l) => emit(state.copyWith(
    //             shiftData: state.shiftData,
    //             status: FetchStatus.failed,
    //           )),
    //       (r) => emit(state.copyWith(
    //           shiftName: shiftTypeName,
    //           status: FetchStatus.success,
    //           holidayData: r,
    //           shiftData: shiftData)));
    // });

    on<TimeManagementLoadScheduleData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      List<TimeScheduleEntity> timeSchedule = [];
      List<int> forbiddenHoliday = [];
      Map<int, List<dynamic>> shiftTypeName = {};
      List<ShiftEntity> shiftData = [];
      Map<int, String> holidayData = {};
      bool isErrorOccur = false;
      Map<int, String> holidayDataEn = {};
      // List<HolidayEntity> holidayData = [];
      Either<ErrorMessage, List<TimeScheduleEntity>> responseTimeSchedule =
          await getTimeSchedule(
              event.startDate ?? DateFormat("yyyy-MM-dd").format(state.date!));
      var responseCheckHoliday = await getShiftHoliday(
          event.startDate ?? DateFormat("yyyy-MM-dd").format(state.date!));
      Either<ErrorMessage, List<ShiftEntity>> responseShift = await getShift();
      Either<ErrorMessage, List<HolidayEntity>> responseHoliday =
          await getHoliday();
      responseShift.fold((l) {
        emit(state.copyWith(
            shiftData: state.shiftData, status: FetchStatus.failed, error: l));
        isErrorOccur = true;
      }, (r) {
        shiftTypeName[9999] = ["วันที่ทำงาน"];
        for (var i in r) {
          if (i.idWorkingType == 2 && i.shiftType != null) {
            for (var j in i.shiftType!) {
              if (j.isWorkingDay == 1)
                shiftTypeName[j.idShiftType!] = [
                  i.shiftGroupName!,
                  i.idShiftGroup!,
                  j.isWorkingDay
                ];
            }
          }
        }
        shiftTypeName[999] = ["วันหยุดประจำสัปดาห์"];
        for (var i in r) {
          if (i.idWorkingType == 2 && i.shiftType != null) {
            for (var j in i.shiftType!) {
              if (j.isWorkingDay == 0)
                shiftTypeName[j.idShiftType!] = [
                  i.shiftGroupName!,
                  i.idShiftGroup!,
                  j.isWorkingDay
                ];
            }
          }
        }
        shiftTypeName[10000] = ["วันหยุดนักขัตฤกษ์"];
        shiftTypeName[1000] = ["วันหยุดนักขัตฤกษ์", "", 0];
        shiftData = r;
      });
      responseTimeSchedule.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failed,
              )), (r) {
        timeSchedule = r;
      });
      responseHoliday.fold(
          (l) => emit(state.copyWith(
                shiftData: state.shiftData,
                status: FetchStatus.failed,
              )), (r) {
        // holidayData = r;
        for (var i in r) {
          if (i.isActive == 1 && i.idHoliday != null && i.name != null) {
            holidayData[i.idHoliday!] = i.name!;
          }
        }
        for (var i in r) {
          if (i.isActive == 1 && i.idHoliday != null && i.name_EN != null) {
            holidayDataEn[i.idHoliday!] = i.name_EN!;
          }
        }
      });
      responseCheckHoliday
          .fold((l) => emit(state.copyWith(status: FetchStatus.failed)), (r) {
        if (r.isNotEmpty) {
          for (var i in r) {
            forbiddenHoliday.add(i.idHoliday!);
          }
          emit(state.copyWith(
              status: FetchStatus.success,
              timeScheduleData: timeSchedule,
              holidayCheck: forbiddenHoliday,
              date: event.date,
              shiftName: shiftTypeName,
              shiftData: shiftData,
              holidayData: holidayData,
              holidayDataEn: holidayDataEn));
        }
        emit(state.copyWith(
            status: FetchStatus.success,
            timeScheduleData: timeSchedule,
            date: event.date,
            shiftName: shiftTypeName,
            shiftData: shiftData,
            holidayData: holidayData,
            holidayDataEn: holidayDataEn));
      });
    });

    on<SendChangeTimeData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      ShiftChange formData;
      print(event.shiftName);
      if (event.shiftName.contains("วันหยุด") || event.shiftName == "0") {
        ShiftEntity shiftData = state.shiftData //! no element
            // .firstWhere((e) => e.idShiftGroup == event.idShiftGroup);
            .firstWhere((e) =>
                e.shiftGroupName!.toLowerCase() ==
                event.shiftNowName.toLowerCase());
        // ShiftType shiftDataUsing = shiftData.shiftType!.firstWhere((e) => e.idShiftType == event.idShiftType);
        if (event.shiftName == "วันหยุดนักขัตฤกษ์") {
          formData = ShiftChange(
            idEmployees: event.idEmp,
            idShift: shiftData.shift!.last.idShift!, //
            idShiftType: shiftData.shiftType!
                .firstWhere((element) => element.isWorkingDay == 0)
                .idShiftType!, //
            workingDate: event.date,
            idShiftGroup: shiftData.idShiftGroup!, //
            isWorkingDay: shiftData.shiftType!
                .firstWhere((element) => element.isWorkingDay == 0)
                .isWorkingDay!, //
            idHoliday: event.idHoliday,
          );
        } else {
          formData = ShiftChange(
            idEmployees: event.idEmp,
            idShift: shiftData.shift!.last.idShift!,
            idShiftType: shiftData.shiftType!
                .firstWhere((element) => element.isWorkingDay == 0)
                .idShiftType!,
            workingDate: event.date,
            idShiftGroup: event.idShiftGroup!,
            isWorkingDay: shiftData.shiftType!
                .firstWhere((element) => element.isWorkingDay == 0)
                .isWorkingDay!,
            idHoliday: event.idHoliday,
          );
        }
      } else {
        ShiftEntity shiftData = state.shiftData
            .firstWhere((e) => e.idShiftGroup == event.idShiftGroup);
        ShiftType shiftDataUsing = shiftData.shiftType!
            .firstWhere((e) => e.idShiftType == event.idShiftType);
        formData = ShiftChange(
          idEmployees: event.idEmp,
          idShift: shiftData.shift!.last.idShift!,
          // idShiftType: shiftData.shiftType!.firstWhere((element) => element.isWorkingDay == 1).idShiftType!,
          idShiftType: event.idShiftType,
          workingDate: event.date,
          idShiftGroup: shiftData.idShiftGroup!,
          isWorkingDay: shiftDataUsing.isWorkingDay!,
          idHoliday: event.idHoliday,
        );
      }
      Either<ErrorMessage, void> responseTimeSchedule =
          await sendShiftChange(formData);
      responseTimeSchedule.fold(
          (l) => {
                Navigator.push(
                    event.context,
                    MaterialPageRoute(
                      builder: (context) => EndPage(
                        shiftName: event.shiftName,
                        date: event.date,
                        isError: true,
                        errorText: l.errMsgText,
                      ),
                    ))
              }, (r) {
        emit(state.copyWith(status: FetchStatus.success));
      });
    });

    on<ChangeDate>((event, emit) async {
      emit(state.copyWith(date: event.date));
    });

    on<WithdrawTimeRequest>((event, emit) async {
      var res = await withDrawChangeTime(
          event.idEmployeeShiftDaily, event.idEmployees);
      res.fold((l) => emit(state.copyWith(status: FetchStatus.failed)),
          (r) => emit(state.copyWith(status: FetchStatus.success)));
    });
  }
}
