import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/entities.dart';
import '../../domain/use_cases/use_cases.dart';

part 'employee_network_event.dart';

part 'employee_network_state.dart';

class EmployeeNetworkBloc
    extends Bloc<EmployeeNetworkEvent, EmployeeNetworkState> {
  final GetEachEmployeeNetworkData getEachEmployeeNetworkData;
  final GetEmployeeNetworkData getEmployeeNetworkData;

  EmployeeNetworkBloc({
    required this.getEmployeeNetworkData,
    required this.getEachEmployeeNetworkData,
  }) : super(EmployeeNetworkInitial()) {
    on<GetAllEmpData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var res = await getEmployeeNetworkData();
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed)),
          (r) => emit(state.copyWith(
                status: FetchStatus.success,
                allEmpData: r,
                allReserveEmpData: r,
              )));
    });

    on<ShowSomeEmpData>((event, emit) {
      emit(state.copyWith(status: FetchStatus.fetching));

      if (event.empId != null) {
        emit(state.copyWith(status: FetchStatus.success, allEmpData: [
          ...state.allEmpData
              .where((element) => element.idEmployees == event.empId)
        ]));
      } else {
        emit(state.copyWith(
            status: FetchStatus.success, allEmpData: state.allReserveEmpData));
      }
    });

    on<GetEachEmpData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var res = await getEachEmployeeNetworkData(event.idEmp);
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed)),
          (r) => emit(
              state.copyWith(status: FetchStatus.success, eachEmpData: r)));
    });
  }
}
