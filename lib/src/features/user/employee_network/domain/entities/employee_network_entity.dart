import 'package:equatable/equatable.dart';

class EmployeeNetworkEntity extends Equatable{
  final int? idEmployees;
  final DateTime? hiringDate;
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? nicknameTh;
  final String? titleEn;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? nicknameEn;
  final String? telephoneMobile;
  final String? email;
  final int? idCompany;
  final dynamic idBranch;
  final int? idPosition;
  final int? isActive;
  final dynamic createDate;
  final dynamic createBy;
  final DateTime? updateDate;
  final int? updateBy;
  final String? positionCode;
  final String? positionName;
  final String? sectionCode;
  final String? sectionName;
  final String? departmentCode;
  final String? departmentName;
  final int? idDivision;
  final int? idDepartment;
  final int? idSection;
  final int? idBusinessUnit;
  final String? businessUnitName;
  final String? businessUnitCode;
  final String? divisionCode;
  final String? divisionName;
  final String? companyName;
  final String? imageName;
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
  final int? idManagerLv1;
  final dynamic idManagerLv2;
  final String? workingType;
  final int? idPaymentType;
  final int? isTerminate;
  final String? imageProfile;
  final String? name;

  EmployeeNetworkEntity({
    this.idEmployees,
    this.hiringDate,
    this.employeeId,
    this.titleTh,
    this.firstnameTh,
    this.lastnameTh,
    this.nicknameTh,
    this.titleEn,
    this.firstnameEn,
    this.lastnameEn,
    this.nicknameEn,
    this.telephoneMobile,
    this.email,
    this.idCompany,
    this.idBranch,
    this.idPosition,
    this.isActive,
    this.createDate,
    this.createBy,
    this.updateDate,
    this.updateBy,
    this.positionCode,
    this.positionName,
    this.sectionCode,
    this.sectionName,
    this.departmentCode,
    this.departmentName,
    this.idDivision,
    this.idDepartment,
    this.idSection,
    this.idBusinessUnit,
    this.businessUnitName,
    this.businessUnitCode,
    this.divisionCode,
    this.divisionName,
    this.companyName,
    this.imageName,
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
    this.idManagerLv1,
    this.idManagerLv2,
    this.workingType,
    this.idPaymentType,
    this.isTerminate,
    this.imageProfile,
    this.name,
  });

  @override
  List<Object?> get props => [
    idEmployees,
    hiringDate,
    employeeId,
    titleTh,
    firstnameTh,
    lastnameTh,
    nicknameTh,
    titleEn,
    firstnameEn,
    lastnameEn,
    nicknameEn,
    telephoneMobile,
    email,
    idCompany,
    idBranch,
    idPosition,
    isActive,
    createDate,
    createBy,
    updateDate,
    updateBy,
    positionCode,
    positionName,
    sectionCode,
    sectionName,
    departmentCode,
    departmentName,
    idDivision,
    idDepartment,
    idSection,
    idBusinessUnit,
    businessUnitName,
    businessUnitCode,
    divisionCode,
    divisionName,
    companyName,
    imageName,
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
    idManagerLv1,
    idManagerLv2,
    workingType,
    idPaymentType,
    isTerminate,
    imageProfile,
    name,
  ];

}
