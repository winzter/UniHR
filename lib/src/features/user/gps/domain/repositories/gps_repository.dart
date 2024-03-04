import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/gps/domain/entities/beacons_entity.dart';
import '../../../../../core/error/failures.dart';
import '../entities/location_entity.dart';

abstract class GpsRepository {
  Future<Either<ErrorMessage, LineCheckIn>> getLocation(int idEmp);
  Future<Either<ErrorMessage, List<BeaconsEntity>>> getBeacons();

  Future<Either<ErrorMessage, void>> sentLocation(
    String attendanceDateTime,
    int isCheckIn,
    int idAttendanceType,
    int idGpsLocation,
    String idEmployee,
    String idCompany,
    String? address,
    double? lat,
    double? lng,
  );
}
