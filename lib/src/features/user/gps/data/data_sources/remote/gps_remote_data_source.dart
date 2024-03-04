import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:unihr/src/features/user/gps/data/models/beacons_model.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/location_model.dart';

abstract class GpsRemoteDatasource{
  Future<LineCheckInModel> getLocation(int idEmp);
  Future<List<BeaconsModel>> getBeacons();
  Future<void> sendLocation(
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

class GpsRemoteDatasourceImpl implements GpsRemoteDatasource{
  final http.Client client;
  GpsRemoteDatasourceImpl({required this.client});

  @override
  Future<LineCheckInModel> getLocation(int idEmp) async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/line/profile/$idEmp?source=pwa"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return lineCheckInFromJson(response.body);
  }

  @override
  Future<void> sendLocation(
      String attendanceDateTime,
      int isCheckIn,
      int idAttendanceType,
      int idGpsLocation,
      String idEmployee,
      String idCompany,
      String? address,
      double? lat,
      double? lng,
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
        'idGpsLocations':idGpsLocation,
        'idEmployees':idEmployee,
        'idCompany':idCompany,
        if(address != null)
          'gpsAddress':address,
        'latitude': lat,
        'longitude':lng
      })
    );
    if (response.statusCode == 200) {
      log("CheckIn , CheckOut Success");
    } else {
      throw ErrorException(message: "ไม่สามารถส่งข้อมูลได้ กรุณาติดต่อแอดมิน");
    }
  }

  @override
  Future<List<BeaconsModel>> getBeacons() async{
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/beacons"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return beaconsModelFromJson(response.body);
  }

}