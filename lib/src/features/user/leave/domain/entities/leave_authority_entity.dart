import 'package:equatable/equatable.dart';

class LeaveAuthorityEntity extends Equatable{
  final int? idLeaveType;
  final int? idLeaveGroup;
  final int? minLeave;
  final int? idCompany;
  final int? isPaid;
  final double? isLeaveStep;
  final double? leaveValue;
  final double? carryValue;
  final String? gender;
  // final dynamic isProRate;
  // final int? proRateRound;
  final dynamic daysInAdvance;
  // final int? canRequestAfter;
  // final List<dynamic>? leaveStepList;
  // final List<LeaveTypeEmploymentTypeList>? leaveTypeEmploymentTypeList;
  final String? name;
  final int? isLeaveHoliday;
  final int? isLeaveCompensate;

  const LeaveAuthorityEntity({
    this.idLeaveType,
    this.idLeaveGroup,
    this.minLeave,
    this.idCompany,
    this.isPaid,
    this.isLeaveStep,
    this.leaveValue,
    this.carryValue,
    this.gender,
    // this.isProRate,
    // this.proRateRound,
    this.daysInAdvance,
    // this.canRequestAfter,
    // this.leaveStepList,
    // this.leaveTypeEmploymentTypeList,
    this.name,
    this.isLeaveHoliday,
    this.isLeaveCompensate,
  });

  @override
  List<Object?> get props => [];

}

class LeaveTypeEmploymentTypeList extends Equatable{
  final int? idLeaveTypeEmploymentType;
  final dynamic idEmploymentType;
  final dynamic employmentTypeName;
  final dynamic idGroupLevel;
  final dynamic groupLevelName;

  LeaveTypeEmploymentTypeList({
    this.idLeaveTypeEmploymentType,
    this.idEmploymentType,
    this.employmentTypeName,
    this.idGroupLevel,
    this.groupLevelName,
  });

  @override
  List<Object?> get props => [
    idLeaveTypeEmploymentType,
    idEmploymentType,
    employmentTypeName,
    idGroupLevel,
    groupLevelName,
  ];

}