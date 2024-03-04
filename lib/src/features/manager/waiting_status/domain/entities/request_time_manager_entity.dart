import 'package:equatable/equatable.dart';

class RequestTimeManager extends Equatable{
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
  final int? amountHours;
  final int? xOt;
  final int? xOtHoliday;
  final int? xWorkingDailyHoliday;
  final int? xWorkingMonthlyHoliday;
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
  final String? firstnameTh;
  final String? lastnameTh;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? positionName;
  final dynamic departmentName;
  final int? idCompany;
  final String? reasonName;
  final dynamic imageName;
  final String? startText;
  final String? endText;
  final String? createDateText;
  final String? workDateText;
  final String? managerLv1ApproveDateText;
  final dynamic imageUrl;

  const RequestTimeManager({
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
    this.firstnameTh,
    this.lastnameTh,
    this.firstnameEn,
    this.lastnameEn,
    this.positionName,
    this.departmentName,
    this.idCompany,
    this.reasonName,
    this.imageName,
    this.startText,
    this.endText,
    this.createDateText,
    this.workDateText,
    this.managerLv1ApproveDateText,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
    idRequestTime,
    start,
    end,
    workDate,
    idRequestReason,
    idRequestType,
    otherReason,
    idEmployees,
    isManagerLv1Approve,
    isManagerLv2Approve,
    amountHours,
    xOt,
    xOtHoliday,
    xWorkingDailyHoliday,
    xWorkingMonthlyHoliday,
    isActive,
    managerLv1ApproveBy,
    managerLv1ApproveDate,
    managerLv2ApproveBy,
    managerLv2ApproveDate,
    requestTimecol,
    createDate,
    isDoubleApproval,
    approvalLevel,
    fillInCreate,
    fillInApproveLv1,
    fillInApproveLv2,
    isWithdraw,
    payShift,
    commentManagerLv1,
    commentManagerLv2,
    name,
    firstnameTh,
    lastnameTh,
    firstnameEn,
    lastnameEn,
    positionName,
    departmentName,
    idCompany,
    reasonName,
    imageName,
    startText,
    endText,
    createDateText,
    workDateText,
    imageUrl,
  ];
}
