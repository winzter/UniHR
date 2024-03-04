import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/working_time_repository.dart';

class GetEmployees{
  final WorkingTimeRepository repository;

  GetEmployees({required this.repository});

  Future<Either<ErrorMessage,List<EmployeesEntity>>> call() async{
    return await repository.getEmployees();
  }
}