import 'dart:convert';

import 'package:unihr/src/features/user/leave/domain/entities/day_cannot_leave_entity.dart';

List<DayCannotLeaveModel> dayCannotLeaveModelFromJson(String str) => List<DayCannotLeaveModel>.from(json.decode(str).map((x) => DayCannotLeaveModel.fromJson(x)));

String dayCannotLeaveModelToJson(List<DayCannotLeaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DayCannotLeaveModel extends DayCannotLeave{

  DayCannotLeaveModel({
    required super.date,
    required super.isActive,
    required super.workingMinutes,
    required super.workingHours,
    required super.breakTime,
    required super.timeIn,
    required super.timeOut,
    required super.isWorkingDay,
    required super.breakTimeMin,
    required super.startBreak,
    required super.holiday,
  });

  factory DayCannotLeaveModel.fromJson(Map<String, dynamic> json) => DayCannotLeaveModel(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    isActive: json["isActive"],
    workingMinutes: json["workingMinutes"],
    workingHours: json["workingHours"],
    breakTime: json["breakTime"],
    timeIn: json["timeIn"],
    timeOut: json["timeOut"],
    isWorkingDay: json["isWorkingDay"],
    breakTimeMin: json["breakTimeMin"],
    startBreak: json["startBreak"],
    holiday: json["holiday"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "isActive": isActive,
    "workingMinutes": workingMinutes,
    "workingHours": workingHours,
    "breakTime": breakTime,
    "timeIn": timeIn,
    "timeOut": timeOut,
    "isWorkingDay": isWorkingDay,
    "breakTimeMin": breakTimeMin,
    "startBreak": startBreak,
    "holiday": holiday,
  };
}
