part of 'working_time_bloc.dart';

abstract class WorkingTimeEvent extends Equatable {
  const WorkingTimeEvent();
}

class GetWorkingTimeData extends WorkingTimeEvent{
  final String start;

  GetWorkingTimeData({required this.start});
  @override
  List<Object?> get props => [start];
}

class ShowSomeEmpAttendance extends WorkingTimeEvent{
  final int? empId;

  ShowSomeEmpAttendance({required this.empId});

  @override
  List<Object?> get props => [empId];

}
