import 'package:equatable/equatable.dart';

class ChangeTimeManager extends Equatable {
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
  final String? firstname_EN;
  final String? lastname_EN;
  final String? positionName;
  final String? positionName_EN;
  final dynamic departmentName;
  final String? shiftGroupName;
  final dynamic holidayName;
  final String? workingDateText;
  final String? approveDateText;

  const ChangeTimeManager({
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
    this.positionName,
    this.firstname_EN,
    this.lastname_EN,
    this.positionName_EN,
    this.departmentName,
    this.shiftGroupName,
    this.holidayName,
    this.workingDateText,
    this.approveDateText,
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
        firstname_EN,
        lastname_EN,
        positionName,
        positionName_EN,
        departmentName,
        shiftGroupName,
        holidayName,
        workingDateText,
        approveDateText,
      ];
}
