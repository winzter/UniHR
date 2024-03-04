part of 'employee_network_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class EmployeeNetworkState extends Equatable {
  final List<EmployeeNetworkEntity> allEmpData;
  final List<EmployeeNetworkEntity> allReserveEmpData;
  final EachEmployeeEntity? eachEmpData;

  final FetchStatus status;

  EmployeeNetworkState({
    this.allEmpData = const [],
    this.allReserveEmpData = const [],
    this.eachEmpData = null,
    this.status = FetchStatus.init,
  });

  EmployeeNetworkState copyWith({
    List<EmployeeNetworkEntity>? allEmpData,
    List<EmployeeNetworkEntity>? allReserveEmpData,
    EachEmployeeEntity? eachEmpData,
    FetchStatus? status,
  }) {
    return EmployeeNetworkState(
      allEmpData: allEmpData ?? this.allEmpData,
      eachEmpData: eachEmpData ?? this.eachEmpData,
      status: status ?? this.status,
      allReserveEmpData: allReserveEmpData ?? this.allReserveEmpData,
    );
  }

  @override
  List<Object?> get props => [
        allEmpData,
        eachEmpData,
        status,
        allReserveEmpData,
      ];
}

class EmployeeNetworkInitial extends EmployeeNetworkState {
  @override
  List<Object> get props => [];
}
