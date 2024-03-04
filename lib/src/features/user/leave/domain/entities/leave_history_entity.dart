class LeaveHistoryEntity {
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
  final dynamic carry;
  final int? idManager;
  final DateTime? approveDate;
  final int? isApprove;
  final int? isFullDay;
  final dynamic workingStart;
  final dynamic workingEnd;
  final int? isActive;
  final dynamic fillInApprove;
  final DateTime? createDate;
  final dynamic isWithdraw;
  final dynamic commentManager;
  final dynamic idHoliday;
  final String? name;
  final String? name_EN;
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? titleEn;
  final String? firstnameEn;
  final String? lastnameEn;
  final dynamic holidayName;
  final String? managerFirstnameTh;
  final String? managerLastnameTh;
  final String? managerFirstnameEn;
  final String? managerLastnameEn;
  final String? startText;
  final String? endText;
  final String? createLeaveText;
  final dynamic fileUrl;
  final WithdrawCheckEntity? withdraw;

  LeaveHistoryEntity({
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
    this.withdraw,
    this.fillInApprove,
    this.createDate,
    this.isWithdraw,
    this.commentManager,
    this.idHoliday,
    this.name,
    this.name_EN,
    this.employeeId,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.titleEn,
    this.firstnameEn,
    this.lastnameEn,
    this.holidayName,
    this.managerFirstnameTh,
    this.managerLastnameTh,
    this.managerFirstnameEn,
    this.managerLastnameEn,
    this.startText,
    this.endText,
    this.createLeaveText,
    this.fileUrl,
  });
}

class WithdrawCheckEntity {
  final int? idLeaveEmployeesWithdraw;
  final int? idLeave;
  final int? managerApprove;
  final int? isApprove;
  final DateTime? approveDate;
  final dynamic fillInCreate;
  final int? fillInApprove;
  final DateTime? createDate;
  final int? isActive;
  final String? commentManager;

  WithdrawCheckEntity({
    this.idLeaveEmployeesWithdraw,
    this.idLeave,
    this.managerApprove,
    this.isApprove,
    this.approveDate,
    this.fillInCreate,
    this.fillInApprove,
    this.createDate,
    this.isActive,
    this.commentManager,
  });

}
