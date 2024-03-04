import 'dart:convert';
import 'package:unihr/src/features/user/leave/domain/entities/entities.dart';

List<LeaveAvailableModel> leaveAvailableModelFromJson(String str) =>
    List<LeaveAvailableModel>.from(
        json.decode(str).map((x) => LeaveAvailableModel.fromJson(x)));

String leaveAvailableModelToJson(List<LeaveAvailableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveAvailableModel extends LeaveAvailableEntity {
  LeaveAvailableModel({
    required super.idLeaveGroup,
    required super.name,
    required super.name_EN,
    required super.isLeaveHoliday,
    required super.isLeaveCompensate,
    required super.isLeaveAnnual,
    required super.isLeaveSick,
    required super.isLeavePersonal,
    required super.idLeaveType,
    required super.idCompany,
    required super.minLeave,
    required super.daysInAdvance,
    required super.canRequestAfter,
    required super.leaveValue,
    required super.carryValue,
    required super.leaveUsed,
    required super.leaveRemain,
    required super.carryRemain,
  });

  factory LeaveAvailableModel.fromJson(Map<String, dynamic> json) =>
      LeaveAvailableModel(
        idLeaveGroup: json["idLeaveGroup"],
        name: json["name"],
        name_EN: json["name_EN"],
        isLeaveHoliday: json["isLeaveHoliday"],
        isLeaveCompensate: json["isLeaveCompensate"],
        isLeaveAnnual: json["isLeaveAnnual"],
        isLeaveSick: json["isLeaveSick"],
        isLeavePersonal: json["isLeavePersonal"],
        idLeaveType: json["idLeaveType"],
        idCompany: json["idCompany"],
        minLeave: json["minLeave"],
        daysInAdvance: json["daysInAdvance"],
        canRequestAfter: json["canRequestAfter"],
        leaveValue: json["leaveValue"]?.toDouble(),
        carryValue: json["carryValue"]?.toDouble(),
        leaveUsed: json["leaveUsed"]?.toDouble(),
        leaveRemain: json["leaveRemain"]?.toDouble(),
        carryRemain: json["carryRemain"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idLeaveGroup": idLeaveGroup,
        "name": name,
        "name_EN": name_EN,
        "isLeaveHoliday": isLeaveHoliday,
        "isLeaveCompensate": isLeaveCompensate,
        "isLeaveAnnual": isLeaveAnnual,
        "isLeaveSick": isLeaveSick,
        "isLeavePersonal": isLeavePersonal,
        "idLeaveType": idLeaveType,
        "idCompany": idCompany,
        "minLeave": minLeave,
        "daysInAdvance": daysInAdvance,
        "canRequestAfter": canRequestAfter,
        "leaveValue": leaveValue,
        "carryValue": carryValue,
        "leaveUsed": leaveUsed,
        "leaveRemain": leaveRemain,
        "carryRemain": carryRemain,
      };
}
