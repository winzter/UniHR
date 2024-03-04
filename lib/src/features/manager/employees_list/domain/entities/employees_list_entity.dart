import 'package:equatable/equatable.dart';

class EmployeesListEntity extends Equatable {
  final int? idEmployees;
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? nicknameTh;
  final String? titleEn;
  final String? firstnameEn;
  final String? lastnameEn;
  final dynamic nicknameEn;
  final String? telephoneMobile;
  final String? email;
  final int? idCompany;
  final dynamic idBranch;
  final int? idPosition;
  final int? isActive;
  final DateTime? createDate;
  final dynamic createBy;
  final DateTime? updateDate;
  final int? updateBy;
  final String? positionCode;
  final String? positionName;
  final String? positionName_EN;
  final String? sectionCode;
  final String? sectionName;
  final String? sectionName_EN;
  final String? departmentCode;
  final String? departmentName;
  final int? idDepartment;
  final dynamic idBusinessUnit;
  final dynamic businessUnitName;
  final dynamic businessUnitCode;
  final dynamic divisionCode;
  final dynamic divisionName;
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
  final int? idManagerLv2;
  final String? workingType;
  final int? idPaymentType;
  final int? isTerminate;

  EmployeesListEntity({
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
    this.positionName_EN,
    this.sectionCode,
    this.sectionName,
    this.sectionName_EN,
    this.departmentCode,
    this.departmentName,
    this.idDepartment,
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
  });

  factory EmployeesListEntity.fromJson(Map<String, dynamic> json) =>
      EmployeesListEntity(
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
        telephoneMobile: json["telephoneMobile"],
        email: json["email"],
        idCompany: json["idCompany"],
        idBranch: json["idBranch"],
        idPosition: json["idPosition"],
        isActive: json["isActive"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        createBy: json["createBy"],
        updateDate: json["updateDate"] == null
            ? null
            : DateTime.parse(json["updateDate"]),
        updateBy: json["updateBy"],
        positionCode: json["positionCode"],
        positionName: json["positionName"],
        positionName_EN: json["positionName_EN"],
        sectionCode: json["sectionCode"],
        sectionName: json["sectionName"],
        sectionName_EN: json["sectionName_EN"],
        departmentCode: json["departmentCode"],
        departmentName: json["departmentName"],
        idDepartment: json["idDepartment"],
        idBusinessUnit: json["idBusinessUnit"],
        businessUnitName: json["businessUnitName"],
        businessUnitCode: json["businessUnitCode"],
        divisionCode: json["divisionCode"],
        divisionName: json["divisionName"],
        companyName: json["companyName"],
        imageName: json["imageName"],
        managerLv1FirstnameTh: json["managerLV1_firstname_TH"],
        managerLv1LastnameTh: json["managerLV1_lastname_TH"],
        managerLv1FirstnameEn: json["managerLV1_firstname_EN"],
        managerLv1LastnameEn: json["managerLV1_lastname_EN"],
        managerLv1Email: json["managerLV1_email"],
        managerLv2FirstnameTh: json["managerLV2_firstname_TH"],
        managerLv2LastnameTh: json["managerLV2_lastname_TH"],
        managerLv2FirstnameEn: json["managerLV2_firstname_EN"],
        managerLv2LastnameEn: json["managerLV2_lastname_EN"],
        managerLv2Email: json["managerLV2_email"],
        idManagerLv1: json["idManagerLV1"],
        idManagerLv2: json["idManagerLV2"],
        workingType: json["workingType"],
        idPaymentType: json["idPaymentType"],
        isTerminate: json["isTerminate"],
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
        "telephoneMobile": telephoneMobile,
        "email": email,
        "idCompany": idCompany,
        "idBranch": idBranch,
        "idPosition": idPosition,
        "isActive": isActive,
        "createDate": createDate?.toIso8601String(),
        "createBy": createBy,
        "updateDate": updateDate?.toIso8601String(),
        "updateBy": updateBy,
        "positionCode": positionCode,
        "positionName": positionName,
        "positionName_EN": positionName_EN,
        "sectionCode": sectionCode,
        "sectionName": sectionName,
        "sectionName_En": sectionName_EN,
        "departmentCode": departmentCode,
        "departmentName": departmentName,
        "idDepartment": idDepartment,
        "idBusinessUnit": idBusinessUnit,
        "businessUnitName": businessUnitName,
        "businessUnitCode": businessUnitCode,
        "divisionCode": divisionCode,
        "divisionName": divisionName,
        "companyName": companyName,
        "imageName": imageName,
        "managerLV1_firstname_TH": managerLv1FirstnameTh,
        "managerLV1_lastname_TH": managerLv1LastnameTh,
        "managerLV1_firstname_EN": managerLv1FirstnameEn,
        "managerLV1_lastname_EN": managerLv1LastnameEn,
        "managerLV1_email": managerLv1Email,
        "managerLV2_firstname_TH": managerLv2FirstnameTh,
        "managerLV2_lastname_TH": managerLv2LastnameTh,
        "managerLV2_firstname_EN": managerLv2FirstnameEn,
        "managerLV2_lastname_EN": managerLv2LastnameEn,
        "managerLV2_email": managerLv2Email,
        "idManagerLV1": idManagerLv1,
        "idManagerLV2": idManagerLv2,
        "workingType": workingType,
        "idPaymentType": idPaymentType,
        "isTerminate": isTerminate,
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
        positionName_EN,
        sectionCode,
        sectionName,
        sectionName_EN,
        departmentCode,
        departmentName,
        idDepartment,
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
      ];
}
