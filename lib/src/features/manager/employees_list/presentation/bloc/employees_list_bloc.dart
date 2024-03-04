import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/each_emp_entity.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/employees_list_entity.dart';
import '../../domain/use_cases/usecases.dart';

part 'employees_list_event.dart';

part 'employees_list_state.dart';

class EmployeesListBloc extends Bloc<EmployeesListEvent, EmployeesListState> {
  final GetEmployeesList getEmployeesList;
  final GetEachEmployee getEachEmployee;

  EmployeesListBloc({required this.getEmployeesList,required this.getEachEmployee})
      : super(EmployeesListInitial()) {
    on<GetEmployeesData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var res = await getEmployeesList();
      res.fold(
          (l) => emit(state.copyWith(status: FetchStatus.failed,error: l)),
          (r) {
            emit(state.copyWith(employeesData: r, status: FetchStatus.success,terminateEmpData: r.where((e) => e.isTerminate == 1).toList(),normalEmpData: r.where((e) => e.isTerminate == 0).toList(),));
          });
    });

    on<GetEachEmployeeData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var res = await getEachEmployee(event.idEmp);
      res.fold(
              (l) => emit(state.copyWith(status: FetchStatus.failed,error: l)),
              (r) {
            emit(state.copyWith(eachEmpData: r, status: FetchStatus.success,));
          });
    });
  }
}
