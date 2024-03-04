import 'package:equatable/equatable.dart';

class EachEmployeeEntity extends Equatable {
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
  final dynamic probationR2Date;
  final int? probationR2Approved;
  final String? probationR2Result;
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
  final int? idPosition;
  final String? positionName;
  final String? positionName_EN;
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
  final dynamic managerLv2IdManagerLv2;
  final dynamic managerLv2FirstnameTh;
  final dynamic managerLv2LastnameTh;
  final dynamic managerLv2FirstnameEn;
  final dynamic managerLv2LastnameEn;
  final dynamic managerLv2Email;
  final String? managerLv1PositionName;
  final dynamic managerLv2PositionName;
  final int? idEmployeeSalary;
  final dynamic idManagerGroupLv1;
  final dynamic idManagerGroupLv2;
  final dynamic managerGroupLv1ManagerGroupName;
  final dynamic managerGroupLv2ManagerGroupName;
  final List<Education>? educations;
  final Shift? shift;
  final List<dynamic>? family;
  final List<Experience>? experience;
  final List<dynamic>? roles;
  final String? imageProfile;

  EachEmployeeEntity({
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
    this.probationR2Date,
    this.probationR2Approved,
    this.probationR2Result,
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
    this.idPosition,
    this.positionName,
    this.positionName_EN,
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
    this.educations,
    this.shift,
    this.family,
    this.experience,
    this.roles,
    this.imageProfile,
  });

  factory EachEmployeeEntity.fromJson(Map<String, dynamic> json) =>
      EachEmployeeEntity(
        idEmployees: json["idEmployees"],
        employeeId: json["employeeID"],
        titleTh: json["title_TH"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        nicknameTh: json["nickname_TH"],
        titleEn: json["title_EN"],
        firstnameEn: json["firstname_EN"],
        lastnameEn: json["lastname_EN"],
        nicknameEn: json["nickname_EN"],
        gender: json["gender"],
        personalId: json["personalID"],
        nationality: json["nationality"],
        maritalStatus: json["maritalStatus"],
        passportNumber: json["passportNumber"],
        workPermitNumber: json["workPermitNumber"],
        taxId: json["taxID"],
        ssoId: json["ssoID"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        address: json["address"],
        houseNo: json["houseNo"],
        village: json["village"],
        villageNo: json["villageNo"],
        alley: json["alley"],
        road: json["road"],
        subDistrict: json["subDistrict"],
        district: json["district"],
        provience: json["provience"],
        areaCode: json["areaCode"],
        telephoneMobile: json["telephoneMobile"],
        username: json["username"],
        email: json["email"],
        emergencyContact: json["emergencyContact"],
        emergencyRelationship: json["emergencyRelationship"],
        emergencyPhone: json["emergencyPhone"],
        numberOfChildren: json["numberOfChildren"],
        spouseFirstname: json["spouseFirstname"],
        spouseLastname: json["spouseLastname"],
        spouseBirthday: json["spouseBirthday"],
        spouseTaxId: json["spouseTaxID"],
        employmentTime: json["employmentTime"],
        timeScan: json["timeScan"],
        workingLocation: json["workingLocation"],
        filedOffice: json["filed_office"],
        hiringDate: json["hiringDate"] == null
            ? null
            : DateTime.parse(json["hiringDate"]),
        workingType: json["workingType"],
        salary: json["salary"],
        contractType: json["contractType"],
        retirementDate: json["retirementDate"],
        contractTermainatoinDate: json["contractTermainatoinDate"],
        resignDate: json["resignDate"],
        bookBank: json["bookBank"],
        bookBankBranchName: json["bookBankBranchName"],
        bookId: json["bookID"],
        reportBankBankName: json["reportBankBankName"],
        reportBankBankId: json["reportBankBankID"],
        reportBankBookBankId: json["reportBankBookBankID"],
        reportBankName: json["reportBankName"],
        reportBankRef: json["reportBankRef"],
        costCenterCharge: json["costCenterCharge"],
        costElementCharge: json["costElementCharge"],
        io: json["io"],
        idEmploymentType: json["idEmploymentType"],
        idPaymentType: json["idPaymentType"],
        idJobLevel: json["idJobLevel"],
        idPersonnelLevel: json["idPersonnelLevel"],
        idCompany: json["idCompany"],
        idBranch: json["idBranch"],
        idRole: json["idRole"],
        idManagerLv1: json["idManagerLV1"],
        idManagerLv2: json["idManagerLV2"],
        password: json["password"],
        isActive: json["isActive"],
        createDate: json["createDate"],
        createBy: json["createBy"],
        updateDate: json["updateDate"] == null
            ? null
            : DateTime.parse(json["updateDate"]),
        updateBy: json["updateBy"],
        lineUserId: json["lineUserId"],
        mainWorkingLocationPoint: json["mainWorkingLocationPoint"],
        methodAttendance: json["methodAttendance"],
        imageName: json["imageName"],
        servY: json["Serv_Y"],
        servM: json["Serv_M"],
        oesyY: json["OESY_Y"],
        oesyM: json["OESY_M"],
        userPf: json["userPF"],
        servPfDate: json["ServPFDate"] == null
            ? null
            : DateTime.parse(json["ServPFDate"]),
        pfDate: json["PFDate"] == null ? null : DateTime.parse(json["PFDate"]),
        criminalImage: json["criminalImage"],
        isFinger: json["isFinger"],
        isFingerAffectPayroll: json["isFingerAffectPayroll"],
        probationR1Date: json["probationR1Date"],
        probationR1Approved: json["probationR1Approved"],
        probationR1Result: json["probationR1Result"],
        probationR2Date: json["probationR2Date"],
        probationR2Approved: json["probationR2Approved"],
        probationR2Result: json["probationR2Result"],
        expandTimeProbation: json["expandTimeProbation"],
        reasonResign: json["reasonResign"],
        reasonResignOther: json["reasonResignOther"],
        reasonTerminate: json["reasonTerminate"],
        reasonTerminateOther: json["reasonTerminateOther"],
        isBlacklist: json["isBlacklist"],
        estimatePerformanceResult: json["estimatePerformanceResult"],
        estimatePerformanceApproved: json["estimatePerformanceApproved"],
        updateEstimatePerformance: json["updateEstimatePerformance"] == null
            ? null
            : DateTime.parse(json["updateEstimatePerformance"]),
        isOpenRegisterManpower: json["isOpenRegisterManpower"],
        overview: json["overview"],
        isExit: json["isExit"],
        isPayroll: json["isPayroll"],
        idPosition: json["idPosition"],
        positionName: json["positionName"],
        positionName_EN: json["positionName_EN"],
        sectionName: json["sectionName"],
        departmentName: json["departmentName"],
        divisionName: json["divisionName"],
        companyName: json["companyName"],
        idEmployeeEmploymentType: json["idEmployeeEmploymentType"],
        employmentTypeName: json["employmentTypeName"],
        idEmployeePosition: json["idEmployeePosition"],
        employeePositionStart: json["employeePositionStart"] == null
            ? null
            : DateTime.parse(json["employeePositionStart"]),
        idEmployeePersonnelLevel: json["idEmployeePersonnelLevel"],
        employeePersonnelLevelStart: json["employeePersonnelLevelStart"] == null
            ? null
            : DateTime.parse(json["employeePersonnelLevelStart"]),
        personnelLevelName: json["personnelLevelName"],
        personnelLevelGroupName: json["personnelLevelGroupName"],
        jobLevelName: json["jobLevelName"],
        jobGroupLevelName: json["jobGroupLevelName"],
        paymentTypeName: json["paymentTypeName"],
        paymentRoundName: json["paymentRoundName"],
        groupGpsLocationsName: json["groupGpsLocationsName"],
        managerLv1IdManagerLv1: json["managerLV1_idManagerLV1"],
        managerLv1FirstnameTh: json["managerLV1_firstname_TH"],
        managerLv1LastnameTh: json["managerLV1_lastname_TH"],
        managerLv1FirstnameEn: json["managerLV1_firstname_EN"],
        managerLv1LastnameEn: json["managerLV1_lastname_EN"],
        managerLv1Email: json["managerLV1_email"],
        managerLv2IdManagerLv2: json["managerLV2_idManagerLV2"],
        managerLv2FirstnameTh: json["managerLV2_firstname_TH"],
        managerLv2LastnameTh: json["managerLV2_lastname_TH"],
        managerLv2FirstnameEn: json["managerLV2_firstname_EN"],
        managerLv2LastnameEn: json["managerLV2_lastname_EN"],
        managerLv2Email: json["managerLV2_email"],
        managerLv1PositionName: json["managerLV1_positionName"],
        managerLv2PositionName: json["managerLV2_positionName"],
        idEmployeeSalary: json["idEmployeeSalary"],
        idManagerGroupLv1: json["idManagerGroupLV1"],
        idManagerGroupLv2: json["idManagerGroupLV2"],
        managerGroupLv1ManagerGroupName:
            json["managerGroupLV1_managerGroupName"],
        managerGroupLv2ManagerGroupName:
            json["managerGroupLV2_managerGroupName"],
        educations: json["educations"] == null
            ? []
            : List<Education>.from(
                json["educations"]!.map((x) => Education.fromJson(x))),
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        family: json["family"] == null
            ? []
            : List<dynamic>.from(json["family"]!.map((x) => x)),
        experience: json["experience"] == null
            ? []
            : List<Experience>.from(
                json["experience"]!.map((x) => Experience.fromJson(x))),
        roles: json["roles"] == null
            ? []
            : List<dynamic>.from(json["roles"]!.map((x) => x)),
        imageProfile: json["imageProfile"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
        "employeeID": employeeId,
        "title_TH": titleTh,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "nickname_TH": nicknameTh,
        "title_EN": titleEn,
        "firstname_EN": firstnameEn,
        "lastname_EN": lastnameEn,
        "nickname_EN": nicknameEn,
        "gender": gender,
        "personalID": personalId,
        "nationality": nationality,
        "maritalStatus": maritalStatus,
        "passportNumber": passportNumber,
        "workPermitNumber": workPermitNumber,
        "taxID": taxId,
        "ssoID": ssoId,
        "birthday": birthday?.toIso8601String(),
        "address": address,
        "houseNo": houseNo,
        "village": village,
        "villageNo": villageNo,
        "alley": alley,
        "road": road,
        "subDistrict": subDistrict,
        "district": district,
        "provience": provience,
        "areaCode": areaCode,
        "telephoneMobile": telephoneMobile,
        "username": username,
        "email": email,
        "emergencyContact": emergencyContact,
        "emergencyRelationship": emergencyRelationship,
        "emergencyPhone": emergencyPhone,
        "numberOfChildren": numberOfChildren,
        "spouseFirstname": spouseFirstname,
        "spouseLastname": spouseLastname,
        "spouseBirthday": spouseBirthday,
        "spouseTaxID": spouseTaxId,
        "employmentTime": employmentTime,
        "timeScan": timeScan,
        "workingLocation": workingLocation,
        "filed_office": filedOffice,
        "hiringDate": hiringDate?.toIso8601String(),
        "workingType": workingType,
        "salary": salary,
        "contractType": contractType,
        "retirementDate": retirementDate,
        "contractTermainatoinDate": contractTermainatoinDate,
        "resignDate": resignDate,
        "bookBank": bookBank,
        "bookBankBranchName": bookBankBranchName,
        "bookID": bookId,
        "reportBankBankName": reportBankBankName,
        "reportBankBankID": reportBankBankId,
        "reportBankBookBankID": reportBankBookBankId,
        "reportBankName": reportBankName,
        "reportBankRef": reportBankRef,
        "costCenterCharge": costCenterCharge,
        "costElementCharge": costElementCharge,
        "io": io,
        "idEmploymentType": idEmploymentType,
        "idPaymentType": idPaymentType,
        "idJobLevel": idJobLevel,
        "idPersonnelLevel": idPersonnelLevel,
        "idCompany": idCompany,
        "idBranch": idBranch,
        "idRole": idRole,
        "idManagerLV1": idManagerLv1,
        "idManagerLV2": idManagerLv2,
        "password": password,
        "isActive": isActive,
        "createDate": createDate,
        "createBy": createBy,
        "updateDate": updateDate?.toIso8601String(),
        "updateBy": updateBy,
        "lineUserId": lineUserId,
        "mainWorkingLocationPoint": mainWorkingLocationPoint,
        "methodAttendance": methodAttendance,
        "imageName": imageName,
        "Serv_Y": servY,
        "Serv_M": servM,
        "OESY_Y": oesyY,
        "OESY_M": oesyM,
        "userPF": userPf,
        "ServPFDate": servPfDate?.toIso8601String(),
        "PFDate": pfDate?.toIso8601String(),
        "criminalImage": criminalImage,
        "isFinger": isFinger,
        "isFingerAffectPayroll": isFingerAffectPayroll,
        "probationR1Date": probationR1Date,
        "probationR1Approved": probationR1Approved,
        "probationR1Result": probationR1Result,
        "probationR2Date": probationR2Date,
        "probationR2Approved": probationR2Approved,
        "probationR2Result": probationR2Result,
        "expandTimeProbation": expandTimeProbation,
        "reasonResign": reasonResign,
        "reasonResignOther": reasonResignOther,
        "reasonTerminate": reasonTerminate,
        "reasonTerminateOther": reasonTerminateOther,
        "isBlacklist": isBlacklist,
        "estimatePerformanceResult": estimatePerformanceResult,
        "estimatePerformanceApproved": estimatePerformanceApproved,
        "updateEstimatePerformance":
            updateEstimatePerformance?.toIso8601String(),
        "isOpenRegisterManpower": isOpenRegisterManpower,
        "overview": overview,
        "isExit": isExit,
        "isPayroll": isPayroll,
        "idPosition": idPosition,
        "positionName": positionName,
        "sectionName": sectionName,
        "departmentName": departmentName,
        "divisionName": divisionName,
        "companyName": companyName,
        "idEmployeeEmploymentType": idEmployeeEmploymentType,
        "employmentTypeName": employmentTypeName,
        "idEmployeePosition": idEmployeePosition,
        "employeePositionStart": employeePositionStart?.toIso8601String(),
        "idEmployeePersonnelLevel": idEmployeePersonnelLevel,
        "employeePersonnelLevelStart":
            employeePersonnelLevelStart?.toIso8601String(),
        "personnelLevelName": personnelLevelName,
        "personnelLevelGroupName": personnelLevelGroupName,
        "jobLevelName": jobLevelName,
        "jobGroupLevelName": jobGroupLevelName,
        "paymentTypeName": paymentTypeName,
        "paymentRoundName": paymentRoundName,
        "groupGpsLocationsName": groupGpsLocationsName,
        "managerLV1_idManagerLV1": managerLv1IdManagerLv1,
        "managerLV1_firstname_TH": managerLv1FirstnameTh,
        "managerLV1_lastname_TH": managerLv1LastnameTh,
        "managerLV1_firstname_EN": managerLv1FirstnameEn,
        "managerLV1_lastname_EN": managerLv1LastnameEn,
        "managerLV1_email": managerLv1Email,
        "managerLV2_idManagerLV2": managerLv2IdManagerLv2,
        "managerLV2_firstname_TH": managerLv2FirstnameTh,
        "managerLV2_lastname_TH": managerLv2LastnameTh,
        "managerLV2_firstname_EN": managerLv2FirstnameEn,
        "managerLV2_lastname_EN": managerLv2LastnameEn,
        "managerLV2_email": managerLv2Email,
        "managerLV1_positionName": managerLv1PositionName,
        "managerLV2_positionName": managerLv2PositionName,
        "idEmployeeSalary": idEmployeeSalary,
        "idManagerGroupLV1": idManagerGroupLv1,
        "idManagerGroupLV2": idManagerGroupLv2,
        "managerGroupLV1_managerGroupName": managerGroupLv1ManagerGroupName,
        "managerGroupLV2_managerGroupName": managerGroupLv2ManagerGroupName,
        "educations": educations == null
            ? []
            : List<dynamic>.from(educations!.map((x) => x.toJson())),
        "shift": shift?.toJson(),
        "family":
            family == null ? [] : List<dynamic>.from(family!.map((x) => x)),
        "experience": experience == null
            ? []
            : List<dynamic>.from(experience!.map((x) => x.toJson())),
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "imageProfile": imageProfile,
      };

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
        probationR2Date,
        probationR2Approved,
        probationR2Result,
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
        educations,
        shift,
        family,
        experience,
        roles,
        imageProfile,
      ];
}

class Education {
  final int? idEducations;
  final String? degree;
  final String? university;
  final String? faculty;
  final String? major;
  final int? fromYear;
  final int? endYear;
  final String? gpa;
  final int? idEmployees;

  Education({
    this.idEducations,
    this.degree,
    this.university,
    this.faculty,
    this.major,
    this.fromYear,
    this.endYear,
    this.gpa,
    this.idEmployees,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        idEducations: json["idEducations"],
        degree: json["degree"],
        university: json["university"],
        faculty: json["faculty"],
        major: json["major"],
        fromYear: json["fromYear"],
        endYear: json["endYear"],
        gpa: json["gpa"],
        idEmployees: json["idEmployees"],
      );

  Map<String, dynamic> toJson() => {
        "idEducations": idEducations,
        "degree": degree,
        "university": university,
        "faculty": faculty,
        "major": major,
        "fromYear": fromYear,
        "endYear": endYear,
        "gpa": gpa,
        "idEmployees": idEmployees,
      };
}

class Experience {
  final int? idExperiences;
  final String? positionName;
  final String? companyName;
  final String? description;
  final DateTime? startDate;
  final dynamic endDate;
  final int? idEmployees;

  Experience({
    this.idExperiences,
    this.positionName,
    this.companyName,
    this.description,
    this.startDate,
    this.endDate,
    this.idEmployees,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        idExperiences: json["idExperiences"],
        positionName: json["positionName"],
        companyName: json["companyName"],
        description: json["description"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate: json["endDate"],
        idEmployees: json["idEmployees"],
      );

  Map<String, dynamic> toJson() => {
        "idExperiences": idExperiences,
        "positionName": positionName,
        "companyName": companyName,
        "description": description,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate,
        "idEmployees": idEmployees,
      };
}

class Shift {
  final int? idShift;
  final String? shiftName;
  final int? idShiftGroup;
  final String? shiftGroupName;
  final int? shiftStartInMonday;
  final DateTime? shiftStartDate;
  final int? workDay;
  final int? offDay;
  final int? shiftNumber;
  final dynamic remark;
  final int? idWorkingType;
  final int? idCompany;
  final int? workingHours;
  final int? breakTime;
  final dynamic createBy;
  final dynamic createDate;
  final int? isTimeFrame;
  final dynamic fixOt;
  final dynamic isPayShift;
  final String? timeIn;
  final String? timeOut;

  Shift({
    this.idShift,
    this.shiftName,
    this.idShiftGroup,
    this.shiftGroupName,
    this.shiftStartInMonday,
    this.shiftStartDate,
    this.workDay,
    this.offDay,
    this.shiftNumber,
    this.remark,
    this.idWorkingType,
    this.idCompany,
    this.workingHours,
    this.breakTime,
    this.createBy,
    this.createDate,
    this.isTimeFrame,
    this.fixOt,
    this.isPayShift,
    this.timeIn,
    this.timeOut,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        idShift: json["idShift"],
        shiftName: json["shiftName"],
        idShiftGroup: json["idShiftGroup"],
        shiftGroupName: json["shiftGroupName"],
        shiftStartInMonday: json["shiftStartInMonday"],
        shiftStartDate: json["shiftStartDate"] == null
            ? null
            : DateTime.parse(json["shiftStartDate"]),
        workDay: json["workDay"],
        offDay: json["offDay"],
        shiftNumber: json["shiftNumber"],
        remark: json["remark"],
        idWorkingType: json["idWorkingType"],
        idCompany: json["idCompany"],
        workingHours: json["workingHours"],
        breakTime: json["breakTime"],
        createBy: json["createBy"],
        createDate: json["createDate"],
        isTimeFrame: json["isTimeFrame"],
        fixOt: json["fixOT"],
        isPayShift: json["isPayShift"],
        timeIn: json["timeIn"],
        timeOut: json["timeOut"],
      );

  Map<String, dynamic> toJson() => {
        "idShift": idShift,
        "shiftName": shiftName,
        "idShiftGroup": idShiftGroup,
        "shiftGroupName": shiftGroupName,
        "shiftStartInMonday": shiftStartInMonday,
        "shiftStartDate": shiftStartDate?.toIso8601String(),
        "workDay": workDay,
        "offDay": offDay,
        "shiftNumber": shiftNumber,
        "remark": remark,
        "idWorkingType": idWorkingType,
        "idCompany": idCompany,
        "workingHours": workingHours,
        "breakTime": breakTime,
        "createBy": createBy,
        "createDate": createDate,
        "isTimeFrame": isTimeFrame,
        "fixOT": fixOt,
        "isPayShift": isPayShift,
        "timeIn": timeIn,
        "timeOut": timeOut,
      };
}
