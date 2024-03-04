import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class EmployeesListRepository {
  Future<Either<ErrorMessage,List<EmployeesListEntity>>> getEmployeesList();
  Future<Either<ErrorMessage,EachEmployeeEntity>> getEachEmployee(int idEmp);
}