import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/gps_repository.dart';

class SendLocation {
  final GpsRepository repository;

  SendLocation({required this.repository});

  Future<Either<ErrorMessage, void>> call(
    String attendanceDateTime,
    int isCheckIn,
    int idAttendanceType,
    int idGpsLocation,
    String idEmployee,
    String idCompany,
    String? address,
    double? lat,
    double? lng,
  ) async {
    return await repository.sentLocation(
      attendanceDateTime,
      isCheckIn,
      idAttendanceType,
      idGpsLocation,
      idEmployee,
      idCompany,
      address,
      lat,
      lng,
    );
  }
}
