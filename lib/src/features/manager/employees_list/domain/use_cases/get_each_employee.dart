import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/each_emp_entity.dart';
import 'package:unihr/src/features/manager/employees_list/domain/repositories/employees_repository.dart';
import '../../../../../core/error/failures.dart';

class GetEachEmployee{
  final EmployeesListRepository repository;
  GetEachEmployee({required this.repository});

  Future<Either<ErrorMessage, EachEmployeeEntity>> call(int idEmp) async{
    return await repository.getEachEmployee(idEmp);
  }
}