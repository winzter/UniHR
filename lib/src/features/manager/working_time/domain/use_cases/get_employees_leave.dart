import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/working_time_repository.dart';


class GetEmployeesLeave{
  final WorkingTimeRepository repository;

  GetEmployeesLeave({required this.repository});

  Future<Either<ErrorMessage,List<EmployeesLeaveEntity>>> call(String start) async{
    return await repository.getEmployeesLeave(start);
  }
}