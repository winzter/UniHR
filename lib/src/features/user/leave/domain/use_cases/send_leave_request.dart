import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/data_sources/leave_request.dart';
import '../repositories/leave_repository.dart';

class SendLeaveRequest{
  final LeaveRepository repository;
  const SendLeaveRequest({required this.repository});

  Future<Either<ErrorMessage,void>> call(LeaveRequest data) async{
    return await repository.sendLeaveRequest(data);
  }
}