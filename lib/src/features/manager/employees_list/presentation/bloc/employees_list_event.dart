part of 'employees_list_bloc.dart';

abstract class EmployeesListEvent extends Equatable {
  const EmployeesListEvent();
}

class GetEmployeesData extends EmployeesListEvent {
  @override
  List<Object?> get props => [];
}

class GetEachEmployeeData extends EmployeesListEvent {
  final int idEmp;

  GetEachEmployeeData({required this.idEmp});

  @override
  List<Object?> get props => [idEmp];
}
