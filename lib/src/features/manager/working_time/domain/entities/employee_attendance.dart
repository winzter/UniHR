import 'package:equatable/equatable.dart';


class EmployeesAttendanceEntity extends Equatable{
  final int? idAttendance;
  final DateTime? attendanceDateTime;
  final int? isCheckIn;
  final dynamic workDay;
  final int? idAttendanceType;
  final int? idGpsLocations;
  final int? idEmployees;
  final int? idCompany;
  final dynamic idShift;
  final dynamic idGroupGpsLocations;
  final dynamic gpsAddress;
  final dynamic latitude;
  final dynamic longitude;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? gpsLocationsName;
  final String? positionName;
  final String? titleTh;
  final String? imageName;
  final String? time;
  final String? attendanceDateTimeText;
  final String? imageProfile;

  EmployeesAttendanceEntity({
    this.idAttendance,
    this.attendanceDateTime,
    this.isCheckIn,
    this.workDay,
    this.idAttendanceType,
    this.idGpsLocations,
    this.idEmployees,
    this.idCompany,
    this.idShift,
    this.idGroupGpsLocations,
    this.gpsAddress,
    this.latitude,
    this.longitude,
    this.firstnameTh,
    this.lastnameTh,
    this.gpsLocationsName,
    this.positionName,
    this.titleTh,
    this.imageName,
    this.time,
    this.attendanceDateTimeText,
    this.imageProfile,
  });



  @override
  List<Object?> get props => [
    idAttendance,
    attendanceDateTime,
    isCheckIn,
    workDay,
    idAttendanceType,
    idGpsLocations,
    idEmployees,
    idCompany,
    idShift,
    idGroupGpsLocations,
    gpsAddress,
    latitude,
    longitude,
    firstnameTh,
    lastnameTh,
    gpsLocationsName,
    positionName,
    titleTh,
    imageName,
    time,
    attendanceDateTimeText,
    imageProfile,
  ];
}
