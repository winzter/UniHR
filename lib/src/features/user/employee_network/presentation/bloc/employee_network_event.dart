part of 'employee_network_bloc.dart';

abstract class EmployeeNetworkEvent extends Equatable {
  const EmployeeNetworkEvent();
}

class GetAllEmpData extends EmployeeNetworkEvent{
  @override
  List<Object?> get props => [];

}

class GetEachEmpData extends EmployeeNetworkEvent{
  final int idEmp;
  GetEachEmpData({required this.idEmp});
  @override
  List<Object?> get props => [idEmp];

}

class ShowSomeEmpData extends EmployeeNetworkEvent{
  final int? empId;

  ShowSomeEmpData({required this.empId});

  @override
  List<Object?> get props => [empId];

}
