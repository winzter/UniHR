import 'package:equatable/equatable.dart';

class LineCheckIn extends Equatable{
  final int? idCompany;
  final String? firstnameTh;
  final String? lastnameTh;
  final int? idEmployees;
  final dynamic mainWorkingLocationPoint;
  final String? methodAttendance;
  final dynamic checkPriority;
  final int? isCheckGps;
  final int? isCheckBluetooth;
  final List<GroupGpsLocation>? groupGpsLocations;
  final List<dynamic>? attendance;

  LineCheckIn({
    this.idCompany,
    this.firstnameTh,
    this.lastnameTh,
    this.idEmployees,
    this.mainWorkingLocationPoint,
    this.methodAttendance,
    this.checkPriority,
    this.isCheckGps,
    this.isCheckBluetooth,
    this.groupGpsLocations,
    this.attendance,
  });


  @override
  List<Object?> get props => [
    idCompany,
    firstnameTh,
    lastnameTh,
    idEmployees,
    mainWorkingLocationPoint,
    methodAttendance,
    checkPriority,
    isCheckGps,
    isCheckBluetooth,
    groupGpsLocations,
    attendance,
  ];

}

class GroupGpsLocation extends Equatable{
  final int? idGroupGpsLocations;
  final String? name;
  final int? idCompany;
  final int? createBy;
  final DateTime? createDate;
  final int? isActive;
  final dynamic updateBy;
  final DateTime? updateDate;
  final List<Locations>? locations;

  GroupGpsLocation({
    this.idGroupGpsLocations,
    this.name,
    this.idCompany,
    this.createBy,
    this.createDate,
    this.isActive,
    this.updateBy,
    this.updateDate,
    this.locations,
  });

  @override
  List<Object?> get props => [
    idGroupGpsLocations,
    name,
    idCompany,
    createBy,
    createDate,
    isActive,
    updateBy,
    updateDate,
    locations,
  ];
}

class Locations extends Equatable{
  final String? name;
  final List<PositionEntity>? positions;
  final int? idGpsLocations;
  final int? idGroupGpsLocations;

  Locations({
    this.idGpsLocations,
    this.name,
    this.idGroupGpsLocations,
    this.positions,
  });

  @override
  List<Object?> get props => [
    idGpsLocations,
    name,
    idGroupGpsLocations,
    positions,
  ];
}

class PositionEntity extends Equatable{
  final int? idGpsPositions;
  final double? lat;
  final double? lng;
  final int? idGpsLocations;
  final int? idGroupGpsLocations;

  PositionEntity({
    this.idGpsPositions,
    this.lat,
    this.lng,
    this.idGpsLocations,
    this.idGroupGpsLocations,
  });


  @override
  List<Object?> get props => [
    idGpsPositions,
    lat,
    lng,
    idGpsLocations,
    idGroupGpsLocations,
  ];
}
