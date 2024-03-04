part of 'employees_list_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class EmployeesListState extends Equatable {
  final FetchStatus status;
  final ErrorMessage? error;
  final List<EmployeesListEntity> employeesData;
  final List<EmployeesListEntity> terminateEmpData;
  final List<EmployeesListEntity> normalEmpData;

  final EachEmployeeEntity? eachEmpData;

  const EmployeesListState({
    this.employeesData = const [],
    this.status = FetchStatus.init,
    this.terminateEmpData = const [],
    this.normalEmpData = const [],
    this.eachEmpData,
    this.error = null,
  });

  EmployeesListState copyWith({
    List<EmployeesListEntity>? employeesData,
    FetchStatus? status,
    List<EmployeesListEntity>? terminateEmpData,
    List<EmployeesListEntity>? normalEmpData,
    EachEmployeeEntity? eachEmpData,
    ErrorMessage? error,
  }) {
    return EmployeesListState(
      employeesData: employeesData ?? this.employeesData,
      status: status ?? this.status,
      terminateEmpData: terminateEmpData ?? this.terminateEmpData,
      normalEmpData: normalEmpData ?? this.normalEmpData,
      eachEmpData: eachEmpData ?? this.eachEmpData,
      error: error??this.error,
    );
  }

  @override
  List<Object?> get props => [
    employeesData,
    status,
    terminateEmpData,
    normalEmpData,
    eachEmpData,
    error
  ];
}

class EmployeesListInitial extends EmployeesListState {}
