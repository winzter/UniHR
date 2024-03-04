import 'dart:convert';
import 'package:unihr/src/features/user/time_management/domain/entities/enitities.dart';

List<HolidayModel> holidayEntityFromJson(String str) => List<HolidayModel>.from(
    json.decode(str).map((x) => HolidayModel.fromJson(x)));

String holidayEntityToJson(List<HolidayModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HolidayModel extends HolidayEntity {
  HolidayModel({
    required int? idHoliday,
    required String? name,
    required String? name_EN,
    required DateTime? dateHoliday,
    required dynamic compensateName,
    required dynamic compensateDate,
    required int? idCompany,
    required int? holidayYear,
    required int? showTimeline,
    required int? isActive,
  }) : super(
          idHoliday: idHoliday,
          name: name,
          name_EN: name_EN,
          dateHoliday: dateHoliday,
          compensateName: compensateName,
          compensateDate: compensateDate,
          idCompany: idCompany,
          holidayYear: holidayYear,
          showTimeline: showTimeline,
          isActive: isActive,
        );

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
        idHoliday: json["idHoliday"],
        name: json["name"],
        name_EN: json["name_EN"],
        dateHoliday: json["dateHoliday"] == null
            ? null
            : DateTime.parse(json["dateHoliday"]),
        compensateName: json["compensateName"],
        compensateDate: json["compensateDate"],
        idCompany: json["idCompany"],
        holidayYear: json["holidayYear"],
        showTimeline: json["showTimeline"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "idHoliday": idHoliday,
        "name": name,
        "name_EN": name_EN,
        "dateHoliday": dateHoliday?.toIso8601String(),
        "compensateName": compensateName,
        "compensateDate": compensateDate,
        "idCompany": idCompany,
        "holidayYear": holidayYear,
        "showTimeline": showTimeline,
        "isActive": isActive,
      };
}
