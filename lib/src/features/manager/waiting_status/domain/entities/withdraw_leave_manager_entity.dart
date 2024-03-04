import 'package:equatable/equatable.dart';

class WithdrawLeaveManager extends Equatable {
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
  final String? name_EN;
  final DateTime? start;
  final DateTime? end;
  final int? isFullDay;
  final String? managerFirstnameTh;
  final String? managerLastnameTh;
  final String? managerFirstnameEn;
  final String? managerLastnameEn;
  final String? managerEmail;
  final String? firstnameTh;
  final String? firstnameEn;
  final String? lastnameTh;
  final String? lastnameEn;
  final String? positionName;
  final dynamic imageName;
  final int? idEmployees;
  final String? startText;
  final String? endText;
  final String? approveDateText;
  final String? createDateText;
  final dynamic imageUrl;
  final dynamic fileUrl;

  const WithdrawLeaveManager({
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
    this.name_EN,
    this.start,
    this.end,
    this.isFullDay,
    this.managerFirstnameTh,
    this.managerLastnameTh,
    this.managerFirstnameEn,
    this.managerLastnameEn,
    this.managerEmail,
    this.firstnameTh,
    this.firstnameEn,
    this.lastnameTh,
    this.lastnameEn,
    this.positionName,
    this.imageName,
    this.idEmployees,
    this.startText,
    this.endText,
    this.approveDateText,
    this.createDateText,
    this.imageUrl,
    this.fileUrl,
  });

  @override
  List<Object?> get props => [
        idLeaveEmployeesWithdraw,
        idLeave,
        managerApprove,
        isApprove,
        approveDate,
        fillInCreate,
        fillInApprove,
        createDate,
        isActive,
        commentManager,
        idLeaveType,
        name,
        name_EN,
        start,
        end,
        isFullDay,
        managerFirstnameTh,
        managerLastnameTh,
        managerFirstnameEn,
        managerLastnameEn,
        managerEmail,
        firstnameTh,
        firstnameEn,
        lastnameTh,
        lastnameEn,
        positionName,
        imageName,
        idEmployees,
        startText,
        endText,
        approveDateText,
        createDateText,
        imageUrl,
        fileUrl,
      ];
}
