import 'dart:convert';
import 'package:unihr/src/features/user/time_management/domain/entities/check_holiday_entity.dart';

List<CheckHolidayModel> checkHolidayModelFromJson(String str) => List<CheckHolidayModel>.from(json.decode(str).map((x) => CheckHolidayModel.fromJson(x)));

String checkHolidayModelToJson(List<CheckHolidayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckHolidayModel extends CheckHolidayEntity{
    CheckHolidayModel({
    required super.idEmployeeShiftDaily,
    required super.idEmployees,
    required super.idShift,
    required super.idShiftType,
    required super.workingDate,
    required super.idShiftGroup,
    required super.isWorkingDay,
    required super.isApprove,
    required super.isActive,
    required super.createDate,
    required super.approveBy,
    required super.approveDate,
    required super.approveComment,
    required super.fillInApprove,
    required super.idHoliday,
    required super.fillInChange,
  });

  factory CheckHolidayModel.fromJson(Map<String, dynamic> json) => CheckHolidayModel(
    idEmployeeShiftDaily: json["idEmployeeShiftDaily"],
    idEmployees: json["idEmployees"],
    idShift: json["idShift"],
    idShiftType: json["idShiftType"],
    workingDate: json["workingDate"] == null ? null : DateTime.parse(json["workingDate"]),
    idShiftGroup: json["idShiftGroup"],
    isWorkingDay: json["isWorkingDay"],
    isApprove: json["isApprove"],
    isActive: json["isActive"],
    createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
    approveBy: json["approveBy"],
    approveDate: json["approveDate"] == null ? null : DateTime.parse(json["approveDate"]),
    approveComment: json["approveComment"],
    fillInApprove: json["fillInApprove"],
    idHoliday: json["idHoliday"],
    fillInChange: json["fillInChange"],
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
    "fillInChange": fillInChange,
  };
}
