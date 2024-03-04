import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../leave_request.dart';
import '../../models/models.dart';
import 'package:http/http.dart' as http;

abstract class LeaveRemoteDataSource {
  Future<List<LeaveHistoryModel>> getLeaveHistory(DateTime year);
  Future<LeaveSettingModel> getLeaveSetting();
  Future<List<LeaveAvailableModel>> getLeaveAvailable(DateTime start);
  Future<List<HolidayLeaveModel>> getHolidayLeave();
  Future<void> deleteLeaveHistory(LeaveHistoryModel leaveData);
  Future<List<LeaveAuthorityModel>> getLeaveAuthority();
  Future<List<ManagerLeaveModel>> getManagerLeave();
  Future<List<DayCannotLeaveModel>> getDayCannotLeave(
      DateTime start, DateTime end, int idEmp);
  Future<void> sendLeaveRequest(LeaveRequest data);
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final http.Client client;
  final Dio dio;

  LeaveRemoteDataSourceImpl({required this.client, required this.dio});

  @override
  Future<void> deleteLeaveHistory(LeaveHistoryModel leaveData) async {
    final response = await client.put(
        Uri.parse("${NetworkAPI.baseURL}/api/request/leave/withdraw"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8"
        },
        body: jsonEncode({'idLeave': leaveData.idLeave}));
    if (response.statusCode != 200) {
      throw ErrorException(message: "Server Error : ${response.statusCode}");
    }
  }

  @override
  Future<List<LeaveAuthorityModel>> getLeaveAuthority() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/employee/leave"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return leaveAuthorityDataFromJson(response.body);
  }

  @override
  Future<List<LeaveHistoryModel>> getLeaveHistory(DateTime year) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/leave/year?filter=${DateFormat('yyyy').format(year)}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return leaveHistoryDataFromJson(response.body);
  }

  @override
  Future<void> sendLeaveRequest(LeaveRequest data) async {
    FormData sendData = FormData.fromMap({
      'idLeaveType': data.idLeaveType.toString(),
      'description': data.description == null ? null.toString() : '"${data.description}"',
      'start': '"${data.start}"',
      'end': '"${data.end}"',
      'idEmployees': data.idEmployees.toString(),
      'used': data.used.toString(),
      'quota': data.quota.toString(),
      'balance': (data.used).toString(),
      'remaining': data.remaining.toStringAsFixed(2),
      'idManager': data.idManager.toString(),
      'isApprove': null.toString(),
      'isFullDay': data.isFullDay.toString(),
      'isActive': data.isActive.toString(),
      'idHoliday': data.idHoliday.toString(),
      'cc_email': data.managerEmail != null
          ? '"${data.managerEmail}"'
          : null.toString(),
      'idManagerGroup': data.idManagerGroup.toString(),
      if (data.file != null)
        'file': await MultipartFile.fromFile(data.file!.path!,
            filename: data.file!.name)
    });
    var response = await dio.post("${NetworkAPI.baseURL}/api/employee/leave",
        options: Options(
          headers: {
            "x-access-token": "${await LoginStorage.readToken()}",
            'Content-Type': 'multipart/form-data',
          },
        ),
        data: sendData);
    if(response.statusCode == 200 && response.data.toString() == "{errorCode:ERROR_DUPLICATED}"){
      throw ErrorException(message: "มีรายการขอลา ซ้ำกับรายการที่มีอยู่");
    }
    else if(response.statusCode != 200){
      throw Exception();
    }
  }

  @override
  Future<List<ManagerLeaveModel>> getManagerLeave() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/v2/manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return managerLeaveFromJson(response.body);
  }

  @override
  Future<List<DayCannotLeaveModel>> getDayCannotLeave(
      DateTime start, DateTime end, int idEmp) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/working-hours/$idEmp?startDate=${DateFormat("yyyy-MM-dd").format(start)}&endDate=${DateFormat("yyyy-MM-dd").format(end)}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return dayCannotLeaveModelFromJson(response.body);

  }

  @override
  Future<List<HolidayLeaveModel>> getHolidayLeave() async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/holiday/${DateFormat('yyyy').format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return holidayLeaveModelFromJson(response.body);
  }

  @override
  Future<List<LeaveAvailableModel>> getLeaveAvailable(DateTime start) async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/leave/leave-available?date=${DateFormat('yyyy-MM-dd').format(start)}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return leaveAvailableModelFromJson(response.body);

  }

  @override
  Future<LeaveSettingModel> getLeaveSetting() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/leave-setting"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return leaveSettingModelFromJson(response.body);
  }
}
