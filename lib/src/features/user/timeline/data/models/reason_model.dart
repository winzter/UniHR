import 'dart:convert';
import '../../domain/entities/entities.dart';

List<ReasonModel> reasonFromJson(String str) => List<ReasonModel>.from(
    json.decode(str).map((x) => ReasonModel.fromJson(x)));

String reasonToJson(List<ReasonModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReasonModel extends ReasonEntity {
  const ReasonModel({
    required super.idRequestReason,
    required super.name,
    required super.name_EN,
    required super.idCompany,
    required super.isPayShift,
    required super.index,
    required super.idRequestType,
    required super.isStandard,
    required super.startDate,
    required super.isActive,
  });

  factory ReasonModel.fromJson(Map<String, dynamic> json) => ReasonModel(
        idRequestReason: json["idRequestReason"],
        name: json["name"],
        name_EN: json["name_EN"],
        idCompany: json["idCompany"],
        isPayShift: json["isPayShift"],
        index: json["index"],
        idRequestType: json["idRequestType"],
        isStandard: json["isStandard"],
        startDate: json["startDate"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "idRequestReason": idRequestReason,
        "name": name,
        "name_EN": name_EN,
        "idCompany": idCompany,
        "isPayShift": isPayShift,
        "index": index,
        "idRequestType": idRequestType,
        "isStandard": isStandard,
        "startDate": startDate,
        "isActive": isActive,
      };
}
