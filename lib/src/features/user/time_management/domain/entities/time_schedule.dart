import 'package:equatable/equatable.dart';

class TimeScheduleEntity extends Equatable{
  final DateTime? date;
  final DataRenderEntity? dataRender;
  final List<RequestChangeEntity>? requestChange;

  TimeScheduleEntity({
    this.date,
    this.dataRender,
    this.requestChange,
  });

  @override
  List<Object?> get props => [
    date,
    dataRender,
    requestChange,
  ];

}

class DataRenderEntity extends Equatable{
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
  final int? lateIn;
  final int? workingHours;
  final int? period;
  final int? idShiftGroup;
  final String? shiftGroupName;
  final int? shiftStartInMonday;
  final DateTime? shiftStartDate;
  final int? shiftNumber;
  final int? workDay;
  final int? idWorkingType;
  final String? workingTypeName;

  DataRenderEntity({
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
    this.lateIn,
    this.workingHours,
    this.period,
    this.idShiftGroup,
    this.shiftGroupName,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.shiftNumber,
    this.workDay,
    this.idWorkingType,
    this.workingTypeName,
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
    lateIn,
    workingHours,
    period,
    idShiftGroup,
    shiftGroupName,
    shiftStartInMonday,
    shiftStartDate,
    shiftNumber,
    workDay,
    idWorkingType,
    workingTypeName,
  ];

}

class RequestChangeEntity extends Equatable{
  final int? idEmployeeShiftDaily;
  final int? idEmployees;
  final int? idShift;
  final int? idShiftType;
  final DateTime? workingDate;
  final int? idShiftGroup;
  final int? isWorkingDay;
  final int? isApprove;
  final int? isActive;
  final DateTime? createDate;
  final int? approveBy;
  final DateTime? approveDate;
  final String? approveComment;
  final dynamic fillInApprove;
  final dynamic idHoliday;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? email;
  final DateTime? workingDateText;
  final String? approveDateText;
  final String? createDateText;

  RequestChangeEntity({
    this.idEmployeeShiftDaily,
    this.idEmployees,
    this.idShift,
    this.idShiftType,
    this.workingDate,
    this.idShiftGroup,
    this.isWorkingDay,
    this.isApprove,
    this.isActive,
    this.createDate,
    this.approveBy,
    this.approveDate,
    this.approveComment,
    this.fillInApprove,
    this.idHoliday,
    this.firstnameTh,
    this.lastnameTh,
    this.email,
    this.workingDateText,
    this.approveDateText,
    this.createDateText,
  });

  @override
  List<Object?> get props => [
    idEmployeeShiftDaily,
    idEmployees,
    idShift,
    idShiftType,
    workingDate,
    idShiftGroup,
    isWorkingDay,
    isApprove,
    isActive,
    createDate,
    approveBy,
    approveDate,
    approveComment,
    fillInApprove,
    idHoliday,
    firstnameTh,
    lastnameTh,
    email,
    workingDateText,
    approveDateText,
    createDateText,
  ];

}
