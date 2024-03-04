import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/exception.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../domain/repositories/bluetooth_beacon_repository.dart';
import '../data_sources/remote/bluetooth_beacon_data_source.dart';

class BluetoothBeaconRepositoryImpl implements BluetoothBeaconRepository {
  final BluetoothBeaconRemoteDatasource remoteDatasource;

  BluetoothBeaconRepositoryImpl({required this.remoteDatasource});


  @override
  Future<Either<ErrorMessage, void>> sentCheckInOut(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      String idEmployee,
      String idCompany,
      ) async {
    try {
      await remoteDatasource.sentCheckInOut(
        attendanceDateTime,
        isCheckIn,
        idAttendanceType,
        idEmployee,
        idCompany,
      );
      return const Right(null);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }
}
