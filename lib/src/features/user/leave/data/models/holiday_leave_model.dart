import 'dart:convert';

import 'package:unihr/src/features/user/leave/domain/entities/entities.dart';

List<HolidayLeaveModel> holidayLeaveModelFromJson(String str) => List<HolidayLeaveModel>.from(json.decode(str).map((x) => HolidayLeaveModel.fromJson(x)));

String holidayLeaveModelToJson(List<HolidayLeaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HolidayLeaveModel extends HolidayLeaveEntity{
  HolidayLeaveModel({
    required super.idHoliday,
    required super.name,
    required super.dateHoliday,
    required super.compensateName,
    required super.compensateDate,
    required super.idCompany,
    required super.holidayYear,
    required super.showTimeline,
    required super.isActive,
  });

  factory HolidayLeaveModel.fromJson(Map<String, dynamic> json) => HolidayLeaveModel(
    idHoliday: json["idHoliday"],
    name: json["name"],
    dateHoliday: json["dateHoliday"] == null ? null : DateTime.parse(json["dateHoliday"]),
    compensateName: json["compensateName"],
    compensateDate: json["compensateDate"] == null ? null : DateTime.parse(json["compensateDate"]),
    idCompany: json["idCompany"],
    holidayYear: json["holidayYear"],
    showTimeline: json["showTimeline"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "idHoliday": idHoliday,
    "name": name,
    "dateHoliday": dateHoliday?.toIso8601String(),
    "compensateName": compensateName,
    "compensateDate": compensateDate?.toIso8601String(),
    "idCompany": idCompany,
    "holidayYear": holidayYear,
    "showTimeline": showTimeline,
    "isActive": isActive,
  };
}
