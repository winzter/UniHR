import 'package:equatable/equatable.dart';

class EmployeesLeaveEntity extends Equatable {
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
  final dynamic ccEmail;
  final String? name;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? positionName;
  final String? departmentName;
  final String? imageName;
  final dynamic holidayName;
  final String? startText;
  final String? endText;
  final String? approveDateText;
  final String? createDateText;
  final String? imageUrl;
  final dynamic fileUrl;
  final String? firstnameEn;
  final String? lastnameEn;

  EmployeesLeaveEntity({
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
    this.name,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.positionName,
    this.departmentName,
    this.imageName,
    this.holidayName,
    this.startText,
    this.endText,
    this.approveDateText,
    this.createDateText,
    this.imageUrl,
    this.fileUrl,
    this.firstnameEn,
    this.lastnameEn,
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
        name,
        titleTh,
        firstnameTh,
        lastnameTh,
        positionName,
        departmentName,
        imageName,
        holidayName,
        startText,
        endText,
        approveDateText,
        createDateText,
        imageUrl,
        fileUrl,
        firstnameEn,
        lastnameEn,
      ];
}
