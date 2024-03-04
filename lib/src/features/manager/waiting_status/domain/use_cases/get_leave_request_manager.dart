import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/waiting_status/domain/repositories/waiting_status_repository.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';

class GetLeaveRequestManager{
  final WaitingStatusRepository repository;

  GetLeaveRequestManager({required this.repository});

  Future<Either<ErrorMessage,List<LeaveRequestManager>>> call({String? start , String? end}) async{
    return await repository.getLeaveRequestManager(start: start,end: end);
  }
}