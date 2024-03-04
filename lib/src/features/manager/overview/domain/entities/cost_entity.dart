import 'package:equatable/equatable.dart';

class CostEntity extends Equatable{
  final int? employeeTotal;
  final double? salaryTotal;
  final List<SalaryTotalAllYear>? salaryTotalAllYear;
  final OtTotal? otTotal;
  final List<OtTotalAllYear>? otTotalAllYear;

  CostEntity({
    this.employeeTotal,
    this.salaryTotal,
    this.salaryTotalAllYear,
    this.otTotal,
    this.otTotalAllYear,
  });


  @override
  List<Object?> get props => [
    employeeTotal,
    salaryTotal,
    salaryTotalAllYear,
    otTotal,
    otTotalAllYear,
  ];
}

class OtTotal extends Equatable{
  final The15? the2;
  final The15? the3;
  final The15? the15;

  OtTotal({
    this.the2,
    this.the3,
    this.the15,
  });

  @override
  List<Object?> get props => [
    the2,
    the3,
    the15,
  ];
}

class The15 extends Equatable{
  final double? payTotal;
  final double? hourTotal;

  The15({
    this.payTotal,
    this.hourTotal,
  });

  @override
  List<Object?> get props => [
    payTotal,
    hourTotal,
  ];
}

class OtTotalAllYear extends Equatable{
  final double? payTotal;
  final int? month;
  final int? year;

  OtTotalAllYear({
    this.payTotal,
    this.month,
    this.year,
  });

  @override
  List<Object?> get props => [
    payTotal,
    month,
    year,
  ];
}

class SalaryTotalAllYear extends Equatable{
  final int? month;
  final int? year;
  final double? salaryTotal;

  SalaryTotalAllYear({
    this.month,
    this.year,
    this.salaryTotal,
  });


  @override
  List<Object?> get props => [
    month,
    year,
    salaryTotal,
  ];
}
