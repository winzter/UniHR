import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/is_checkin_entity.dart';
import '../repositories/working_record_repository.dart';

class IsCheckInWorkRecord {
  final WorkingRecordRepository repository;

  IsCheckInWorkRecord({required this.repository});

  Future<Either<ErrorMessage, IsCheckInEntity>> call(
      int idEmp,
      ) async {
    return await repository.isCheckInWorkRecord(idEmp);
  }
}
