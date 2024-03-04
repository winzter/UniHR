import 'package:equatable/equatable.dart';

class LeaveAvailableEntity extends Equatable {
  final int? idLeaveGroup;
  final String? name;
  final String? name_EN;
  final int? isLeaveHoliday;
  final int? isLeaveCompensate;
  final int? isLeaveAnnual;
  final int? isLeaveSick;
  final int? isLeavePersonal;
  final int? idLeaveType;
  final int? idCompany;
  final int? minLeave;
  final int? daysInAdvance;
  final int? canRequestAfter;
  final double? leaveValue;
  final double? carryValue;
  final double? leaveUsed;
  final double? leaveRemain;
  final double? carryRemain;

  LeaveAvailableEntity({
    this.idLeaveGroup,
    this.name,
    this.name_EN,
    this.isLeaveHoliday,
    this.isLeaveCompensate,
    this.isLeaveAnnual,
    this.isLeaveSick,
    this.isLeavePersonal,
    this.idLeaveType,
    this.idCompany,
    this.minLeave,
    this.daysInAdvance,
    this.canRequestAfter,
    this.leaveValue,
    this.carryValue,
    this.leaveUsed,
    this.leaveRemain,
    this.carryRemain,
  });

  @override
  List<Object?> get props => [
        idLeaveGroup,
        name,
        name_EN,
        isLeaveHoliday,
        isLeaveCompensate,
        isLeaveAnnual,
        isLeaveSick,
        isLeavePersonal,
        idLeaveType,
        idCompany,
        minLeave,
        daysInAdvance,
        canRequestAfter,
        leaveValue,
        carryValue,
        leaveUsed,
        leaveRemain,
        carryRemain,
      ];
}
