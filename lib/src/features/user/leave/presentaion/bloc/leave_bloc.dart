import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/error/failures.dart';
import '../../data/data_sources/leave_request.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/use_cases.dart';

part 'leave_event.dart';

part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeaveHistory getLeaveHistory;
  final GetLeaveAuthority getLeaveAuthority;
  final DeleteLeaveHistory deleteLeaveHistory;
  final SendLeaveRequest sendLeaveRequest;
  final GetDayCannotLeave getDayCannotLeave;
  final GetManagerLeave getManagerLeave;
  final GetHolidayLeave getHolidayLeave;
  final GetLeaveSettingData getLeaveSettingData;
  final GetLeaveAvailableData getLeaveAvailableData;

  LeaveBloc({
    required this.getLeaveHistory,
    required this.sendLeaveRequest,
    required this.deleteLeaveHistory,
    required this.getLeaveAuthority,
    required this.getManagerLeave,
    required this.getDayCannotLeave,
    required this.getHolidayLeave,
    required this.getLeaveSettingData,
    required this.getLeaveAvailableData,
  }) : super(LeaveInitial()) {
    on<GetLeaveHistoryData>((event, emit) async {
      emit(state.copyWith(
          status: FetchStatus.fetching, triggerDate: DateTime.now()));
      var resLeave = await getLeaveHistory(
          event.year ?? state.startPeriodDate ?? DateTime.now());
      LeaveSettingEntity? leaveSetting;
      List<LeaveHistoryEntity> leaveHistoryData = [];
      bool isErrorOccur = false;
      emit(state.copyWith(status: FetchStatus.fetching));
      var resLeaveSetting = await getLeaveSettingData();
      resLeaveSetting.fold(
              (l){
            emit(state.copyWith(status: FetchStatus.failed, error: l));
            isErrorOccur = true;
          },
              (r) => leaveSetting = r);
      resLeave.fold(
          (l){
            emit(state.copyWith(status: FetchStatus.failed, error: l));
            isErrorOccur = true;
          },
          (r){
            leaveHistoryData = r;
          });
      if(!isErrorOccur){
        emit(state.copyWith(
            status: FetchStatus.success,
            leaveHistoryData: leaveHistoryData,
            leaveSetting: leaveSetting,
            startPeriodDate: event.year,
            triggerDate: DateTime.now()));
      }else{
        emit(state.copyWith(status: FetchStatus.failed));
      }
    });

    // on<GetLeaveSettingEvent>((event, emit) async {
    //   emit(state.copyWith(status: FetchStatus.fetching));
    //   var resLeave = await getLeaveSettingData();
    //   resLeave.fold(
    //       (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
    //       (r) => emit(state.copyWith(
    //             status: FetchStatus.success,
    //             leaveSetting: r,
    //           )));
    // });

    on<GetLeaveAvailableEvent>((event, emit) async {
      var resLeave = await getLeaveAvailableData(event.start);
      resLeave.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) {
        emit(state.copyWith(
          status: FetchStatus.success,
          leaveAvailableData: r,
          startPeriodDate: event.start,
          endPeriodDate: event.end,
        ));
      });
    });

    on<GetDayCannotLeaveData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var resLeave =
          await getDayCannotLeave(event.start, event.end, event.idEmp);
      resLeave.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) => emit(
              state.copyWith(status: FetchStatus.success, dayCannotLeave: r)));
    });

    on<DeleteLeaveHistoryData>((event, emit) async {
      List<LeaveHistoryEntity> leaveHistory = state.leaveHistoryData;
      emit(state.copyWith(
          status: FetchStatus.fetching, triggerDate: DateTime.now()));
      var response = await deleteLeaveHistory(event.leaveHistory);
      response.fold(
          (l) => emit(state.copyWith(status: FetchStatus.sendFailed, error: l, triggerDate: DateTime.now())),
          (r) {
        if (event.leaveHistory.isApprove != 1) {
          leaveHistory.removeAt(event.index);
        }
        emit(state.copyWith(
            status: FetchStatus.sendSuccess,
            leaveHistoryData: leaveHistory,
            triggerDate: DateTime.now()));
      });
    });

    on<GetAllLeaveData>((event, emit) async {
      List<LeaveHistoryEntity> leaveHistory = state.leaveHistoryData;
      List<ManagerLeave> managerData = [];
      List<HolidayLeaveEntity> holidayLeave = [];
      LeaveSettingEntity? leaveSetting;
      bool isErrorOccur = false;
      emit(state.copyWith(status: FetchStatus.fetching));
      var resLeaveHistory =
          await getLeaveHistory(state.startPeriodDate ?? DateTime.now());
      var resManager = await getManagerLeave();
      var resHolidayLeave = await getHolidayLeave();
      var resLeave = await getLeaveSettingData();
        resLeave.fold(
            (l){
              emit(state.copyWith(status: FetchStatus.failed, error: l));
              isErrorOccur = true;
            },
            (r) => leaveSetting = r);
      resHolidayLeave.fold(
          (l) { emit(state.copyWith(status: FetchStatus.failed, error: l)); isErrorOccur = true;},
          (r) => holidayLeave = r);
      resLeaveHistory.fold(
              (l) { emit(state.copyWith(status: FetchStatus.failed, error: l)); isErrorOccur = true;},
          (r) => leaveHistory = r);
      resManager.fold(
              (l) { emit(state.copyWith(status: FetchStatus.failed, error: l)); isErrorOccur = true;},
          (r) => managerData = r);

      if(!isErrorOccur){
        emit(state.copyWith(
            status: FetchStatus.success,
            leaveHistoryData: leaveHistory,
            managerData: managerData,
            holidayLeave: holidayLeave,
            leaveSetting: leaveSetting,
        ));
      }else{
        emit(state.copyWith(status: FetchStatus.failed));
      }
    });

    on<SendLeaveRequestData>((event, emit) async {
      LeaveRequest data;
      emit(state.copyWith(status: FetchStatus.fetching));
      data = LeaveRequest(
          idLeaveType: event.leaveType.idLeaveType!.toString(),
          leaveType: event.leaveType.name!,
          description: event.note,
          start: event.startDay,
          end: event.endDay,
          idEmployees: event.idEmployees,
          used: event.used,
          quota: event.leaveType.leaveValue ?? 999,
          balance: 0,
          remaining: event.remaining,
          idManager: event.idManager,
          isApprove: null,
          isFullDay: event.isFullDay ? 1 : 0,
          isActive: 1,
          idHoliday: event.idHoliday,
          file: event.file?.files.first,
          managerEmail: event.managerEmail,
          idManagerGroup: event.idManagerGroup);
      final result = await sendLeaveRequest(data);
      result.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed, error: l)),
          (r) {
        emit(state.copyWith(
            status: FetchStatus.result,
            leaveType: event.leaveType.name!,
            startDay: event.startDay,
            endDay: event.endDay,
            note: event.note,
            uses: event.used,
            remainNow: event.remaining,
            holiday: event.idHoliday != null
                ? event.holidayLeave
                    .firstWhere((e) => e.idHoliday == event.idHoliday!)
                    .name
                : null));
      });
    });
  }
}
