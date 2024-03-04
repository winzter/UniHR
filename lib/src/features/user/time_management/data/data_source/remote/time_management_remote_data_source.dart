import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/core/constanst/network_api.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/shift_change.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';

abstract class TimeManagementRemoteDataSource {
  Future<List<ShiftModel>> getShift();
  Future<List<TimeScheduleModel>> getTimeSchedule(String startDate);
  Future<List<HolidayModel>> getHoliday();
  Future<List<CheckHolidayModel>> getCheckHoliday(String startDate);
  Future<void> sendShiftChange(ShiftChange data);
  Future<void> withDrawChangeTime(int idEmployeeShiftDaily,int idEmployees);
}

class TimeManagementRemoteDataSourceImpl
    implements TimeManagementRemoteDataSource {
  final Dio dio;

  TimeManagementRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ShiftModel>> getShift() async {
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/shift',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return shiftEntityFromJson(jsonEncode(response.data));
  }

  @override
  Future<List<TimeScheduleModel>> getTimeSchedule(String startDate) async {
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/time-schedule',
        queryParameters: {'start': startDate},
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return timeScheduleModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<List<HolidayModel>> getHoliday() async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/holiday/${DateFormat("yyyy").format(DateTime.now())}',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return holidayEntityFromJson(jsonEncode(response.data));
  }

  @override
  Future<void> sendShiftChange(ShiftChange data) async{
    final response = await dio.post('${NetworkAPI.baseURL}/api/employees/change-time',
        data: jsonEncode({
          'idEmployees':data.idEmployees,
          'idShift':data.idShift,
          'idShiftType':data.idShiftType,
          'workingDate':DateFormat("yyyy-MM-dd").format(data.workingDate),
          'idShiftGroup':data.idShiftGroup,
          'isWorkingDay':data.isWorkingDay,
          'idHoliday':data.idHoliday
        }),
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}',"Content-Type": "application/json;charset=UTF-8",},
        ));
    if (response.statusCode == 200) {
      log("Change Time Success");
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<void> withDrawChangeTime(int idEmployeeShiftDaily, int idEmployees) async {
    final response = await dio.put('${NetworkAPI.baseURL}/api/employees/change-time/withdraw',
        data: jsonEncode({
          'idEmployeeShiftDaily':idEmployeeShiftDaily,
          'idEmployees':idEmployees,
        }),
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}',"Content-Type": "application/json;charset=UTF-8",},
        ));
    if (response.statusCode == 200) {
      log("Withdraw Change Time Success");
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<CheckHolidayModel>> getCheckHoliday(String startDate) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/time-schedule-holiday-used?start=$startDate',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return checkHolidayModelFromJson(jsonEncode(response.data));
  }
}
