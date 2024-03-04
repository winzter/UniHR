part of 'overview_bloc.dart';

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();
}

class GetDepartmentData extends OverviewEvent {
  @override
  List<Object?> get props => [];
}

class GetOverviewData extends OverviewEvent {
  final String year;
  final String month;

  GetOverviewData({
    required this.year,
    required this.month,
  });

  @override
  List<Object?> get props => [year, month];
}

class GetWorkingTimeData extends OverviewEvent {
  final String year;
  final String month;
  final int? idDepartment;
  final int? idSection;

  GetWorkingTimeData({
    required this.year,
    required this.month,
    this.idSection,
    this.idDepartment,
  });

  @override
  List<Object?> get props => [year, month, idDepartment, idSection];
}

class ChangeDate extends OverviewEvent {
  final DateTime date;

  ChangeDate({required this.date});

  @override
  List<Object?> get props => [date];
}

class DivisionChange extends OverviewEvent {
  final String divisionName;

  DivisionChange({required this.divisionName});

  @override
  List<Object?> get props => [divisionName];
}

class DepartmentChange extends OverviewEvent {
  final String departmentName;

  DepartmentChange({required this.departmentName});

  @override
  List<Object?> get props => [departmentName];
}

class SectionChange extends OverviewEvent {
  final String sectionName;

  SectionChange({required this.sectionName});

  @override
  List<Object?> get props => [sectionName];
}

class GetOvertimeData extends OverviewEvent {
  final String year;
  final String month;
  final int? idDepartment;
  final int? idSection;

  GetOvertimeData({
    required this.year,
    required this.month,
    this.idSection,
    this.idDepartment,
  });

  @override
  List<Object?> get props => [year, month, idDepartment, idSection];
}

class GetCostData extends OverviewEvent {
  final String year;
  final String month;
  final int? idDepartment;
  final int? idSection;

  GetCostData({
    required this.year,
    required this.month,
    this.idSection,
    this.idDepartment,
  });

  @override
  List<Object?> get props => [year, month, idDepartment, idSection];
}

class SearchOverviewData extends OverviewEvent {
  @override
  List<Object?> get props => [];
}
