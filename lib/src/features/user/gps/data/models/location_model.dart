import 'dart:convert';
import 'package:unihr/src/features/user/gps/domain/entities/location_entity.dart';

LineCheckInModel lineCheckInFromJson(String str) =>
    LineCheckInModel.fromJson(json.decode(str));

// String lineCheckInToJson(LineCheckInModel data) => json.encode(data.toJson());

class LineCheckInModel extends LineCheckIn {
  LineCheckInModel({
    required super.idCompany,
    required super.firstnameTh,
    required super.lastnameTh,
    required super.idEmployees,
    required super.mainWorkingLocationPoint,
    required super.methodAttendance,
    required super.checkPriority,
    required super.isCheckGps,
    required super.isCheckBluetooth,
    required super.groupGpsLocations,
    required super.attendance,
  });

  factory LineCheckInModel.fromJson(Map<String, dynamic> json) => LineCheckInModel(
    idCompany: json["idCompany"],
    firstnameTh: json["firstname_TH"],
    lastnameTh: json["lastname_TH"],
    idEmployees: json["idEmployees"],
    mainWorkingLocationPoint: json["mainWorkingLocationPoint"],
    methodAttendance: json["methodAttendance"],
    checkPriority: json["checkPriority"],
    isCheckGps: json["isCheckGPS"],
    isCheckBluetooth: json["isCheckBluetooth"],
    groupGpsLocations: json["groupGpsLocations"] == null ? [] : List<GroupGpsLocationModel>.from(json["groupGpsLocations"]!.map((x) => GroupGpsLocationModel.fromJson(x))),
    attendance: json["attendance"] == null ? [] : List<dynamic>.from(json["attendance"]!.map((x) => x)),
  );

  // Map<String, dynamic> toJson() => {
  //       "idCompany": idCompany,
  //       "firstname_TH": firstnameTh,
  //       "lastname_TH": lastnameTh,
  //       "idEmployees": idEmployees,
  //       "mainWorkingLocationPoint": mainWorkingLocationPoint,
  //       "methodAttendance": methodAttendance,
  //       "groupGpsLocations": groupGpsLocations == null
  //           ? []
  //           : List<dynamic>.from(groupGpsLocations!.map((x) => x.toJson())),
  //       "attendance": attendance == null
  //           ? []
  //           : List<dynamic>.from(attendance!.map((x) => x)),
  //     };
}

class GroupGpsLocationModel extends GroupGpsLocation {
  GroupGpsLocationModel({
    required super.idGroupGpsLocations,
    required super.name,
    required super.idCompany,
    required super.createBy,
    required super.createDate,
    required super.isActive,
    required super.updateBy,
    required super.updateDate,
    required super.locations,
  });

  factory GroupGpsLocationModel.fromJson(Map<String, dynamic> json) =>
      GroupGpsLocationModel(
        idGroupGpsLocations: json["idGroupGpsLocations"],
        name: json["name"],
        idCompany: json["idCompany"],
        createBy: json["createBy"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        isActive: json["isActive"],
        updateBy: json["updateBy"],
        updateDate: json["updateDate"] == null
            ? null
            : DateTime.parse(json["updateDate"]),
        locations: json["locations"] == null
            ? []
            : List<LocationModel>.from(
                json["locations"]!.map((x) => LocationModel.fromJson(x))),
      );

// Map<String, dynamic> toJson() => {
//   "idGroupGpsLocations": idGroupGpsLocations,
//   "name": name,
//   "idCompany": idCompany,
//   "createBy": createBy,
//   "createDate": createDate?.toIso8601String(),
//   "isActive": isActive,
//   "updateBy": updateBy,
//   "updateDate": updateDate?.toIso8601String(),
//   "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toJson())),
// };
}

class LocationModel extends Locations {
  LocationModel({
    required super.name,
    required super.positions,
    required super.idGpsLocations,
    required super.idGroupGpsLocations,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    name: json["name"],
    positions: json["positions"] == null ? [] : List<PositionModel>.from(json["positions"]!.map((x) => PositionModel.fromJson(x))),
    idGpsLocations: json["idGpsLocations"],
    idGroupGpsLocations: json["idGroupGpsLocations"],
      );

// Map<String, dynamic> toJson() => {
//   "idGpsLocations": idGpsLocations,
//   "name": name,
//   "idGroupGpsLocations": idGroupGpsLocations,
//   "idCompany": idCompany,
//   "isActive": isActive,
//   "createBy": createBy,
//   "createDate": createDate?.toIso8601String(),
//   "editBy": editBy,
//   "editDate": editDate,
//   "positions": positions == null ? [] : List<dynamic>.from(positions!.map((x) => x.toJson())),
// };
}

class PositionModel extends PositionEntity {
  PositionModel({
    required super.lat,
    required super.lng,
    required super.idGpsLocations,
    required super.idGpsPositions,
    required super.idGroupGpsLocations,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
        idGpsPositions: json["idGpsPositions"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        idGpsLocations: json["idGpsLocations"],
        idGroupGpsLocations: json["idGroupGpsLocations"],
      );

  Map<String, dynamic> toJson() => {
        "idGpsPositions": idGpsPositions,
        "lat": lat,
        "lng": lng,
        "idGpsLocations": idGpsLocations,
        "idGroupGpsLocations": idGroupGpsLocations,
      };
}
