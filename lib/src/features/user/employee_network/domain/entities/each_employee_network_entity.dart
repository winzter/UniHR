import 'package:equatable/equatable.dart';

class EachEmployeeEntity extends Equatable{
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
  final String? sectionName;
  final String? departmentName;
  final String? divisionName;
  final String? address;
  final String? houseNo;
  final String? village;
  final String? villageNo;
  final String? alley;
  final String? road;
  final String? subDistrict;
  final String? district;
  final String? provience;
  final String? areaCode;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? nicknameEn;
  final dynamic createDate;
  final String? overview;
  final int? idManagerLv1;
  final dynamic idManagerLv2;
  final int? idPaymentType;
  final int? idCompany;
  final String? imageName;
  final String? maritalStatus;
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
  final String? managerLv1ImageName;
  final dynamic managerLv2ImageName;
  final dynamic managerLv1PositionName;
  final dynamic managerLv2PositionName;
  final String? emergencyContact;
  final String? emergencyRelationship;
  final String? emergencyPhone;
  final DateTime? birthday;
  final String? workingType;
  final String? companyName;
  final String? imageProfile;
  final String? managerLv1ImageProfile;
  final dynamic managerLv2ImageProfile;
  final List<Education>? educations;
  final List<Interest>? interests;
  final List<Skill>? skills;
  final List<dynamic>? list;

  EachEmployeeEntity({
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
    this.sectionName,
    this.departmentName,
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
    this.firstnameEn,
    this.lastnameEn,
    this.nicknameEn,
    this.createDate,
    this.overview,
    this.idManagerLv1,
    this.idManagerLv2,
    this.idPaymentType,
    this.idCompany,
    this.imageName,
    this.maritalStatus,
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
    this.managerLv1ImageName,
    this.managerLv2ImageName,
    this.managerLv1PositionName,
    this.managerLv2PositionName,
    this.emergencyContact,
    this.emergencyRelationship,
    this.emergencyPhone,
    this.birthday,
    this.workingType,
    this.companyName,
    this.imageProfile,
    this.managerLv1ImageProfile,
    this.managerLv2ImageProfile,
    this.educations,
    this.interests,
    this.skills,
    this.list,
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
    sectionName,
    departmentName,
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
    firstnameEn,
    lastnameEn,
    nicknameEn,
    createDate,
    overview,
    idManagerLv1,
    idManagerLv2,
    idPaymentType,
    idCompany,
    imageName,
    maritalStatus,
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
    managerLv1ImageName,
    managerLv2ImageName,
    managerLv1PositionName,
    managerLv2PositionName,
    emergencyContact,
    emergencyRelationship,
    emergencyPhone,
    birthday,
    workingType,
    companyName,
    imageProfile,
    managerLv1ImageProfile,
    managerLv2ImageProfile,
    educations,
    interests,
    skills,
    list,
  ];
}

class Education extends Equatable{
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

  @override
  List<Object?> get props => [
    idEducations,
    degree,
    university,
    faculty,
    major,
    fromYear,
    endYear,
    gpa,
    idEmployees,
  ];

}

class Interest extends Equatable{
  final int? idInterest;
  final int? idEmployees;
  final String? interest;

  Interest({
    this.idInterest,
    this.idEmployees,
    this.interest,
  });

  @override
  List<Object?> get props => [
    idInterest,
    idEmployees,
    interest,
  ];

}

class Skill extends Equatable{
  final int? idSkill;
  final int? idEmployees;
  final String? skill;

  Skill({
    this.idSkill,
    this.idEmployees,
    this.skill,
  });

  @override
  List<Object?> get props => [
    idSkill,
    idEmployees,
    skill,
  ];

}
