import 'dart:convert';

import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';

List<DepartmentModel> departmentModelFromJson(String str) => List<DepartmentModel>.from(json.decode(str).map((x) => DepartmentModel.fromJson(x)));

// String departmentModelToJson(List<OverviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel extends DepartmentEntity{


  DepartmentModel({
    required dynamic idDivision,
    required dynamic divisionName,
    required int? idDepartment,
    required String? departmentName,
    required List<SectionModel>? sections,
  }):super(
    idDivision : idDivision,
    divisionName : divisionName,
    idDepartment : idDepartment,
    departmentName : departmentName,
    sections : sections,
  );

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
    idDivision: json["idDivision"],
    divisionName: json["divisionName"],
    idDepartment: json["idDepartment"],
    departmentName: json["departmentName"],
    sections: json["sections"] == null ? [] : List<SectionModel>.from(json["sections"]!.map((x) => SectionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "idDivision": idDivision,
    "divisionName": divisionName,
    "idDepartment": idDepartment,
    "departmentName": departmentName,
    // "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class SectionModel extends SectionEntity{


  SectionModel({
    required int? idSection,
    required String? sectionName,
  }):super(
    idSection: idSection,
    sectionName: sectionName,
  );

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    idSection: json["idSection"],
    sectionName: json["sectionName"],
  );

  Map<String, dynamic> toJson() => {
    "idSection": idSection,
    "sectionName": sectionName,
  };
}
