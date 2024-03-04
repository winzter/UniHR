import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/leave_repository.dart';

class DeleteLeaveHistory{
  final LeaveRepository repository;
  DeleteLeaveHistory({required this.repository});

  Future<Either<ErrorMessage,void>> call(LeaveHistoryEntity leaveData) async{
    return await repository.deleteLeaveHistory(leaveData);
  }
}