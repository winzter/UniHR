import 'package:equatable/equatable.dart';

class ShiftEntity extends Equatable{
  final int? idShiftGroup;
  final String? shiftGroupName;
  final int? shiftStartInMonday;
  final DateTime? shiftStartDate;
  final int? workDay;
  final int? offDay;
  final int? shiftNumber;
  final int? idWorkingType;
  final List<ShiftPattern>? shiftPattern;
  final List<ShiftData>? shift;
  final List<ShiftType>? shiftType;

  ShiftEntity({
    this.idShiftGroup,
    this.shiftGroupName,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.workDay,
    this.offDay,
    this.shiftNumber,
    this.idWorkingType,
    this.shiftPattern,
    this.shift,
    this.shiftType,
  });

  @override
  List<Object?> get props => [
    idShiftGroup,
    shiftGroupName,
    shiftStartInMonday,
    shiftStartDate,
    workDay,
    offDay,
    shiftNumber,
    idWorkingType,
    shiftPattern,
    shift,
    shiftType,
  ];

}

class ShiftData extends Equatable{
  final int? idShift;
  final String? shiftName;
  final int? idShiftGroup;
  final int? idCompany;
  final int? isActive;

  ShiftData({
    this.idShift,
    this.shiftName,
    this.idShiftGroup,
    this.idCompany,
    this.isActive,
  });

  @override
  List<Object?> get props => [
    idShift,
    shiftName,
    idShiftGroup,
    idCompany,
    isActive,
  ];

}

class ShiftPattern extends Equatable{
  final int? idShiftPattern;
  final int? indexScheduleId;
  final int? idShift;
  final String? shiftName;
  final int? idShiftType;
  final String? shiftTypeName;
  final String? timeIn;
  final String? timeOut;
  final int? breakTime;
  final int? isWorkingDay;
  final int? idShiftGroup;
  final String? shiftGroupName;
  final int? shiftStartInMonday;

  ShiftPattern({
    this.idShiftPattern,
    this.indexScheduleId,
    this.idShift,
    this.shiftName,
    this.idShiftType,
    this.shiftTypeName,
    this.timeIn,
    this.timeOut,
    this.breakTime,
    this.isWorkingDay,
    this.idShiftGroup,
    this.shiftGroupName,
    this.shiftStartInMonday,
  });

  @override
  List<Object?> get props => [
    idShiftPattern,
    indexScheduleId,
    idShift,
    shiftName,
    idShiftType,
    shiftTypeName,
    timeIn,
    timeOut,
    breakTime,
    isWorkingDay,
    idShiftGroup,
    shiftGroupName,
    shiftStartInMonday,
  ];

}

class ShiftType extends Equatable{
  final int? idShiftType;
  final String? shiftTypeName;
  final String? timeIn;
  final String? timeOut;
  final int? lateIn;
  final int? idShiftGroup;
  final int? workingHours;
  final int? period;
  final int? isWorkingDay;

  ShiftType({
    this.idShiftType,
    this.shiftTypeName,
    this.timeIn,
    this.timeOut,
    this.lateIn,
    this.idShiftGroup,
    this.workingHours,
    this.period,
    this.isWorkingDay,
  });

  @override
  List<Object?> get props => [
    idShiftType,
    shiftTypeName,
    timeIn,
    timeOut,
    lateIn,
    idShiftGroup,
    workingHours,
    period,
    isWorkingDay,
  ];
}
