part of 'leave_bloc.dart';

enum FetchStatus { fetching, success, failed, init, result , sendSuccess,sendFailed }

class LeaveState extends Equatable {
  final List<LeaveHistoryEntity> leaveHistoryData;
  final DateTime? startPeriodDate;
  final DateTime? endPeriodDate;
  final Map<String, List<double>> leaveKeyData;
  final List<HolidayLeaveEntity> holidayLeave;
  final List<DayCannotLeave> dayCannotLeave;
  final List<ManagerLeave> managerData;
  final FetchStatus status;
  final ErrorMessage? error;
  final String leaveType;
  final String? holiday;
  final DateTime? startDay;
  final DateTime? endDay;
  final String? note;
  final double uses;
  final double remainNow;
  final LeaveSettingEntity? leaveSetting;
  final List<LeaveAvailableEntity> leaveAvailableData;
  final DateTime? triggerDate; //! ใช้แค่เอาไว้ trigger event ให้มันไม่ซ้ำ

  const LeaveState({
    this.leaveHistoryData = const [],
    this.triggerDate,
    this.leaveKeyData = const {},
    this.holidayLeave = const [],
    this.status = FetchStatus.init,
    this.managerData = const [],
    this.dayCannotLeave = const [],
    this.error = null,
    this.leaveType = '',
    this.holiday,
    this.startDay,
    this.startPeriodDate,
    this.endPeriodDate,
    this.endDay,
    this.note,
    this.uses = 0,
    this.remainNow = 0,
    this.leaveSetting,
    this.leaveAvailableData = const [],
  });

  LeaveState copyWith({
    List<String>? leaveAuthList,
    DateTime? triggerDate,
    List<LeaveHistoryEntity>? leaveHistoryData,
    List<LeaveAuthorityEntity>? leaveAuthorityData,
    Map<String, List<double>>? leaveKeyData,
    List<HolidayLeaveEntity>? holidayLeave,
    List<DayCannotLeave>? dayCannotLeave,
    List<ManagerLeave>? managerData,
    FetchStatus? status,
    // List<LeaveAuthWithUsedRemaining>? leaveData,
    ErrorMessage? error,
    String? leaveType,
    String? holiday,
    DateTime? startDay,
    DateTime? startPeriodDate,
    DateTime? endPeriodDate,
    DateTime? endDay,
    String? note,
    double? uses,
    double? remainNow,
    LeaveSettingEntity? leaveSetting,
    List<LeaveAvailableEntity>? leaveAvailableData,
  }) {
    return LeaveState(
      triggerDate: triggerDate ?? this.triggerDate,
      leaveHistoryData: leaveHistoryData ?? this.leaveHistoryData,
      leaveKeyData: leaveKeyData ?? this.leaveKeyData,
      holidayLeave: holidayLeave ?? this.holidayLeave,
      status: status ?? this.status,
      startPeriodDate: startPeriodDate ?? this.startPeriodDate,
      endPeriodDate: endPeriodDate ?? this.endPeriodDate,
      managerData: managerData ?? this.managerData,
      dayCannotLeave: dayCannotLeave ?? this.dayCannotLeave,
      error: error ?? this.error,
      leaveType: leaveType ?? this.leaveType,
      holiday: holiday ?? this.holiday,
      startDay: startDay ?? this.startDay,
      endDay: endDay ?? this.endDay,
      note: note ?? this.note,
      uses: uses ?? this.uses,
      remainNow: remainNow ?? this.remainNow,
      leaveSetting: leaveSetting ?? this.leaveSetting,
      leaveAvailableData: leaveAvailableData ?? this.leaveAvailableData,
    );
  }

  @override
  List<Object?> get props => [
        leaveHistoryData,
        // leaveAuthorityData,
        leaveKeyData,
        holidayLeave,
        status,
        startPeriodDate,
        endPeriodDate,
        // leaveAuthList,
        // leaveData,
        triggerDate,
        managerData,
        dayCannotLeave,
        error,
        leaveType,
        holiday,
        startDay,
        endDay,
        note,
        uses,
        remainNow,
        leaveAvailableData,
        leaveSetting,
      ];
}

class LeaveInitial extends LeaveState {}


// class LeaveInitial extends LeaveState {
//   const LeaveInitial({
//     required super.leaveHistoryData,
//     required super.leaveAuthorityData,
//     // required super.used,
//     // required super.remaining,
//     required super.leaveAuthList,
//     required super.leaveData,
//     required super.managerData,
//     required super.dayCannotLeave,
//     required super.leaveKeyData, required super.holidayLeave,
//   });
//
//   @override
//   List<Object> get props => [];
// }
//
// class LeaveLoading extends LeaveState {
//   const LeaveLoading(
//       {required super.leaveHistoryData,
//       required super.leaveAuthorityData,
//       // required super.used,
//       // required super.remaining,
//       required super.leaveAuthList,
//       required super.leaveData,
//       required super.managerData,
//       required super.dayCannotLeave,
//         required super.leaveKeyData, required super.holidayLeave});
//
//   @override
//   List<Object?> get props => [];
// }
//
// class LeaveLoaded extends LeaveState {
//   const LeaveLoaded(
//       {required super.leaveHistoryData,
//       required super.leaveAuthorityData,
//       // required super.used,
//       // required super.remaining,
//       required super.leaveAuthList,
//       required super.leaveData,
//       required super.managerData,
//       required super.dayCannotLeave,
//         required super.leaveKeyData, required super.holidayLeave});
//
//   @override
//   List<Object?> get props => [
//     // used, remaining,
//     dayCannotLeave];
// }
//
// class LeaveFailure extends LeaveState {
//   final Failure error;
//
//   const LeaveFailure(
//       {required super.leaveHistoryData,
//       required this.error,
//       required super.leaveAuthorityData,
//       // required super.used,
//       // required super.remaining,
//       required super.leaveAuthList,
//       required super.leaveData,
//       required super.managerData,
//       required super.dayCannotLeave,
//         required super.leaveKeyData, required super.holidayLeave});
//
//   @override
//   List<Object?> get props => [error];
// }
//
// class LeaveResult extends LeaveState {
//   final String leaveType;
//
//   final String? holiday;
//   final DateTime startDay;
//   final DateTime endDay;
//   final String? note;
//   final double uses;
//   final double remainNow;
//
//   const LeaveResult({
//     required this.leaveType,
//     required this.startDay,
//     required this.endDay,
//     required this.note,
//     required this.uses,
//     required this.remainNow,
//     required super.leaveHistoryData,
//     required super.leaveAuthorityData,
//     required this.holiday,
//     // required super.used,
//     // required super.remaining,
//     required super.leaveAuthList,
//     required super.leaveData,
//     required super.managerData,
//     required super.dayCannotLeave,
//     required super.leaveKeyData, required super.holidayLeave,
//   });
//
//   @override
//   List<Object?> get props => [leaveType, startDay, endDay, note, uses];
// }
