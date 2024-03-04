import 'package:equatable/equatable.dart';

class DayCannotLeave extends Equatable{
  final DateTime? date;
  final int? isActive;
  final int? workingMinutes;
  final int? workingHours;
  final int? breakTime;
  final String? timeIn;
  final String? timeOut;
  final int? isWorkingDay;
  final dynamic breakTimeMin;
  final dynamic startBreak;
  final dynamic holiday;

  DayCannotLeave({
    this.date,
    this.isActive,
    this.workingMinutes,
    this.workingHours,
    this.breakTime,
    this.timeIn,
    this.timeOut,
    this.isWorkingDay,
    this.breakTimeMin,
    this.startBreak,
    this.holiday,
  });

  @override
  List<Object?> get props => [
    date,
    isActive,
    workingMinutes,
    workingHours,
    breakTime,
    timeIn,
    timeOut,
    isWorkingDay,
    breakTimeMin,
    startBreak,
    holiday,
  ];

}
