import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';

abstract class TravellingRepository {
  Future<Either<ErrorMessage, List<TravellingTimeLineEntity>>> getTimelineById(
    DateTime date,
    int idEmp,
  );

  Future<Either<ErrorMessage, IsCheckInEntity>> isCheckIn(
      int idEmp,
      );

  Future<Either<ErrorMessage, void>> sendRouteRecord(
    int idCompany,
    int idEmp,
    bool isCheckIn,
    double lat,
    String locationName,
    double lng,
    String mile,
    String type,
  );
}
