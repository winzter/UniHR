import 'dart:convert';
import '../../domain/entities/entities.dart';

List<LeaveAuthorityModel> leaveAuthorityDataFromJson(String str) =>
    List<LeaveAuthorityModel>.from(
        json.decode(str).map((x) => LeaveAuthorityModel.fromJson(x)));

// String leaveAuthorityDataToJson(List<LeaveAuthorityModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveAuthorityModel extends LeaveAuthorityEntity{
  const LeaveAuthorityModel({
    required super.idLeaveType,
    required super.idLeaveGroup,
    required super.minLeave,
    required super.idCompany,
    required super.isPaid,
    required super.isLeaveStep,
    required super.leaveValue,
    required super.carryValue,
    required super.gender,
    // required super.isProRate,
    // required super.proRateRound,
    required super.daysInAdvance,
    // required super.canRequestAfter,
    // required super.leaveStepList,
    // required super.leaveTypeEmploymentTypeList,
    required super.name,
    required super.isLeaveHoliday,
    required super.isLeaveCompensate,
 });

  factory LeaveAuthorityModel.fromJson(Map<String, dynamic> json) => LeaveAuthorityModel(
      idLeaveType: json["idLeaveType"],
      idLeaveGroup: json["idLeaveGroup"],
      minLeave: json["minLeave"],
      idCompany: json["idCompany"],
      isPaid: json["isPaid"],
      isLeaveStep: json["isLeaveStep"]?.toDouble(),
      leaveValue: json["leaveValue"]?.toDouble(),
      carryValue: json["carryValue"]?.toDouble(),
      gender: json["gender"],
      // isProRate: json["isProRate"],
      // proRateRound: json["proRateRound"],
      daysInAdvance: json["daysInAdvance"],
      // canRequestAfter: json["canRequestAfter"],
      // leaveStepList: json["leaveStepList"] == null ? [] : List<dynamic>.from(json["leaveStepList"]!.map((x) => x)),
      // leaveTypeEmploymentTypeList: json["leaveTypeEmploymentTypeList"] == null ? [] : List<LeaveTypeEmploymentTypeListModel>.from(json["leaveTypeEmploymentTypeList"]!.map((x) => LeaveTypeEmploymentTypeListModel.fromJson(x))),
      name: json["name"],
      isLeaveHoliday: json["isLeaveHoliday"],
      isLeaveCompensate: json["isLeaveCompensate"]
  );

  // Map<String, dynamic> toJson() => {
  //   "idLeaveType": idLeaveType,
  //   "idLeaveGroup": idLeaveGroup,
  //   "minLeave": minLeave,
  //   "idCompany": idCompany,
  //   "isPaid": isPaid,
  //   "isLeaveStep": isLeaveStep,
  //   "leaveValue": leaveValue,
  //   "carryValue": carryValue,
  //   "gender": gender,
  //   "isProRate": isProRate,
  //   "proRateRound": proRateRound,
  //   "daysInAdvance": daysInAdvance,
  //   "canRequestAfter": canRequestAfter,
  //   "leaveStepList": leaveStepList == null ? [] : List<dynamic>.from(leaveStepList!.map((x) => x)),
  //   "leaveTypeEmploymentTypeList": leaveTypeEmploymentTypeList == null ? [] : List<LeaveTypeEmploymentTypeListModel>.from(leaveTypeEmploymentTypeList!.map((x) => x.toJson())),
  //   "name": name,
  //   "isLeaveHoliday": isLeaveHoliday,
  // };
}

class LeaveTypeEmploymentTypeListModel extends LeaveTypeEmploymentTypeList{


  LeaveTypeEmploymentTypeListModel({
    required int? idLeaveTypeEmploymentType,
    required dynamic idEmploymentType,
    required dynamic employmentTypeName,
    required dynamic idGroupLevel,
    required dynamic groupLevelName,
  }):super(
idLeaveTypeEmploymentType:idLeaveTypeEmploymentType,
idEmploymentType:idEmploymentType,
employmentTypeName:employmentTypeName,
idGroupLevel:idGroupLevel,
groupLevelName:groupLevelName,
);

  factory LeaveTypeEmploymentTypeListModel.fromJson(Map<String, dynamic> json) => LeaveTypeEmploymentTypeListModel(
    idLeaveTypeEmploymentType: json["idLeaveTypeEmploymentType"],
    idEmploymentType: json["idEmploymentType"],
    employmentTypeName: json["employmentTypeName"],
    idGroupLevel: json["idGroupLevel"],
    groupLevelName: json["groupLevelName"],
  );

  Map<String, dynamic> toJson() => {
    "idLeaveTypeEmploymentType": idLeaveTypeEmploymentType,
    "idEmploymentType": idEmploymentType,
    "employmentTypeName": employmentTypeName,
    "idGroupLevel": idGroupLevel,
    "groupLevelName": groupLevelName,
  };
}