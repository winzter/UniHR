import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/working_time_repository.dart';


class GetEmployeesAttendance{
  final WorkingTimeRepository repository;

  GetEmployeesAttendance({required this.repository});

  Future<Either<ErrorMessage,List<EmployeesAttendanceEntity>>> call(String start) async{
    return await repository.getEmployeesAttendance(start);
  }
}