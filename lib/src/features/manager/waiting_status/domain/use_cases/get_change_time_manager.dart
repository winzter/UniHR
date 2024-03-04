import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/waiting_status_repository.dart';

class GetChangeTimeManager{
  final WaitingStatusRepository repository;

  GetChangeTimeManager({required this.repository});

  Future<Either<ErrorMessage,List<ChangeTimeManager>>> call() async{
    return await repository.getChangeTimeManager();
  }
}