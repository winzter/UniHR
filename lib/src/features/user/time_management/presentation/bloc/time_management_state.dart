part of 'time_management_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class TimeManagementState extends Equatable {
  final FetchStatus status;
  final ErrorMessage? error;
  final List<ShiftEntity> shiftData;
  final List<TimeScheduleEntity> timeScheduleData;
  // final List<HolidayEntity> holidayData;
  final Map<int, String> holidayData;
  final Map<int, String> holidayDataEn;
  final Map<int, List<dynamic>> shiftName;
  final DateTime? date;
  final List<int> holidayCheck;

  const TimeManagementState({
    this.shiftData = const [],
    this.status = FetchStatus.init,
    this.timeScheduleData = const [],
    this.shiftName = const {},
    this.holidayData = const {},
    this.holidayDataEn = const {},
    this.holidayCheck = const [],
    this.error = null,
    this.date = null,
  });

  TimeManagementState copyWith(
      {List<ShiftEntity>? shiftData,
      FetchStatus? status,
      List<TimeScheduleEntity>? timeScheduleData,
      // List<HolidayEntity>? holidayData,
      ErrorMessage? error,
      Map<int, String>? holidayData,
      Map<int, String>? holidayDataEn,
      List<int>? holidayCheck,
      Map<int, List<dynamic>>? shiftName,
      DateTime? date}) {
    return TimeManagementState(
      shiftData: shiftData ?? this.shiftData,
      status: status ?? this.status,
      timeScheduleData: timeScheduleData ?? this.timeScheduleData,
      shiftName: shiftName ?? this.shiftName,
      holidayData: holidayData ?? this.holidayData,
      holidayDataEn: holidayDataEn ?? this.holidayDataEn,
      date: date ?? this.date,
      holidayCheck: holidayCheck ?? this.holidayCheck,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        shiftData,
        status,
        timeScheduleData,
        shiftName,
        holidayData,
        holidayDataEn,
        date,
        holidayCheck,
        error,
      ];
}

class TimeManagementInitial extends TimeManagementState {}
