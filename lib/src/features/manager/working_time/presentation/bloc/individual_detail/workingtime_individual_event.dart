part of 'workingtime_individual_bloc.dart';

abstract class WorkingTimeIndividualEvent extends Equatable {
  const WorkingTimeIndividualEvent();
}

class GetEmployeesData extends WorkingTimeIndividualEvent{
  @override
  List<Object?> get props => [];
}

class GetAttendanceEmpDateData extends WorkingTimeIndividualEvent{
  final int id;
  final String start;
  final String end;

  GetAttendanceEmpDateData({
    required this.id,
    required this.start,
    required this.end});

  @override
  List<Object?> get props => [
    id,
    start,
    end
  ];
}

class SendTimeRequestData extends WorkingTimeIndividualEvent{
  final CalculateTimeEntity result;
  final int idEmployee;
  final int idRequestType;
  final String requestReason;
  final String otherReason;
  final DateTime start;
  final DateTime end;
  final DateTime workEndDate;
  final String note;
  final EmployeesEntity profileData;

  const SendTimeRequestData({
    required this.result,
    required this.idEmployee,
    required this.idRequestType,
    required this.requestReason,
    required this.otherReason,
    required this.start,
    required this.end,
    required this.workEndDate,
    required this.note,
    required this.profileData,
  });
  @override
  List<Object?> get props => [
    result,
    idEmployee,
    idRequestType,
    requestReason,
    otherReason,
    start,
    end,
    workEndDate,
    note,
    profileData
  ];
}