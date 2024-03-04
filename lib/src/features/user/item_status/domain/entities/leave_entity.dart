import 'package:equatable/equatable.dart';

class LeaveEntity extends Equatable {
  final int? idLeave;
  final int? idLeaveType;
  final String? description;
  final dynamic filename;
  final DateTime? start;
  final DateTime? end;
  final int? idEmployees;
  final double? used;
  final double? quota;
  final double? balance;
  final double? remaining;
  final double? carry;
  final int? idManager;
  final DateTime? approveDate;
  final dynamic isApprove;
  final int? isFullDay;
  final dynamic workingStart;
  final dynamic workingEnd;
  final int? isActive;
  final dynamic fillInApprove;
  final DateTime? createDate;
  final dynamic isWithdraw;
  final dynamic commentManager;
  final dynamic idHoliday;
  final dynamic ccEmail;
  final dynamic idManagerGroup;
  final String? name;
  final String? name_EN;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final int? idCompany;
  final String? positionName;
  final String? departmentName;
  final String? managerFirstnameTh;
  final String? managerLastnameTh;
  final dynamic holidayName;
  final String? managerFirstnameEn;
  final String? managerLastnameEn;
  final String? managerEmail;
  final String? startText;
  final String? endText;
  final dynamic approveDateText;
  final String? createDateText;

  const LeaveEntity({
    this.idLeave,
    this.idLeaveType,
    this.description,
    this.filename,
    this.start,
    this.end,
    this.idEmployees,
    this.used,
    this.quota,
    this.balance,
    this.remaining,
    this.carry,
    this.idManager,
    this.approveDate,
    this.isApprove,
    this.isFullDay,
    this.workingStart,
    this.workingEnd,
    this.isActive,
    this.fillInApprove,
    this.createDate,
    this.isWithdraw,
    this.commentManager,
    this.idHoliday,
    this.ccEmail,
    this.idManagerGroup,
    this.name,
    this.name_EN,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.idCompany,
    this.positionName,
    this.departmentName,
    this.managerFirstnameTh,
    this.managerLastnameTh,
    this.holidayName,
    this.managerFirstnameEn,
    this.managerLastnameEn,
    this.managerEmail,
    this.startText,
    this.endText,
    this.approveDateText,
    this.createDateText,
  });

  @override
  List<Object?> get props => [
        idLeave,
        idLeaveType,
        description,
        filename,
        start,
        end,
        idEmployees,
        used,
        quota,
        balance,
        remaining,
        carry,
        idManager,
        approveDate,
        isApprove,
        isFullDay,
        workingStart,
        workingEnd,
        isActive,
        fillInApprove,
        createDate,
        isWithdraw,
        commentManager,
        idHoliday,
        ccEmail,
        idManagerGroup,
        name,
        name_EN,
        titleTh,
        firstnameTh,
        lastnameTh,
        idCompany,
        positionName,
        departmentName,
        managerFirstnameTh,
        managerLastnameTh,
        holidayName,
        managerFirstnameEn,
        managerLastnameEn,
        managerEmail,
        startText,
        endText,
        approveDateText,
        createDateText,
      ];
}
