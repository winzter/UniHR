import 'package:intl/intl.dart';
import '../../../../../constanst/network_api.dart';
import '../../../../../error/exception.dart';
import '../../../../../storage/secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/attendance_model.dart';

abstract class AttendanceRemoteDataSource{
  Future<List<AttendanceModel>> getAttendance();
  Future<List<AttendanceModel>> getAttendanceByDate(String start,String end);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource{
  final http.Client client;

  AttendanceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AttendanceModel>> getAttendance() async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=${DateFormat('yyyy-MM-dd').format(DateTime.now())}&end=${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return attendanceFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred status : ${response.statusCode}");
    }
  }

  @override
  Future<List<AttendanceModel>> getAttendanceByDate(String start, String end) async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return attendanceFromJson(response.body);
    }
    else {
      throw ErrorException(message: "Server error occurred status : ${response.statusCode}");
    }
  }
  
}