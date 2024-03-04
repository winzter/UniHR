import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class EmployeeNetworkRepository{
  Future<Either<ErrorMessage, List<EmployeeNetworkEntity>>> getEmployeeNetworkData();
  Future<Either<ErrorMessage, EachEmployeeEntity>> getEachEmployeeData(int idEmp);
}