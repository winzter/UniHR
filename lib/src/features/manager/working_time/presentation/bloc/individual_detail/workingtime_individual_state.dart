part of 'workingtime_individual_bloc.dart';

abstract class WorkingTimeIndividualState extends Equatable {
  final List<EmployeesEntity> empData;
  final List<TimeLineEntity> empAttendanceData;
  final List<String> reasons;
  WorkingTimeIndividualState({
    required this.empData,
    required this.empAttendanceData,
    required this.reasons
  });
}

class WorkingTimeIndividualInitial extends WorkingTimeIndividualState {
  WorkingTimeIndividualInitial({
    required super.empData,
    required super.empAttendanceData,
    required super.reasons});
  @override
  List<Object> get props => [];
}

class WorkingTimeIndividualLoading extends WorkingTimeIndividualState{


  WorkingTimeIndividualLoading({

    required super.empData,
    required super.empAttendanceData,
    required super.reasons});
  @override
  List<Object?> get props => [];

}

class WorkingTimeIndividualLoaded extends WorkingTimeIndividualState{
  final List<TimeLineEntity> showingData;
  final int? idEmp;
  WorkingTimeIndividualLoaded({
    required this.idEmp,
    required this.showingData,
    required super.empData,
    required super.empAttendanceData,
    required super.reasons});
  @override
  List<Object?> get props => [showingData,idEmp];

}

class WorkingTimeIndividualFailure extends WorkingTimeIndividualState{
  final ErrorMessage error;
  WorkingTimeIndividualFailure({
    required super.empData,
    required this.error,
    required super.empAttendanceData,
    required super.reasons});
  @override
  List<Object?> get props => [error];

}

class SendTimeRequestSuccess extends WorkingTimeIndividualState{
  SendTimeRequestSuccess({
    required super.empData,
    required super.empAttendanceData,
    required super.reasons});
  @override
  List<Object?> get props => [];

}
