import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/waiting_status_repository.dart';

class IsLeaveApprove {
  final WaitingStatusRepository repository;

  IsLeaveApprove({required this.repository});

  Future<Either<ErrorMessage, void>> call(
      {required String commentManager,
      required List<int> idLeave,
      required int isApprove,
      required List<int> idLeaveEmployeesWithdraw}) async {
    return await repository.isLeaveApprove(
        commentManager, idLeave, isApprove, idLeaveEmployeesWithdraw);
  }
}
