import 'package:equatable/equatable.dart';

class RequestTimeEntity extends Equatable {
  final int? idRequestTime;
  final DateTime? start;
  final DateTime? end;
  final DateTime? workDate;
  final int? idRequestReason;
  final int? idRequestType;
  final String? otherReason;
  final int? idEmployees;
  final dynamic isManagerLv1Approve;
  final dynamic isManagerLv2Approve;
  final double? amountHours;
  final double? xOt;
  final double? xOtHoliday;
  final double? xWorkingDailyHoliday;
  final double? xWorkingMonthlyHoliday;
  final int? isActive;
  final int? managerLv1ApproveBy;
  final dynamic managerLv1ApproveDate;
  final dynamic managerLv2ApproveBy;
  final dynamic managerLv2ApproveDate;
  final dynamic requestTimecol;
  final DateTime? createDate;
  final int? isDoubleApproval;
  final int? approvalLevel;
  final dynamic fillInCreate;
  final dynamic fillInApproveLv1;
  final dynamic fillInApproveLv2;
  final dynamic isWithdraw;
  final dynamic payShift;
  final dynamic commentManagerLv1;
  final dynamic commentManagerLv2;
  final String? name;
  final String? reasonName;
  final String? reasonName_EN;
  final String? managerLv1FirstnameTh;
  final String? managerLv1LastnameTh;
  final String? managerLv1FirstnameEn;
  final String? managerLv1LastnameEn;
  final String? managerLv1Email;
  final dynamic managerLv2FirstnameTh;
  final dynamic managerLv2LastnameTh;
  final dynamic managerLv2FirstnameEn;
  final dynamic managerLv2LastnameEn;
  final dynamic managerLv2Email;
  final String? startText;
  final String? endText;
  final String? createDateText;
  final String? workDateText;
  final dynamic managerLv1ApproveDateText;
  final dynamic managerLv2ApproveDateText;

  const RequestTimeEntity({
    this.idRequestTime,
    this.start,
    this.end,
    this.workDate,
    this.idRequestReason,
    this.idRequestType,
    this.otherReason,
    this.idEmployees,
    this.isManagerLv1Approve,
    this.isManagerLv2Approve,
    this.amountHours,
    this.xOt,
    this.xOtHoliday,
    this.xWorkingDailyHoliday,
    this.xWorkingMonthlyHoliday,
    this.isActive,
    this.managerLv1ApproveBy,
    this.managerLv1ApproveDate,
    this.managerLv2ApproveBy,
    this.managerLv2ApproveDate,
    this.requestTimecol,
    this.createDate,
    this.isDoubleApproval,
    this.approvalLevel,
    this.fillInCreate,
    this.fillInApproveLv1,
    this.fillInApproveLv2,
    this.isWithdraw,
    this.payShift,
    this.commentManagerLv1,
    this.commentManagerLv2,
    this.name,
    this.reasonName,
    this.reasonName_EN,
    this.managerLv1FirstnameTh,
    this.managerLv1LastnameTh,
    this.managerLv1FirstnameEn,
    this.managerLv1LastnameEn,
    this.managerLv1Email,
    this.managerLv2FirstnameTh,
    this.managerLv2LastnameTh,
    this.managerLv2FirstnameEn,
    this.managerLv2LastnameEn,
    this.managerLv2Email,
    this.startText,
    this.endText,
    this.createDateText,
    this.workDateText,
    this.managerLv1ApproveDateText,
    this.managerLv2ApproveDateText,
  });

  @override
  List<Object?> get props => [];
}
