import 'dart:convert';
import 'package:unihr/src/features/user/leave/domain/entities/entities.dart';

LeaveSettingModel leaveSettingModelFromJson(String str) => LeaveSettingModel.fromJson(json.decode(str));

String leaveSettingModelToJson(LeaveSettingModel data) => json.encode(data.toJson());

class LeaveSettingModel extends LeaveSettingEntity{

  LeaveSettingModel({
    required super.idLeaveSetting,
    required super.idCompany,
    required super.resetEndOfMonth,
  });

  factory LeaveSettingModel.fromJson(Map<String, dynamic> json) => LeaveSettingModel(
    idLeaveSetting: json["idLeaveSetting"],
    idCompany: json["idCompany"],
    resetEndOfMonth: json["resetEndOfMonth"],
  );

  Map<String, dynamic> toJson() => {
    "idLeaveSetting": idLeaveSetting,
    "idCompany": idCompany,
    "resetEndOfMonth": resetEndOfMonth,
  };
}
