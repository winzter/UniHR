import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/attendance_repository.dart';

class GetReason {
  final TimeLineRepository repository;
  GetReason({required this.repository});

  Future<Either<ErrorMessage, List<ReasonEntity>>> call(int idCompany) async {
    return await repository.getReason(idCompany);
  }
}