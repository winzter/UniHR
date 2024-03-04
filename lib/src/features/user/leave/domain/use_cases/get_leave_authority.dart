import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/leave_authority_entity.dart';
import '../repositories/leave_repository.dart';


class GetLeaveAuthority {
  final LeaveRepository repository;
  GetLeaveAuthority({required this.repository});

  Future<Either<ErrorMessage,List<LeaveAuthorityEntity>>>call() async{
    return await repository.getLeaveAuthority();
  }
}