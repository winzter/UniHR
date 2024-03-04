part of 'working_time_bloc.dart';

abstract class WorkingTimeState extends Equatable {
  final List<EmployeesAttendanceEntity> empAttendanceCheckIn;
  final List<EmployeesAttendanceEntity> empAttendanceCheckOut;
  final List<EmployeesLeaveEntity> empLeave;
  final List<EmployeesEntity> empData;
  WorkingTimeState({
    required this.empAttendanceCheckIn,
    required this.empLeave,
    required this.empAttendanceCheckOut,
    required this.empData
  });
}

class WorkingTimeInitial extends WorkingTimeState {
  WorkingTimeInitial({
    required super.empAttendanceCheckIn,
    required super.empLeave,
    required super.empAttendanceCheckOut,
    required super.empData,
  });
  @override
  List<Object> get props => [];
}

class WorkingTimeLoading extends WorkingTimeState{
  WorkingTimeLoading({
    required super.empAttendanceCheckIn,
    required super.empLeave,
    required super.empAttendanceCheckOut,
    required super.empData});

  @override
  List<Object?> get props => [];
}

class WorkingTimeLoaded extends WorkingTimeState{
  WorkingTimeLoaded({
    required super.empAttendanceCheckIn,
    required super.empLeave,
    required super.empAttendanceCheckOut,
    required super.empData});
  @override
  List<Object?> get props => [];
}

class WorkingTimeFailure extends WorkingTimeState{
  final ErrorMessage error;
  WorkingTimeFailure({
    required super.empAttendanceCheckIn,
    required super.empLeave,
    required this.error,
    required super.empAttendanceCheckOut,
    required super.empData});
  @override
  List<Object?> get props => [error];
}
