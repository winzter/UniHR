import 'package:intl/intl.dart';
import 'package:unihr/src/features/user/noti_user/data/model/noti_attendance_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';

abstract class NotiattendanceRemoteDataSource {
  Future<List<NotiattendanceModel>> getNotiattendace();
}

class NotiattendanceRemoteDataSourceImpl
    implements NotiattendanceRemoteDataSource {
  final http.Client client;

  NotiattendanceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NotiattendanceModel>> getNotiattendace() async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=${DateFormat('yyyy-MM-dd').format(DateTime.now())}&end=${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return attendanceFromJson(response.body);
    } else
      throw ErrorException(message: "Server error occurred");
  }
}
