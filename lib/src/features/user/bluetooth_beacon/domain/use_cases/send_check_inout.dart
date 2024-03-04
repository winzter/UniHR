import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/bluetooth_beacon_repository.dart';

class SentCheckInOut {
  final BluetoothBeaconRepository repository;

  SentCheckInOut({required this.repository});

  Future<Either<ErrorMessage, void>> call(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      String idEmployee,
      String idCompany,
      ) async {
    return await repository.sentCheckInOut(
      attendanceDateTime,
      isCheckIn,
      idAttendanceType,
      idEmployee,
      idCompany,
    );
  }
}
