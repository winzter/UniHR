import 'dart:convert';
import 'package:unihr/src/features/user/gps/domain/entities/beacons_entity.dart';

List<BeaconsModel> beaconsModelFromJson(String str) => List<BeaconsModel>.from(json.decode(str).map((x) => BeaconsModel.fromJson(x)));

String beaconsModelToJson(List<BeaconsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeaconsModel extends BeaconsEntity{

  BeaconsModel({
    required super.idBeacon,
    required super.name,
    required super.macAddress,
    required super.idCompany,
  });

  factory BeaconsModel.fromJson(Map<String, dynamic> json) => BeaconsModel(
    idBeacon: json["idBeacon"],
    name: json["name"],
    macAddress: json["macAddress"],
    idCompany: json["idCompany"],
  );

  Map<String, dynamic> toJson() => {
    "idBeacon": idBeacon,
    "name": name,
    "macAddress": macAddress,
    "idCompany": idCompany,
  };
}
