import 'package:equatable/equatable.dart';

class WithdrawEntity extends Equatable{
  final int? idLeaveEmployeesWithdraw;
  final int? idLeave;
  final int? managerApprove;
  final int? isApprove;
  final DateTime? approveDate;
  final dynamic fillInCreate;
  final dynamic fillInApprove;
  final DateTime? createDate;
  final int? isActive;
  final dynamic commentManager;
  final int? idLeaveType;
  final String? name;
  final int? isFullDay;
  final DateTime? start;
  final DateTime? end;
  final String? managerFirstnameTh;
  final String? managerLastnameTh;
  final String? managerFirstnameEn;
  final String? managerLastnameEn;
  final String? managerEmail;
  final String? startText;
  final String? endText;
  final String? approveDateText;
  final String? createDateText;

 const WithdrawEntity({
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
    this.idLeaveType,
    this.name,
    this.isFullDay,
    this.start,
    this.end,
    this.managerFirstnameTh,
    this.managerLastnameTh,
    this.managerFirstnameEn,
    this.managerLastnameEn,
    this.managerEmail,
    this.startText,
    this.endText,
    this.approveDateText,
    this.createDateText,
  });

  @override
  List<Object?> get props => [];

}