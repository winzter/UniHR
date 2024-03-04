import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../../../../user/item_status/data/models/models.dart';
import '../../models/models.dart';
import '../send_data/change_time.dart';

abstract class WaitingStatusRemoteDataSource {
  Future<List<RequestTimeManagerModel>> getRequestTimeManager(
      {String? start, String? end});
  Future<List<LeaveRequestManagerModel>> getLeaveRequestManager(
      {String? start, String? end});
  Future<List<ChangeTimeManagerModel>> getChangeTimeManager();
  Future<List<WithdrawLeaveManagerModel>> getWithdrawLeaveManager(
      {String? start, String? end});
  Future<PayrollSettingModel> getPayrollSetting();
  Future<void> isLeaveApprove(String commentManager, List<int> idLeave,
      int isApprove, List<int>? idLeaveEmployeesWithdraw);
  Future<void> isRequestTimeApprove(
    String commentManagerLV1,
    String commentManagerLV2,
    List<int> idRequestTimeLv1,
    int isManagerLV1Approve,
    int? isManagerLV2Approve,
    List<int> idRequestTimeLv2,
  );

  Future<void> isChangeTimeManagerApprove(
      List<ChangeTimeSendData> sendChangeTimeData);
}

class WaitingStatusRemoteDataSourceImpl
    implements WaitingStatusRemoteDataSource {
  final http.Client client;

  WaitingStatusRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ChangeTimeManagerModel>> getChangeTimeManager() async {
    final response = await client.get(
      Uri.parse(
          "${NetworkAPI.baseURL}/api/employees/change-time?filter=manager"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return changeTimeManagerModelFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<LeaveRequestManagerModel>> getLeaveRequestManager(
      {String? start, String? end}) async {
    final response = (start != null && end != null)
        ? await client.get(
            Uri.parse(
                "${NetworkAPI.baseURL}/api/request/leave?filter=manager&start=$start&end=$end"),
            headers: {'x-access-token': '${await LoginStorage.readToken()}'},
          )
        : await client.get(
            Uri.parse(
                "${NetworkAPI.baseURL}/api/request/leave?filter=manager"),
            headers: {'x-access-token': '${await LoginStorage.readToken()}'},
          );
    if (response.statusCode == 200) {
      return leaveRequestManagerFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<RequestTimeManagerModel>> getRequestTimeManager(
      {String? start, String? end}) async {
    final response = (start != null && end != null)
        ? await client.get(
            Uri.parse(
                "${NetworkAPI.baseURL}/api/request-time?filter=manager&start=$start&end=$end"),
            headers: {'x-access-token': '${await LoginStorage.readToken()}'},
          )
        : await client.get(
            Uri.parse(
                "${NetworkAPI.baseURL}/api/request-time?filter=manager"),
            headers: {
              'x-access-token': '${await LoginStorage.readToken()}',
            },
          );
    if (response.statusCode == 200) {
      return requestTimeManagerModelFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<WithdrawLeaveManagerModel>> getWithdrawLeaveManager(
      {String? start, String? end}) async {
    final response = (start != null && end != null)
        ? await client.get(
            Uri.parse(
                "${NetworkAPI.baseURL}/api/request/leave/withdraw?filter=manager&start=$start&end=$end"),
            headers: {'x-access-token': '${await LoginStorage.readToken()}'},
          )
        : await client.get(
            Uri.parse(//api/request/leave/withdraw?filter=manager
                "${NetworkAPI.baseURL}/api/request/leave/withdraw?filter=manager"),
            headers: {'x-access-token': '${await LoginStorage.readToken()}'},
          );
    if (response.statusCode == 200) {
      return withdrawManagerFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<PayrollSettingModel> getPayrollSetting() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/payroll-setting"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return payrollSettingModelFromJson(response.body);
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<void> isLeaveApprove(String commentManager, List<int> idLeave,
      int isApprove, List<int>? idLeaveEmployeesWithdraw) async {
    final response = await client.put(
        Uri.parse(
            "${NetworkAPI.baseURL}/api/request/leave/approve?filter=manager"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8"
        },
        body: jsonEncode([
          {
            "approveDate":
                DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now()),
            "commentManager": commentManager,
            "idLeave": idLeave,
            "isApprove": isApprove
          },
          {
            "commentManager": commentManager,
            "idLeave": idLeaveEmployeesWithdraw,
            "idLeaveEmployeesWithdraw": idLeaveEmployeesWithdraw,
            "isApprove": isApprove
          }
        ]));
    if (response.statusCode == 200) {
      log("Leave Approve Success : ${response.body}");
    } else {
      throw ErrorException(message: "${response.statusCode}");
    }
  }

  @override
  Future<void> isRequestTimeApprove(
      String commentManagerLV1,
      String commentManagerLV2,
      List<int> idRequestTimeLv1,
      int isManagerLV1Approve,
      int? isManagerLV2Approve,
      List<int> idRequestTimeLv2) async {
    final response = await client.put(
        Uri.parse(
            "${NetworkAPI.baseURL}/api/request-time/approve?filter=manager"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8"
        },
        body: jsonEncode([
          {
            "approveDate":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            "commentManagerLV1":
                commentManagerLV1 == "" ? null : commentManagerLV1,
            "idRequestTimeLV1": idRequestTimeLv1,
            "isManagerLV1Approve": isManagerLV1Approve
          },
          {
            "approveDate":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            "commentManagerLV2":
                commentManagerLV2 == "" ? null : commentManagerLV2,
            "idRequestTimeLV2": idRequestTimeLv2,
            "isManagerLV2Approve": isManagerLV2Approve
          },
          {
            "commentManager":
                commentManagerLV1 == "" ? null : commentManagerLV1,
            "idRequestTime": [],
            "idRequestTimeWithdraw": [],
            "isApprove": isManagerLV1Approve,
          }
        ]));
    if (response.statusCode == 200) {
      log("Request Time Approve Success : ${response.body}");
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<void> isChangeTimeManagerApprove(
      List<ChangeTimeSendData> sendChangeTimeData) async {
    List<dynamic> data = [];
    sendChangeTimeData.forEach((element) {
      data.add({
        "approveBy": element.approveBy,
        "approveComment": element.approveComment,
        "approveDate": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        "approveDateText": "Invalid Date",
        "createDate":
            DateFormat("yyyy-MM-dd HH:mm:ss").format(element.createDate),
        "departmentName": element.departmentName,
        "fillInApprove": element.fillInApprove,
        "fillInChange": element.fillInChange,
        "firstname_TH": element.firstname_TH,
        "holidayName": element.holidayName,
        "idEmployeeShiftDaily": element.idEmployeeShiftDaily,
        "idEmployees": element.idEmployees,
        "idHoliday": element.idHoliday,
        "idShift": element.idShift,
        "idShiftGroup": element.idShiftGroup,
        "idShiftType": element.idShiftType,
        "isActive": element.isActive,
        "isApprove": element.isApprove,
        "isWorkingDay": element.isWorkingDay,
        "lastname_TH": element.lastname_TH,
        "positionName": element.positionName,
        "shiftGroupName": element.shiftGroupName,
        "workingDate":
            DateFormat("yyyy-MM-dd HH:mm:ss").format(element.workingDate),
        "workingDateText": "Invalid Date",
      });
    });
    final response = await client.put(
        Uri.parse("${NetworkAPI.baseURL}/api/employees/change-time/approve"),
        headers: {
          'x-access-token': '${await LoginStorage.readToken()}',
          "Content-Type": "application/json;charset=UTF-8",
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      log("Change Time Approve Success : ${response.body}");
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }
}
