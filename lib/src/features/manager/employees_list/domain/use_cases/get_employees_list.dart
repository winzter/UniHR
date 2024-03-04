import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/employees_list_entity.dart';
import 'package:unihr/src/features/manager/employees_list/domain/repositories/employees_repository.dart';
import '../../../../../core/error/failures.dart';

class GetEmployeesList{
  final EmployeesListRepository repository;
  GetEmployeesList({required this.repository});

  Future<Either<ErrorMessage, List<EmployeesListEntity>>> call() async{
    return await repository.getEmployeesList();
  }
}