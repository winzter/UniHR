import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/is_checkin_entity.dart';

abstract class WorkingRecordRepository {
  Future<Either<ErrorMessage, void>> sendWorkingRecord(
    String? description,
    int idCompany,
    int idEmp,
    bool isCheckIn,
    double lat,
    double lng,
    String locationName,
  );

  Future<Either<ErrorMessage, IsCheckInEntity>> isCheckInWorkRecord(
      int idEmp,
      );
}
