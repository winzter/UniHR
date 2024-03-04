import 'dart:convert';
import '../../domain/entities/entities.dart';

List<ChangeTimeManagerModel> changeTimeManagerModelFromJson(String str) =>
    List<ChangeTimeManagerModel>.from(
        json.decode(str).map((x) => ChangeTimeManagerModel.fromJson(x)));

String changeTimeManagerModelToJson(List<ChangeTimeManagerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangeTimeManagerModel extends ChangeTimeManager {
  const ChangeTimeManagerModel({
    required int? idEmployeeShiftDaily,
    required int? idEmployees,
    required int? idShift,
    required int? idShiftType,
    required DateTime? workingDate,
    required int? idShiftGroup,
    required int? isWorkingDay,
    required int? isApprove,
    required int? isActive,
    required DateTime? createDate,
    required int? approveBy,
    required DateTime? approveDate,
    required String? approveComment,
    required dynamic fillInApprove,
    required dynamic idHoliday,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? firstname_EN,
    required String? lastname_EN,
    required String? positionName,
    required String? positionName_EN,
    required dynamic departmentName,
    required String? shiftGroupName,
    required dynamic holidayName,
    required String? workingDateText,
    required String? approveDateText,
  }) : super(
          idEmployeeShiftDaily: idEmployeeShiftDaily,
          idEmployees: idEmployees,
          idShift: idShift,
          idShiftType: idShiftType,
          workingDate: workingDate,
          idShiftGroup: idShiftGroup,
          isWorkingDay: isWorkingDay,
          isApprove: isApprove,
          isActive: isActive,
          createDate: createDate,
          approveBy: approveBy,
          approveDate: approveDate,
          approveComment: approveComment,
          fillInApprove: fillInApprove,
          idHoliday: idHoliday,
          firstnameTh: firstnameTh,
          lastnameTh: lastnameTh,
          firstname_EN: firstname_EN,
          lastname_EN: lastname_EN,
          positionName: positionName,
          positionName_EN: positionName_EN,
          departmentName: departmentName,
          shiftGroupName: shiftGroupName,
          holidayName: holidayName,
          workingDateText: workingDateText,
          approveDateText: approveDateText,
        );

  factory ChangeTimeManagerModel.fromJson(Map<String, dynamic> json) =>
      ChangeTimeManagerModel(
        idEmployeeShiftDaily: json["idEmployeeShiftDaily"],
        idEmployees: json["idEmployees"],
        idShift: json["idShift"],
        idShiftType: json["idShiftType"],
        workingDate: json["workingDate"] == null
            ? null
            : DateTime.parse(json["workingDate"]),
        idShiftGroup: json["idShiftGroup"],
        isWorkingDay: json["isWorkingDay"],
        isApprove: json["isApprove"],
        isActive: json["isActive"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        approveBy: json["approveBy"],
        approveDate: json["approveDate"] == null
            ? null
            : DateTime.parse(json["approveDate"]),
        approveComment: json["approveComment"],
        fillInApprove: json["fillInApprove"],
        idHoliday: json["idHoliday"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        firstname_EN: json["firstname_EN"],
        lastname_EN: json["lastname_EN"],
        positionName: json["positionName"],
        positionName_EN: json["positionName_EN"],
        departmentName: json["departmentName"],
        shiftGroupName: json["shiftGroupName"],
        holidayName: json["holidayName"],
        workingDateText: json["workingDateText"],
        approveDateText: json["approveDateText"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployeeShiftDaily": idEmployeeShiftDaily,
        "idEmployees": idEmployees,
        "idShift": idShift,
        "idShiftType": idShiftType,
        "workingDate": workingDate?.toIso8601String(),
        "idShiftGroup": idShiftGroup,
        "isWorkingDay": isWorkingDay,
        "isApprove": isApprove,
        "isActive": isActive,
        "createDate": createDate?.toIso8601String(),
        "approveBy": approveBy,
        "approveDate": approveDate?.toIso8601String(),
        "approveComment": approveComment,
        "fillInApprove": fillInApprove,
        "idHoliday": idHoliday,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "positionName": positionName,
        "firstname_EN": firstname_EN,
        "lastname_EN": lastname_EN,
        "positionName_EN": positionName_EN,
        "departmentName": departmentName,
        "shiftGroupName": shiftGroupName,
        "holidayName": holidayName,
        "workingDateText": workingDateText,
        "approveDateText": approveDateText,
      };
}
