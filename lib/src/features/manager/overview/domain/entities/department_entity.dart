import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable{
  final dynamic idDivision;
  final dynamic divisionName;
  final int? idDepartment;
  final String? departmentName;
  final List<SectionEntity>? sections;

  DepartmentEntity({
    this.idDivision,
    this.divisionName,
    this.idDepartment,
    this.departmentName,
    this.sections,
  });

  @override
  List<Object?> get props => [
    idDivision,
    divisionName,
    idDepartment,
    departmentName,
    sections,
  ];
}

class SectionEntity extends Equatable{
  final int? idSection;
  final String? sectionName;

  SectionEntity({
    this.idSection,
    this.sectionName,
  });

  @override
  List<Object?> get props => [
    idSection,
    sectionName,
  ];

}
