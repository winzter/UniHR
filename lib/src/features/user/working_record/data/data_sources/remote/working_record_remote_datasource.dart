import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/is_checkin_model.dart';

abstract class WorkingRecordRemoteDataSource {
  Future<void> sendWorkingRecord(
    String? description,
    int idCompany,
    int idEmp,
    bool isCheckIn,
    double lat,
    double lng,
    String locationName,
  );

  Future<IsCheckInModel> isCheckIn(
      int idEmp,
      );
}

class WorkingRecordRemoteDataSourceImpl
    implements WorkingRecordRemoteDataSource {
  final http.Client client;

  WorkingRecordRemoteDataSourceImpl({required this.client});

  @override
  Future<void> sendWorkingRecord(
    String? description,
    int idCompany,
    int idEmp,
    bool isCheckIn,
    double lat,
    double lng,
    String locationName,
  ) async {
    print(isCheckIn);
    final response =
        await client.post(Uri.parse("${NetworkAPI.baseURL}/api/addTimeline/"),
            headers: {
              'x-access-token': '${await LoginStorage.readToken()}',
              "Content-Type": "application/json;charset=UTF-8",
            },
            body: jsonEncode({
              'attendanceDateTime':
                  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
              'description': description??"",
              'idCompany': idCompany,
              'idEmployees': idEmp,
              'isCheckIn': isCheckIn,
              'latitude': lat,
              'locationName': locationName,
              'longitude': lng,
              'type': "time"
            }));

    if (response.statusCode == 200) {
      log("Working Recorded!");
    } else {
      throw ErrorException(message: 'Status Code : ${response.statusCode}');
    }
  }

  @override
  Future<IsCheckInModel> isCheckIn(int idEmp) async{
    final response = await client.get(Uri.parse('${NetworkAPI.baseURL}/api/getCheckTimelineById/time/$idEmp'),
      headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},);
    return isCheckInModelFromJson(response.body);
  }
}
