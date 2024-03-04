import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/features/profile/domain/entity/profile_entity.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../../domain/entities/entities.dart';
import '../../models/models.dart';

abstract class TimeLineRemoteDataSource{
  Future<List<TimeLineModel>> getAttendance();
  Future<PayrollSettingModel> getPayrollSettingTimeLine();
  Future<List<TimeLineModel>> getAttendanceByDate(String start,String end);
  Future<List<ReasonModel>> getReason(int idCompany);
  Future<ErrorTimeLineModel> sendTimeRequest(
      CalculateTimeEntity? result,
      double? amountHour,
      int idEmployee,
      int idRequestType,
      String requestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      ProfileEntity profileData,
      List<ReasonEntity> reasonAllData,
      );
}

class TimeLineRemoteDataSourceImpl implements TimeLineRemoteDataSource{
  final http.Client client;

  TimeLineRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TimeLineModel>> getAttendance() async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=${DateFormat('yyyy-MM-dd').format(DateTime.now())}&end=${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return timelineFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<TimeLineModel>> getAttendanceByDate(String start, String end) async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/attendance?start=$start&end=$end"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return timelineFromJson(response.body);
  }

  @override
  Future<List<ReasonModel>> getReason(int idCompany) async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/request/reason?idCompany=$idCompany"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return reasonFromJson(response.body);
  }

  @override
  Future<ErrorTimeLineModel> sendTimeRequest(
      CalculateTimeEntity? result,
      double? amountHour,
      int idEmployee,
      int idRequestType,
      String requestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      ProfileEntity profileData,
      List<ReasonEntity> reasonAllData,
      ) async{
    // log("isDoubleApproval ${idRequestType == 1?0:(amountHour!=null?( result?.xOTHoliday != 0?1:0):0)}");
    var response = await client.post(
      Uri.parse("${NetworkAPI.baseURL}/api/requestTimes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": "${await LoginStorage.readToken()}"
      },
      body: jsonEncode({
        'amountHours': amountHour!=null?amountHour:result?.xOT??0+(result?.xWorkingMonthlyHoliday??0)+(result?.xWorkingDailyHoliday??0)+(result?.xOTHoliday??0),
        'approvalLevel': idRequestType == 2?(result!.xOTHoliday!=0?2:1):1,
        'end': end.toString(),
        'idEmployees': idEmployee,
        'idManagerGroupLV1': profileData.idManagerGroupLv1,
        'idManagerGroupLV2': profileData.idManagerGroupLv2,
        'idRequestReason': reasonAllData.firstWhere((k) => k.name == requestReason).idRequestReason,
        'idRequestType': idRequestType,
        'isActive': 1,
        'isDoubleApproval':idRequestType == 1?0:(amountHour!=null?( result?.xOTHoliday != 0?1:0):0),
        'isManagerLV1Approve': null,
        'isManagerLV2Approve': null,
        'managerLV1ApproveBy': profileData.idManagerLv1,
        'managerLV2ApproveBy': profileData.idManagerLv2,
        'otherReason': otherReason,
        'start': start.toString(),
        'workDate': DateFormat('yyyy-MM-dd').format(workEndDate),
        'xOT': result?.xOT??0,
        'xOTHoliday': result?.xOTHoliday??0,
        'xWorkingDailyHoliday': result?.xWorkingDailyHoliday??0,
        'xWorkingMonthlyHoliday': result?.xWorkingMonthlyHoliday??0
      }
      ),
    );
    return errorTimeLineModelFromJson(response.body);
  }

  @override
  Future<PayrollSettingModel> getPayrollSettingTimeLine() async{
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/payroll-setting"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    return payrollSettingModelFromJson(response.body);
  }
  
}