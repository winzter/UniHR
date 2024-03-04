import 'dart:convert';
import 'package:unihr/src/features/user/leave/domain/entities/entities.dart';

List<ManagerLeaveModel> managerLeaveFromJson(String str) => List<ManagerLeaveModel>.from(json.decode(str).map((x) => ManagerLeaveModel.fromJson(x)));

String managerLeaveToJson(List<ManagerLeaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManagerLeaveModel extends ManagerLeave{
  ManagerLeaveModel({
    required super.idEmployees,
    required super.firstnameTh,
    required super.lastnameTh,
    required super.idPosition,
    required super.positionName,
    required super.idRole,
    required super.email,
  });

  factory ManagerLeaveModel.fromJson(Map<String, dynamic> json) => ManagerLeaveModel(
    idEmployees: json["idEmployees"],
    firstnameTh: json["firstname_TH"],
    lastnameTh: json["lastname_TH"],
    idPosition: json["idPosition"],
    positionName: json["positionName"],
    idRole: json["idRole"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "idEmployees": idEmployees,
    "firstname_TH": firstnameTh,
    "lastname_TH": lastnameTh,
    "idPosition": idPosition,
    "positionName": positionName,
    "idRole": idRole,
    "email": email,
  };
}
