import 'dart:convert';

import '../../domain/entities/is_checkin_entity.dart';


IsCheckInModel isCheckInModelFromJson(String str) =>
    IsCheckInModel.fromJson(json.decode(str));

String isCheckInModelToJson(IsCheckInModel data) => json.encode(data.toJson());

class IsCheckInModel extends IsCheckInEntity {
  IsCheckInModel({
    required super.idEmployees,
    required super.checkIn,
    required super.type,
  });

  factory IsCheckInModel.fromJson(Map<String, dynamic> json) => IsCheckInModel(
        idEmployees: json["idEmployees"].toString(),
        checkIn: json["checkIn"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
        "checkIn": checkIn,
        "type": type,
      };
}
