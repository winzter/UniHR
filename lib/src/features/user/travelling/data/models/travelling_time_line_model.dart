import 'dart:convert';

import 'package:unihr/src/features/user/travelling/domain/entities/travelling_time_line_entity.dart';

List<TravellingTimeLineModel> travellingTimeLineModelFromJson(String str) => List<TravellingTimeLineModel>.from(json.decode(str).map((x) => TravellingTimeLineModel.fromJson(x)));

String travellingTimeLineModelToJson(List<TravellingTimeLineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravellingTimeLineModel extends TravellingTimeLineEntity{


  TravellingTimeLineModel({
    required int? idEmployees,
    required int? idCompany,
    required String? titleTh,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? positionsName,
    required String? timeIn,
    required String? timeOut,
    required int? mileIn,
    required int? mileOut,
    required double? latitudeIn,
    required double? latitudeOut,
    required double? longitudeIn,
    required double? longitudeOut,
    required String? locationNameIn,
    required String? locationNameOut,
    required dynamic description,
    required String? attendanceDateTimeText,
    // required DiffModel? diff,
  }):super(
    idEmployees:idEmployees,
    idCompany:idCompany,
    titleTh:titleTh,
    firstnameTh:firstnameTh,
    lastnameTh:lastnameTh,
    positionsName:positionsName,
    timeIn:timeIn,
    timeOut:timeOut,
    mileIn:mileIn,
    mileOut:mileOut,
    latitudeIn:latitudeIn,
    latitudeOut:latitudeOut,
    longitudeIn:longitudeIn,
    longitudeOut:longitudeOut,
    locationNameIn:locationNameIn,
    locationNameOut:locationNameOut,
    description:description,
    attendanceDateTimeText:attendanceDateTimeText,
    // diff:diff,
  );

  factory TravellingTimeLineModel.fromJson(Map<String, dynamic> json) => TravellingTimeLineModel(
    idEmployees: json["idEmployees"],
    idCompany: json["idCompany"],
    titleTh: json["title_TH"],
    firstnameTh: json["firstname_TH"],
    lastnameTh: json["lastname_TH"],
    positionsName: json["positionsName"],
    timeIn: json["timeIn"],
    timeOut: json["timeOut"],
    mileIn: json["mileIn"],
    mileOut: json["mileOut"],
    latitudeIn: json["latitudeIn"]?.toDouble(),
    latitudeOut: json["latitudeOut"]?.toDouble(),
    longitudeIn: json["longitudeIn"]?.toDouble(),
    longitudeOut: json["longitudeOut"]?.toDouble(),
    locationNameIn: json["locationNameIn"],
    locationNameOut: json["locationNameOut"],
    description: json["description"],
    attendanceDateTimeText: json["attendanceDateTimeText"],
    // diff: json["diff"] == null ? null : DiffModel.fromJson(json["diff"]),
  );

  Map<String, dynamic> toJson() => {
    "idEmployees": idEmployees,
    "idCompany": idCompany,
    "title_TH": titleTh,
    "firstname_TH": firstnameTh,
    "lastname_TH": lastnameTh,
    "positionsName": positionsName,
    "timeIn": timeIn,
    "timeOut": timeOut,
    "mileIn": mileIn,
    "mileOut": mileOut,
    "latitudeIn": latitudeIn,
    "latitudeOut": latitudeOut,
    "longitudeIn": longitudeIn,
    "longitudeOut": longitudeOut,
    "locationNameIn": locationNameIn,
    "locationNameOut": locationNameOut,
    "description": description,
    "attendanceDateTimeText": attendanceDateTimeText,
    // "diff": diff,
  };
}

class DiffModel extends DiffEntity {
  DiffModel({
    required super.hours,
    required super.minutes,
  });

  factory DiffModel.fromJson(Map<String, dynamic> json) => DiffModel(
    hours: json["hours"],
    minutes: json["minutes"],
  );
}
