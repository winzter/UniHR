import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/leave_repository.dart';

class GetManagerLeave{
  final LeaveRepository repository;
  const GetManagerLeave({required this.repository});

  Future<Either<ErrorMessage,List<ManagerLeave>>> call() async{
    return await repository.getManagerLeave();
  }
}