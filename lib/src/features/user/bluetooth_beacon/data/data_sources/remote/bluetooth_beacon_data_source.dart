import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';

abstract class BluetoothBeaconRemoteDatasource{
  Future<void> sentCheckInOut(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      String idEmployee,
      String idCompany,
      );
}

class BluetoothBeaconRemoteDatasourceImpl implements BluetoothBeaconRemoteDatasource{

  final http.Client client;

  BluetoothBeaconRemoteDatasourceImpl({required this.client});

  @override
  Future<void> sentCheckInOut(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      String idEmployee,
      String idCompany,
      ) async{
    final response = await client.post(
        Uri.parse("${NetworkAPI.baseURL}/api/line/attendance"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8",
        },
        body: jsonEncode({
          'attendanceDateTime':attendanceDateTime,
          'isCheckIn':isCheckIn,
          'idAttendanceType':idAttendanceType,
          'idEmployees':idEmployee,
          'idCompany':idCompany,
        })
    );
    if (response.statusCode == 200) {
      log("CheckIn , CheckOut Success");
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

}