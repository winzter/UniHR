import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {

  final int? idEmployees;
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? nicknameTh;
  final String? titleEn;
  final DateTime? hiringDate;
  final String? personalId;
  final String? email;
  final String? telephoneMobile;
  final String? positionName;
  final String? positionName_EN;
  final String? sectionName;
  final String? departmentName;
  final String? departmentName_EN;
  final String? divisionName;
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
  final String? companyName;
  final String? companyName_EN;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? nicknameEn;
  final int? idRole;
  final int? isActive;
  // final dynamic createDate;
  // final dynamic createBy;
  final int? idPaymentType;
  final int? idCompany;
  final String? imageName;
  // final dynamic servY;
  // final dynamic servM;
  // final dynamic userPf;
  final String? taxId;
  final String? maritalStatus;
  final int? idManagerLv1;
  final String? managerLv1FirstnameTh;
  final String? managerLv1LastnameTh;
  final String? managerLv1FirstnameEn;
  final String? managerLv1LastnameEn;
  final String? managerLv1Email;
  final int? idManagerLv2;
  final String? managerLv2FirstnameTh;
  final String? managerLv2LastnameTh;
  final String? managerLv2FirstnameEn;
  final String? managerLv2LastnameEn;
  final String? managerLv2Email;
  final String? managerLv1PositionName;
  final String? managerLv2PositionName;
  final String? emergencyContact;
  final String? emergencyRelationship;
  final String? emergencyPhone;
  final DateTime? birthday;
  final String? workingType;
  final DateTime? updateDate;
  final int? updateBy;
  final String? roleName;
  final dynamic idManagerGroupLv1;
  final dynamic idManagerGroupLv2;
  final dynamic managerGroupLv1ManagerGroupName;
  final dynamic managerGroupLv2ManagerGroupName;
  final List<String>? roles;
  final List<Education>? educations;
  final List<dynamic>? idManagerGroupList;
  final String? imageProfile;

  const ProfileEntity({
    this.idEmployees,
    this.employeeId,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.nicknameTh,
    this.titleEn,
    this.hiringDate,
    this.personalId,
    this.email,
    this.telephoneMobile,
    this.positionName,
    this.positionName_EN,
    this.sectionName,
    this.departmentName,
    this.departmentName_EN,
    this.divisionName,
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
    this.companyName,
    this.companyName_EN,
    this.firstnameEn,
    this.lastnameEn,
    this.nicknameEn,
    this.idRole,
    this.isActive,
    // this.createDate,
    // this.createBy,
    this.idPaymentType,
    this.idCompany,
    this.imageName,
    // this.servY,
    // this.servM,
    // this.userPf,
    this.taxId,
    this.maritalStatus,
    this.idManagerLv1,
    this.managerLv1FirstnameTh,
    this.managerLv1LastnameTh,
    this.managerLv1FirstnameEn,
    this.managerLv1LastnameEn,
    this.managerLv1Email,
    this.idManagerLv2,
    this.managerLv2FirstnameTh,
    this.managerLv2LastnameTh,
    this.managerLv2FirstnameEn,
    this.managerLv2LastnameEn,
    this.managerLv2Email,
    this.managerLv1PositionName,
    this.managerLv2PositionName,
    this.emergencyContact,
    this.emergencyRelationship,
    this.emergencyPhone,
    this.birthday,
    this.workingType,
    this.updateDate,
    this.updateBy,
    this.roleName,
    this.idManagerGroupLv1,
    this.idManagerGroupLv2,
    this.managerGroupLv1ManagerGroupName,
    this.managerGroupLv2ManagerGroupName,
    this.roles,
    this.educations,
    this.idManagerGroupList,
    this.imageProfile,
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
        hiringDate,
        personalId,
        email,
        telephoneMobile,
        positionName,
        positionName_EN,
        sectionName,
        departmentName,
        departmentName_EN,
        divisionName,
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
        companyName,
        companyName_EN,
        firstnameEn,
        lastnameEn,
        nicknameEn,
        idRole,
        isActive,
        // createDate,
        // createBy,
        idPaymentType,
        idCompany,
        imageName,
        // servY,
        // servM,
        // userPf,
        taxId,
        maritalStatus,
        idManagerLv1,
        managerLv1FirstnameTh,
        managerLv1LastnameTh,
        managerLv1FirstnameEn,
        managerLv1LastnameEn,
        managerLv1Email,
        idManagerLv2,
        managerLv2FirstnameTh,
        managerLv2LastnameTh,
        managerLv2FirstnameEn,
        managerLv2LastnameEn,
        managerLv2Email,
        managerLv1PositionName,
        managerLv2PositionName,
        emergencyContact,
        emergencyRelationship,
        emergencyPhone,
        birthday,
        workingType,
        updateDate,
        updateBy,
        roleName,
        idManagerGroupLv1,
        idManagerGroupLv2,
        managerGroupLv1ManagerGroupName,
        managerGroupLv2ManagerGroupName,
        roles,
        educations,
        idManagerGroupList,
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
}
