import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';

abstract class BluetoothBeaconRepository {
  Future<Either<ErrorMessage,void>> sentCheckInOut(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      String idEmployee,
      String idCompany,
      );
}