part of 'overview_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class OverviewState extends Equatable {
  final FetchStatus status;
  final List<DepartmentEntity> departmentData;
  final OverviewEntity? overviewData;
  final OvertimeEntity? overtimeData;
  final CostEntity? costData;
  final WorkingTimeEntity? workingTimeData;
  final DateTime? date;
  final int? idDepartment;
  final int? idSection;
  final ErrorMessage? error;

  final Map<int, String> divisionName;
  final Map<int, String> departmentName;
  final Map<int, String> sectionName;
  final String? selectedDivisionName;
  final String? selectedDepartmentName;
  final String? selectedSectionName;

  const OverviewState({
    this.status = FetchStatus.init,
    this.departmentData = const [],
    this.overviewData,
    this.divisionName = const {999: "ทั้งหมด"},
    this.departmentName = const {999: "ทั้งหมด"},
    this.sectionName = const {999: "ทั้งหมด"},
    this.date,
    this.idDepartment,
    this.idSection,
    this.overtimeData,
    this.workingTimeData,
    this.costData,
    this.selectedDepartmentName = "ทั้งหมด",
    this.selectedDivisionName = "ทั้งหมด",
    this.selectedSectionName = "ทั้งหมด",
    this.error = null,
  });

  OverviewState copyWith({
    FetchStatus? status,
    List<DepartmentEntity>? departmentData,
    OverviewEntity? overviewData,
    DateTime? date,
    int? idDepartment,
    int? idSection,
    OvertimeEntity? overtimeData,
    WorkingTimeEntity? workingTimeData,
    CostEntity? costData,
    Map<int, String>? divisionName,
    String? selectedDivisionName,
    Map<int, String>? departmentName,
    String? selectedDepartmentName,
    Map<int, String>? sectionName,
    String? selectedSectionName,
    ErrorMessage? error,
  }) {
    return OverviewState(
      status: status ?? this.status,
      departmentData: departmentData ?? this.departmentData,
      date: date ?? this.date,
      idSection: idSection ?? this.idSection,
      idDepartment: idDepartment ?? this.idDepartment,
      overviewData: overviewData ?? this.overviewData,
      overtimeData: overtimeData ?? this.overtimeData,
      workingTimeData: workingTimeData ?? this.workingTimeData,
      costData: costData ?? this.costData,
      divisionName: divisionName ?? this.divisionName,
      departmentName: departmentName ?? this.departmentName,
      sectionName: sectionName ?? this.sectionName,
      selectedDivisionName: selectedDivisionName ?? "ทั้งหมด",
      selectedSectionName: selectedSectionName ?? "ทั้งหมด",
      selectedDepartmentName: selectedDepartmentName ?? "ทั้งหมด",
      error: error??this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    departmentData,
    overviewData,
    date,
    idSection,
    idDepartment,
    overtimeData,
    workingTimeData,
    costData,
    divisionName,
    departmentName,
    sectionName,
    selectedDepartmentName,
    selectedSectionName,
    selectedDivisionName,
    error,
  ];
}

class OverviewInitial extends OverviewState {}
