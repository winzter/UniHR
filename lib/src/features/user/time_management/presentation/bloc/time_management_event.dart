part of 'time_management_bloc.dart';

abstract class TimeManagementEvent extends Equatable {
  const TimeManagementEvent();
}

class TimeManagementLoadScheduleData extends TimeManagementEvent {
  final String? startDate;

  final DateTime? date;

  TimeManagementLoadScheduleData({required this.startDate,required this.date,});

  @override
  List<Object?> get props => [startDate,date];
}

class TimeManagementLoadShiftData extends TimeManagementEvent {
  @override
  List<Object?> get props => [];
}

class GetCheckHolidayData extends TimeManagementEvent {
  final String startDate;

  GetCheckHolidayData({required this.startDate});

  @override
  List<Object?> get props => [startDate];
}

class SendChangeTimeData extends TimeManagementEvent {
  final DateTime date;
  final String shiftName;
  final int idShiftType;
  final int? idShiftGroup;
  final int idEmp;
  final int? idHoliday;
  final BuildContext context;
  final String shiftNowName;

  SendChangeTimeData({
    required this.idEmp,
    required this.shiftName,
    required this.idShiftType,
    required this.date,
    required this.idShiftGroup,
    required this.context,
    required this.shiftNowName,
    required this.idHoliday,
  });

  @override
  List<Object?> get props => [idEmp, shiftName, date, shiftNowName,idHoliday,idShiftGroup,idShiftType];
}

class ChangeDate extends TimeManagementEvent {
  final DateTime date;

  ChangeDate({required this.date});

  @override
  List<Object?> get props => [date];
}

class WithdrawTimeRequest extends TimeManagementEvent {
  final int idEmployeeShiftDaily;
  final int idEmployees;

  WithdrawTimeRequest({required this.idEmployeeShiftDaily,required this.idEmployees});

  @override
  List<Object?> get props => [idEmployeeShiftDaily,idEmployees];
}
