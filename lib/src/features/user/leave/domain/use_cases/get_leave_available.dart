import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/leave_repository.dart';

class GetLeaveAvailableData{
  final LeaveRepository repository;
  GetLeaveAvailableData({required this.repository});

  Future<Either<ErrorMessage,List<LeaveAvailableEntity>>> call(DateTime start) async{
    return await repository.getLeaveAvailableData(start);
  }
}