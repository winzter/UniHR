import 'package:equatable/equatable.dart';

class CheckHolidayEntity extends Equatable{
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
  final dynamic approveComment;
  final dynamic fillInApprove;
  final int? idHoliday;
  final dynamic fillInChange;

  CheckHolidayEntity({
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
    this.fillInChange,
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
    fillInChange,
  ];


}
