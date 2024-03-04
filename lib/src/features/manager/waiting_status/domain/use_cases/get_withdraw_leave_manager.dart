import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/manager/waiting_status/domain/repositories/waiting_status_repository.dart';
import '../entities/entities.dart';

class GetWithdrawLeaveManager{
  final WaitingStatusRepository repository;

  GetWithdrawLeaveManager({required this.repository});

  Future<Either<ErrorMessage,List<WithdrawLeaveManager>>> call({String? start , String? end}) async{
    return await repository.getWithdrawLeaveManager(start: start,end: end);
  }
}