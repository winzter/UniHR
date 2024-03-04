import 'package:equatable/equatable.dart';

class OvertimeEntity extends Equatable{
  final int? employeeTotal;
  final OtTotal? otTotal;
  final List<OtTotalAllYear>? otTotalAllYear;
  final List<OtEmployeeTop5>? otEmployeeTop5;
  final EmployeeOtOver36Total? employeeOtOver36Total;

  OvertimeEntity({
    this.employeeTotal,
    this.otTotal,
    this.otTotalAllYear,
    this.otEmployeeTop5,
    this.employeeOtOver36Total,
  });

  @override

  List<Object?> get props => [
    employeeTotal,
    otTotal,
    otTotalAllYear,
    otEmployeeTop5,
    employeeOtOver36Total,
  ];
}

class EmployeeOtOver36Total extends Equatable{
  final List<WeekInMonth>? weekInMonth;
  final List<OtEmployeeTop5>? top5EmployeeOver36;

  EmployeeOtOver36Total({
    this.weekInMonth,
    this.top5EmployeeOver36,
  });

  @override
  List<Object?> get props => [
    weekInMonth,
    top5EmployeeOver36,
  ];
}

class OtEmployeeTop5 extends Equatable{
  final int? idEmployees;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? imageName;
  final int? over36Total;
  final String? imageProfile;
  final double? hourTotal;

  OtEmployeeTop5({
    this.idEmployees,
    this.firstnameTh,
    this.lastnameTh,
    this.imageName,
    this.over36Total,
    this.imageProfile,
    this.hourTotal,
  });


  @override
  List<Object?> get props => [
    idEmployees,
    firstnameTh,
    lastnameTh,
    imageName,
    over36Total,
    imageProfile,
    hourTotal,
  ];
}

class WeekInMonth extends Equatable{
  final DateTime? weekStartDate;
  final DateTime? weekEndDate;
  final int? yearWeek;
  final DateTime? weekStartDateText;
  final DateTime? weekEndDateText;
  final int? over36HoursEmployeeTotal;
  final List<Over36HoursEmployee>? over36HoursEmployee;

  WeekInMonth({
    this.weekStartDate,
    this.weekEndDate,
    this.yearWeek,
    this.weekStartDateText,
    this.weekEndDateText,
    this.over36HoursEmployeeTotal,
    this.over36HoursEmployee,
  });

  @override
  List<Object?> get props => [
    weekStartDate,
    weekEndDate,
    yearWeek,
    weekStartDateText,
    weekEndDateText,
    over36HoursEmployeeTotal,
    over36HoursEmployee,
  ];
}

class Over36HoursEmployee extends Equatable{
  final String? idEmployees;

  Over36HoursEmployee({
    this.idEmployees,
  });

  @override
  List<Object?> get props => [idEmployees];

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
    the15
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
