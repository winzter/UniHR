import 'package:equatable/equatable.dart';

class OverviewEntity extends Equatable {
  final int? employeeTotal;
  final List<EmployeeTotalAllYearEntity>? employeeTotalAllYear;
  final double? salaryTotal;
  final List<SalaryTotalAllYearEntity>? salaryTotalAllYear;
  final OtTotalEntity? otTotal;
  final List<OtTotalAllYearEntity>? otTotalAllYear;
  final EmployeeInfoEntity? employeeInfo;
  final WorkingTimeEmployeeInfoEntity? workingTimeEmployeeInfo;
  final EmployeeOtOver36TotalEntity? employeeOtOver36Total;

  OverviewEntity({
    this.employeeTotal,
    this.employeeTotalAllYear,
    this.salaryTotal,
    this.salaryTotalAllYear,
    this.otTotal,
    this.otTotalAllYear,
    this.employeeInfo,
    this.workingTimeEmployeeInfo,
    this.employeeOtOver36Total,
  });

  @override
  List<Object?> get props => [
        employeeTotal,
        employeeTotalAllYear,
        salaryTotal,
        salaryTotalAllYear,
        otTotal,
        otTotalAllYear,
        employeeInfo,
        workingTimeEmployeeInfo,
        employeeOtOver36Total,
      ];
}

class EmployeeInfoEntity {
  final int? maleTotal;
  final int? femaleTotal;
  final double? averageAge;
  final double? averageWorkExperience;
  final int? employeeInTotal;
  final List<dynamic>? employeeIn;
  final int? employeeOutTotal;
  final List<dynamic>? employeeOut;

  EmployeeInfoEntity({
    this.maleTotal,
    this.femaleTotal,
    this.averageAge,
    this.averageWorkExperience,
    this.employeeInTotal,
    this.employeeIn,
    this.employeeOutTotal,
    this.employeeOut,
  });
}

class EmployeeOtOver36TotalEntity {
  final List<WeekInMonthEntity>? weekInMonth;
  final List<dynamic>? top5EmployeeOver36;

  EmployeeOtOver36TotalEntity({
    this.weekInMonth,
    this.top5EmployeeOver36,
  });
}

class WeekInMonthEntity {
  final DateTime? weekStartDate;
  final DateTime? weekEndDate;
  final int? yearWeek;
  final DateTime? weekStartDateText;
  final DateTime? weekEndDateText;
  final int? over36HoursEmployeeTotal;
  final List<dynamic>? over36HoursEmployee;

  WeekInMonthEntity({
    this.weekStartDate,
    this.weekEndDate,
    this.yearWeek,
    this.weekStartDateText,
    this.weekEndDateText,
    this.over36HoursEmployeeTotal,
    this.over36HoursEmployee,
  });
}

class EmployeeTotalAllYearEntity {
  final int? month;
  final int? year;
  final int? employeeTotal;

  EmployeeTotalAllYearEntity({
    this.month,
    this.year,
    this.employeeTotal,
  });
}

class OtTotalEntity {
  final The15Entity? the2;
  final The15Entity? the3;
  final The15Entity? the15;

  OtTotalEntity({
    this.the2,
    this.the3,
    this.the15,
  });
}

class The15Entity {
  final double? payTotal;
  final double? hourTotal;

  The15Entity({
    this.payTotal,
    this.hourTotal,
  });
}

class OtTotalAllYearEntity {
  final double? payTotal;
  final int? month;
  final int? year;

  OtTotalAllYearEntity({
    this.payTotal,
    this.month,
    this.year,
  });
}

class SalaryTotalAllYearEntity {
  final int? month;
  final int? year;
  final double? salaryTotal;

  SalaryTotalAllYearEntity({
    this.month,
    this.year,
    this.salaryTotal,
  });
}

class WorkingTimeEmployeeInfoEntity {
  final List<LeaveEntity>? leave;
  final int? leaveTotal;
  final int? lateTotal;
  final int? absentTotal;
  final List<dynamic>? top5LateEmployees;
  final List<Top5AbsentEmployeeEntity>? top5AbsentEmployees;

  WorkingTimeEmployeeInfoEntity({
    this.leave,
    this.leaveTotal,
    this.lateTotal,
    this.absentTotal,
    this.top5LateEmployees,
    this.top5AbsentEmployees,
  });
}

class LeaveEntity {
  final int? idLeave;
  final int? idLeaveType;
  final String? name;
  final String? nameEn;
  final String? description;
  final DateTime? start;
  final String? startText;
  final DateTime? end;
  final String? endText;
  final int? isFullDay;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? imageProfile;

  LeaveEntity({
    this.idLeave,
    this.idLeaveType,
    this.name,
    this.nameEn,
    this.description,
    this.start,
    this.startText,
    this.end,
    this.endText,
    this.isFullDay,
    this.firstnameTh,
    this.lastnameTh,
    this.firstnameEn,
    this.lastnameEn,
    this.imageProfile,
  });
}

class Top5AbsentEmployeeEntity {
  final int? idEmployees;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? imageName;
  final int? lateTotal;
  final int? absentTotal;
  final String? imageProfile;

  Top5AbsentEmployeeEntity({
    this.idEmployees,
    this.firstnameTh,
    this.lastnameTh,
    this.firstnameEn,
    this.lastnameEn,
    this.imageName,
    this.lateTotal,
    this.absentTotal,
    this.imageProfile,
  });
}
