import 'package:equatable/equatable.dart';

class NotiattendanceEntity extends Equatable {
  final DateTime? date;
  final HolidayEntity? holiday;
  final PatternEntity? pattern;
  final List<OtEntity>? requestTime;
  final List<dynamic>? requestCompensate;
  final AttendanceClassEntity? attendance;
  final List<LeaveEntity>? leave;
  final List<OtEntity>? ot;
  final EmployeeEntity? employee;
  final bool? isCompensation;
  final List<AttendanceDisplay>? attendanceDisplay;
  final bool? absent;
  final bool? isLate;
  final bool? isEarlyOut;

  const NotiattendanceEntity({
    this.date,
    this.holiday,
    this.pattern,
    this.requestTime,
    this.requestCompensate,
    this.attendance,
    this.leave,
    this.ot,
    this.employee,
    this.isCompensation,
    this.attendanceDisplay,
    this.absent,
    this.isLate,
    this.isEarlyOut,
  });

  @override
  List<Object?> get props => [
        date,
        holiday,
        pattern,
        requestTime,
        requestCompensate,
        attendance,
        leave,
        ot,
        employee,
        isCompensation,
        attendanceDisplay,
        absent,
        isLate,
        isEarlyOut,
      ];
}

class AttendanceClassEntity extends Equatable {
  final List<CheckEntity?>? checkIn;
  final List<CheckEntity?>? checkOut;

  const AttendanceClassEntity({
    this.checkIn,
    this.checkOut,
  });

  @override
  List<Object?> get props => [
        checkIn,
        checkOut,
      ];
}

class AttendanceDisplay {
  final CheckEntity? checkIn;
  final CheckEntity? checkOut;

  AttendanceDisplay({
    this.checkIn,
    this.checkOut,
  });
}

class CheckEntity extends Equatable {
  final int? idAttendance;
  final DateTime? attendanceDateTime;
  final int? isCheckIn;
  final dynamic workDay;
  final int? idAttendanceType;
  final int? idGpsLocations;
  final int? idEmployees;
  final int? idCompany;
  final dynamic idShift;
  final dynamic idGroupGpsLocations;
  final dynamic gpsAddress;
  final dynamic latitude;
  final dynamic longitude;
  final String? gpsLocationsName;
  final dynamic groupGpsLocationsName;
  final String? attendanceTextTime;
  final DateTime? attendanceTextDateTime;

  const CheckEntity({
    this.idAttendance,
    this.attendanceDateTime,
    this.isCheckIn,
    this.workDay,
    this.idAttendanceType,
    this.idGpsLocations,
    this.idEmployees,
    this.idCompany,
    this.idShift,
    this.idGroupGpsLocations,
    this.gpsAddress,
    this.latitude,
    this.longitude,
    this.gpsLocationsName,
    this.groupGpsLocationsName,
    this.attendanceTextTime,
    this.attendanceTextDateTime,
  });

  @override
  List<Object?> get props => [
        idAttendance,
        attendanceDateTime,
        isCheckIn,
        workDay,
        idAttendanceType,
        idGpsLocations,
        idEmployees,
        idCompany,
        idShift,
        idGroupGpsLocations,
        gpsAddress,
        latitude,
        longitude,
        gpsLocationsName,
        groupGpsLocationsName,
        attendanceTextTime,
        attendanceTextDateTime,
      ];
}

class EmployeeEntity extends Equatable {
  final int? idEmployees;
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? nicknameTh;
  final String? titleEn;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? nicknameEn;
  final String? gender;
  final String? personalId;
  final String? nationality;
  final String? maritalStatus;
  final String? passportNumber;
  final String? workPermitNumber;
  final String? taxId;
  final String? ssoId;
  final DateTime? birthday;
  final dynamic address;
  final String? houseNo;
  final String? village;
  final String? villageNo;
  final String? alley;
  final String? road;
  final String? subDistrict;
  final String? district;
  final String? provience;
  final String? areaCode;
  final String? telephoneMobile;
  final String? username;
  final String? email;
  final String? emergencyContact;
  final String? emergencyRelationship;
  final String? emergencyPhone;
  final dynamic numberOfChildren;
  final dynamic spouseFirstname;
  final dynamic spouseLastname;
  final dynamic spouseBirthday;
  final dynamic spouseTaxId;
  final String? employmentTime;
  final dynamic timeScan;
  final String? workingLocation;
  final String? filedOffice;
  final DateTime? hiringDate;
  final String? workingType;
  final int? salary;
  final dynamic contractType;
  final dynamic retirementDate;
  final dynamic contractTermainatoinDate;
  final dynamic resignDate;
  final String? bookBank;
  final String? bookBankBranchName;
  final String? bookId;
  final String? reportBankBankName;
  final String? reportBankBankId;
  final String? reportBankBookBankId;
  final String? reportBankName;
  final String? reportBankRef;
  final dynamic costCenterCharge;
  final dynamic costElementCharge;
  final dynamic io;
  final int? idEmploymentType;
  final int? idPaymentType;
  final int? idJobLevel;
  final int? idPersonnelLevel;
  final int? idCompany;
  final dynamic idBranch;
  final int? idRole;
  final int? idManagerLv1;
  final dynamic idManagerLv2;
  final String? password;
  final int? isActive;
  final dynamic createDate;
  final dynamic createBy;
  final DateTime? updateDate;
  final int? updateBy;
  final dynamic lineUserId;
  final int? mainWorkingLocationPoint;
  final String? methodAttendance;
  final String? imageName;
  final dynamic servY;
  final dynamic servM;
  final int? oesyY;
  final int? oesyM;
  final dynamic userPf;
  final DateTime? servPfDate;
  final DateTime? pfDate;
  final dynamic criminalImage;
  final int? isFinger;
  final int? isFingerAffectPayroll;
  final dynamic probationR1Date;
  final int? probationR1Approved;
  final String? probationR1Result;
  final int? probationR1ApproveBy;
  final DateTime? probationR1ApproveDate;
  final String? probationR1Remark;
  final dynamic probationR2Date;
  final int? probationR2Approved;
  final String? probationR2Result;
  final int? probationR2ApproveBy;
  final DateTime? probationR2ApproveDate;
  final String? probationR2Remark;
  final int? expandTimeProbation;
  final dynamic reasonResign;
  final dynamic reasonResignOther;
  final dynamic reasonTerminate;
  final dynamic reasonTerminateOther;
  final int? isBlacklist;
  final dynamic estimatePerformanceResult;
  final int? estimatePerformanceApproved;
  final DateTime? updateEstimatePerformance;
  final int? isOpenRegisterManpower;
  final String? overview;
  final int? isExit;
  final dynamic isPayroll;
  final int? isTax;
  final int? isSelfTaxPaid;
  final int? isSso;
  final int? isPf;
  final String? incomeUnderSection;
  final int? uniwelfareFlexcoins;
  final int? idPosition;
  final String? positionName;
  final String? sectionName;
  final String? departmentName;
  final String? divisionName;
  final String? companyName;
  final int? idEmployeeEmploymentType;
  final String? employmentTypeName;
  final int? idEmployeePosition;
  final DateTime? employeePositionStart;
  final int? idEmployeePersonnelLevel;
  final DateTime? employeePersonnelLevelStart;
  final String? personnelLevelName;
  final String? personnelLevelGroupName;
  final String? jobLevelName;
  final String? jobGroupLevelName;
  final String? paymentTypeName;
  final String? paymentRoundName;
  final String? groupGpsLocationsName;
  final int? managerLv1IdManagerLv1;
  final String? managerLv1FirstnameTh;
  final String? managerLv1LastnameTh;
  final String? managerLv1FirstnameEn;
  final String? managerLv1LastnameEn;
  final String? managerLv1Email;
  final int? managerLv2IdManagerLv2;
  final String? managerLv2FirstnameTh;
  final String? managerLv2LastnameTh;
  final String? managerLv2FirstnameEn;
  final String? managerLv2LastnameEn;
  final String? managerLv2Email;
  final String? managerLv1PositionName;
  final String? managerLv2PositionName;
  final int? idEmployeeSalary;
  final dynamic idManagerGroupLv1;
  final dynamic idManagerGroupLv2;
  final dynamic managerGroupLv1ManagerGroupName;
  final dynamic managerGroupLv2ManagerGroupName;
  final String? managerApproveProbationR1FirstnameTh;
  final String? managerApproveProbationR1LastnameTh;
  final String? managerApproveProbationR2FirstnameTh;
  final String? managerApproveProbationR2LastnameTh;

  const EmployeeEntity({
    this.idEmployees,
    this.employeeId,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.nicknameTh,
    this.titleEn,
    this.firstnameEn,
    this.lastnameEn,
    this.nicknameEn,
    this.gender,
    this.personalId,
    this.nationality,
    this.maritalStatus,
    this.passportNumber,
    this.workPermitNumber,
    this.taxId,
    this.ssoId,
    this.birthday,
    this.address,
    this.houseNo,
    this.village,
    this.villageNo,
    this.alley,
    this.road,
    this.subDistrict,
    this.district,
    this.provience,
    this.areaCode,
    this.telephoneMobile,
    this.username,
    this.email,
    this.emergencyContact,
    this.emergencyRelationship,
    this.emergencyPhone,
    this.numberOfChildren,
    this.spouseFirstname,
    this.spouseLastname,
    this.spouseBirthday,
    this.spouseTaxId,
    this.employmentTime,
    this.timeScan,
    this.workingLocation,
    this.filedOffice,
    this.hiringDate,
    this.workingType,
    this.salary,
    this.contractType,
    this.retirementDate,
    this.contractTermainatoinDate,
    this.resignDate,
    this.bookBank,
    this.bookBankBranchName,
    this.bookId,
    this.reportBankBankName,
    this.reportBankBankId,
    this.reportBankBookBankId,
    this.reportBankName,
    this.reportBankRef,
    this.costCenterCharge,
    this.costElementCharge,
    this.io,
    this.idEmploymentType,
    this.idPaymentType,
    this.idJobLevel,
    this.idPersonnelLevel,
    this.idCompany,
    this.idBranch,
    this.idRole,
    this.idManagerLv1,
    this.idManagerLv2,
    this.password,
    this.isActive,
    this.createDate,
    this.createBy,
    this.updateDate,
    this.updateBy,
    this.lineUserId,
    this.mainWorkingLocationPoint,
    this.methodAttendance,
    this.imageName,
    this.servY,
    this.servM,
    this.oesyY,
    this.oesyM,
    this.userPf,
    this.servPfDate,
    this.pfDate,
    this.criminalImage,
    this.isFinger,
    this.isFingerAffectPayroll,
    this.probationR1Date,
    this.probationR1Approved,
    this.probationR1Result,
    this.probationR1ApproveBy,
    this.probationR1ApproveDate,
    this.probationR1Remark,
    this.probationR2Date,
    this.probationR2Approved,
    this.probationR2Result,
    this.probationR2ApproveBy,
    this.probationR2ApproveDate,
    this.probationR2Remark,
    this.expandTimeProbation,
    this.reasonResign,
    this.reasonResignOther,
    this.reasonTerminate,
    this.reasonTerminateOther,
    this.isBlacklist,
    this.estimatePerformanceResult,
    this.estimatePerformanceApproved,
    this.updateEstimatePerformance,
    this.isOpenRegisterManpower,
    this.overview,
    this.isExit,
    this.isPayroll,
    this.isTax,
    this.isSelfTaxPaid,
    this.isSso,
    this.isPf,
    this.incomeUnderSection,
    this.uniwelfareFlexcoins,
    this.idPosition,
    this.positionName,
    this.sectionName,
    this.departmentName,
    this.divisionName,
    this.companyName,
    this.idEmployeeEmploymentType,
    this.employmentTypeName,
    this.idEmployeePosition,
    this.employeePositionStart,
    this.idEmployeePersonnelLevel,
    this.employeePersonnelLevelStart,
    this.personnelLevelName,
    this.personnelLevelGroupName,
    this.jobLevelName,
    this.jobGroupLevelName,
    this.paymentTypeName,
    this.paymentRoundName,
    this.groupGpsLocationsName,
    this.managerLv1IdManagerLv1,
    this.managerLv1FirstnameTh,
    this.managerLv1LastnameTh,
    this.managerLv1FirstnameEn,
    this.managerLv1LastnameEn,
    this.managerLv1Email,
    this.managerLv2IdManagerLv2,
    this.managerLv2FirstnameTh,
    this.managerLv2LastnameTh,
    this.managerLv2FirstnameEn,
    this.managerLv2LastnameEn,
    this.managerLv2Email,
    this.managerLv1PositionName,
    this.managerLv2PositionName,
    this.idEmployeeSalary,
    this.idManagerGroupLv1,
    this.idManagerGroupLv2,
    this.managerGroupLv1ManagerGroupName,
    this.managerGroupLv2ManagerGroupName,
    this.managerApproveProbationR1FirstnameTh,
    this.managerApproveProbationR1LastnameTh,
    this.managerApproveProbationR2FirstnameTh,
    this.managerApproveProbationR2LastnameTh,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        employeeId,
        titleTh,
        firstnameTh,
        lastnameTh,
        nicknameTh,
        titleEn,
        firstnameEn,
        lastnameEn,
        nicknameEn,
        gender,
        personalId,
        nationality,
        maritalStatus,
        passportNumber,
        workPermitNumber,
        taxId,
        ssoId,
        birthday,
        address,
        houseNo,
        village,
        villageNo,
        alley,
        road,
        subDistrict,
        district,
        provience,
        areaCode,
        telephoneMobile,
        username,
        email,
        emergencyContact,
        emergencyRelationship,
        emergencyPhone,
        numberOfChildren,
        spouseFirstname,
        spouseLastname,
        spouseBirthday,
        spouseTaxId,
        employmentTime,
        timeScan,
        workingLocation,
        filedOffice,
        hiringDate,
        workingType,
        salary,
        contractType,
        retirementDate,
        contractTermainatoinDate,
        resignDate,
        bookBank,
        bookBankBranchName,
        bookId,
        reportBankBankName,
        reportBankBankId,
        reportBankBookBankId,
        reportBankName,
        reportBankRef,
        costCenterCharge,
        costElementCharge,
        io,
        idEmploymentType,
        idPaymentType,
        idJobLevel,
        idPersonnelLevel,
        idCompany,
        idBranch,
        idRole,
        idManagerLv1,
        idManagerLv2,
        password,
        isActive,
        createDate,
        createBy,
        updateDate,
        updateBy,
        lineUserId,
        mainWorkingLocationPoint,
        methodAttendance,
        imageName,
        servY,
        servM,
        oesyY,
        oesyM,
        userPf,
        servPfDate,
        pfDate,
        criminalImage,
        isFinger,
        isFingerAffectPayroll,
        probationR1Date,
        probationR1Approved,
        probationR1Result,
        probationR1ApproveBy,
        probationR1ApproveDate,
        probationR1Remark,
        probationR2Date,
        probationR2Approved,
        probationR2Result,
        probationR2ApproveBy,
        probationR2ApproveDate,
        probationR2Remark,
        expandTimeProbation,
        reasonResign,
        reasonResignOther,
        reasonTerminate,
        reasonTerminateOther,
        isBlacklist,
        estimatePerformanceResult,
        estimatePerformanceApproved,
        updateEstimatePerformance,
        isOpenRegisterManpower,
        overview,
        isExit,
        isPayroll,
        isTax,
        isSelfTaxPaid,
        isSso,
        isPf,
        incomeUnderSection,
        uniwelfareFlexcoins,
        idPosition,
        positionName,
        sectionName,
        departmentName,
        divisionName,
        companyName,
        idEmployeeEmploymentType,
        employmentTypeName,
        idEmployeePosition,
        employeePositionStart,
        idEmployeePersonnelLevel,
        employeePersonnelLevelStart,
        personnelLevelName,
        personnelLevelGroupName,
        jobLevelName,
        jobGroupLevelName,
        paymentTypeName,
        paymentRoundName,
        groupGpsLocationsName,
        managerLv1IdManagerLv1,
        managerLv1FirstnameTh,
        managerLv1LastnameTh,
        managerLv1FirstnameEn,
        managerLv1LastnameEn,
        managerLv1Email,
        managerLv2IdManagerLv2,
        managerLv2FirstnameTh,
        managerLv2LastnameTh,
        managerLv2FirstnameEn,
        managerLv2LastnameEn,
        managerLv2Email,
        managerLv1PositionName,
        managerLv2PositionName,
        idEmployeeSalary,
        idManagerGroupLv1,
        idManagerGroupLv2,
        managerGroupLv1ManagerGroupName,
        managerGroupLv2ManagerGroupName,
        managerApproveProbationR1FirstnameTh,
        managerApproveProbationR1LastnameTh,
        managerApproveProbationR2FirstnameTh,
        managerApproveProbationR2LastnameTh,
      ];
}

class OtEntity extends Equatable {
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
  final int? managerLv2ApproveBy;
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
  final dynamic idManagerGroupLv1;
  final dynamic idManagerGroupLv2;
  final String? name;
  final String? reasonName;
  final String? managerLv1FirstnameTh;
  final String? managerLv1LastnameTh;
  final String? managerLv1FirstnameEn;
  final String? managerLv1LastnameEn;
  final String? managerLv1Email;
  final String? managerLv2FirstnameTh;
  final String? managerLv2LastnameTh;
  final String? managerLv2FirstnameEn;
  final String? managerLv2LastnameEn;
  final String? managerLv2Email;
  final String? createDateText;
  final String? startText;
  final String? endText;

  const OtEntity({
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
    this.idManagerGroupLv1,
    this.idManagerGroupLv2,
    this.name,
    this.reasonName,
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
    this.createDateText,
    this.startText,
    this.endText,
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
        idManagerGroupLv1,
        idManagerGroupLv2,
        name,
        reasonName,
        managerLv1FirstnameTh,
        managerLv1LastnameTh,
        managerLv1FirstnameEn,
        managerLv1LastnameEn,
        managerLv1Email,
        managerLv2FirstnameTh,
        managerLv2LastnameTh,
        managerLv2FirstnameEn,
        managerLv2LastnameEn,
        managerLv2Email,
        createDateText,
        startText,
        endText,
      ];
}

class PatternEntity extends Equatable {
  final int? idShiftPattern;
  final int? indexScheduleId;
  final int? idShift;
  final String? shiftName;
  final int? idShiftType;
  final String? shiftTypeName;
  final String? timeIn;
  final String? timeOut;
  final int? breakTime;
  final int? isWorkingDay;
  final int? lateIn;
  final int? workingHours;
  final int? period;
  final int? idShiftGroup;
  final String? shiftGroupName;
  final int? shiftStartInMonday;
  final DateTime? shiftStartDate;
  final int? shiftNumber;
  final int? workDay;
  final int? isTimeFrame;
  final int? idWorkingType;
  final String? workingTypeName;

  const PatternEntity({
    this.idShiftPattern,
    this.indexScheduleId,
    this.idShift,
    this.shiftName,
    this.idShiftType,
    this.shiftTypeName,
    this.timeIn,
    this.timeOut,
    this.breakTime,
    this.isWorkingDay,
    this.lateIn,
    this.workingHours,
    this.period,
    this.idShiftGroup,
    this.shiftGroupName,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.shiftNumber,
    this.workDay,
    this.isTimeFrame,
    this.idWorkingType,
    this.workingTypeName,
  });

  @override
  List<Object?> get props => [
        idShiftPattern,
        indexScheduleId,
        idShift,
        shiftName,
        idShiftType,
        shiftTypeName,
        timeIn,
        timeOut,
        breakTime,
        isWorkingDay,
        lateIn,
        workingHours,
        period,
        idShiftGroup,
        shiftGroupName,
        shiftStartInMonday,
        shiftStartDate,
        shiftNumber,
        workDay,
        isTimeFrame,
        idWorkingType,
        workingTypeName,
      ];
}

class HolidayEntity extends Equatable {
  final int? idHoliday;
  final String? name;
  final DateTime? dateHoliday;
  final dynamic compensateName;
  final dynamic compensateDate;
  final int? idCompany;
  final int? holidayYear;
  final int? showTimeline;
  final int? isActive;

  const HolidayEntity({
    this.idHoliday,
    this.name,
    this.dateHoliday,
    this.compensateName,
    this.compensateDate,
    this.idCompany,
    this.holidayYear,
    this.showTimeline,
    this.isActive,
  });

  @override
  List<Object?> get props => [
        idHoliday,
        name,
        dateHoliday,
        compensateName,
        compensateDate,
        idCompany,
        holidayYear,
        showTimeline,
        isActive,
      ];
}

class RequestTimeEntity extends Equatable {
  final int? idRequestTime;
  final DateTime? start;
  final DateTime? end;
  final DateTime? workDate;
  final int? idRequestReason;
  final int? idRequestType;
  final String? otherReason;
  final int? idEmployees;
  final int? isManagerLv1Approve;
  final dynamic isManagerLv2Approve;
  final int? amountHours;
  final int? xOt;
  final int? xOtHoliday;
  final int? xWorkingDailyHoliday;
  final int? xWorkingMonthlyHoliday;
  final int? isActive;
  final int? managerLv1ApproveBy;
  final DateTime? managerLv1ApproveDate;
  final int? managerLv2ApproveBy;
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
  final String? managerLv1FirstnameTh;
  final String? managerLv1LastnameTh;
  final String? managerLv1FirstnameEn;
  final String? managerLv1LastnameEn;
  final String? managerLv1Email;
  final String? managerLv2FirstnameTh;
  final String? managerLv2LastnameTh;
  final String? managerLv2FirstnameEn;
  final String? managerLv2LastnameEn;
  final String? managerLv2Email;
  final String? createDateText;
  final String? startText;
  final String? endText;

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
    this.createDateText,
    this.startText,
    this.endText,
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
        reasonName,
        managerLv1FirstnameTh,
        managerLv1LastnameTh,
        managerLv1FirstnameEn,
        managerLv1LastnameEn,
        managerLv1Email,
        managerLv2FirstnameTh,
        managerLv2LastnameTh,
        managerLv2FirstnameEn,
        managerLv2LastnameEn,
        managerLv2Email,
        createDateText,
        startText,
        endText,
      ];
}

class LeaveEntity extends Equatable {
  final int? idLeave;
  final int? idLeaveType;
  final String? description;
  final dynamic filename;
  final DateTime? start;
  final DateTime? end;
  final int? idEmployees;
  final double? used;
  final int? quota;
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
  final dynamic idManagerGroup;
  final String? name;
  final String? startText;
  final String? endText;

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
    this.name,
    this.startText,
    this.endText,
    this.ccEmail,
    this.idManagerGroup,
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
        name,
        startText,
        endText,
        ccEmail,
        idManagerGroup,
      ];
}
