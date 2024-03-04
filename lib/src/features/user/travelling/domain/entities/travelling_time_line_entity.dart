import 'package:equatable/equatable.dart';

class TravellingTimeLineEntity extends Equatable{
  final int? idEmployees;
  final int? idCompany;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? positionsName;
  final String? timeIn;
  final String? timeOut;
  final int? mileIn;
  final int? mileOut;
  final double? latitudeIn;
  final double? latitudeOut;
  final double? longitudeIn;
  final double? longitudeOut;
  final String? locationNameIn;
  final String? locationNameOut;
  final dynamic description;
  final String? attendanceDateTimeText;
  final DiffEntity? diff;

  TravellingTimeLineEntity({
    this.idEmployees,
    this.idCompany,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.positionsName,
    this.timeIn,
    this.timeOut,
    this.mileIn,
    this.mileOut,
    this.latitudeIn,
    this.latitudeOut,
    this.longitudeIn,
    this.longitudeOut,
    this.locationNameIn,
    this.locationNameOut,
    this.description,
    this.attendanceDateTimeText,
    this.diff,
  });
  @override
  List<Object?> get props => [
    idEmployees,
    idCompany,
    titleTh,
    firstnameTh,
    lastnameTh,
    positionsName,
    timeIn,
    timeOut,
    mileIn,
    mileOut,
    latitudeIn,
    latitudeOut,
    longitudeIn,
    longitudeOut,
    locationNameIn,
    locationNameOut,
    description,
    attendanceDateTimeText,
    diff,
  ];
}

class DiffEntity extends Equatable{
  final int? hours;
  final int? minutes;

  DiffEntity({
    this.hours,
    this.minutes,
  });

  @override
  List<Object?> get props => [
    hours,
    minutes,
  ];

}
