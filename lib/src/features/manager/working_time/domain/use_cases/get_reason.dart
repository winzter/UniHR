import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/working_time_repository.dart';


class GetReasonManager {
  final WorkingTimeRepository repository;
  GetReasonManager({required this.repository});

  Future<Either<ErrorMessage, List<ReasonEntity>>> call() async {
    return await repository.getReasonManager();
  }
}