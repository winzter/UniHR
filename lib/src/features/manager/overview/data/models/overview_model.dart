import 'dart:convert';

import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';

OverviewModel overviewModelFromJson(String str) =>
    OverviewModel.fromJson(json.decode(str));

// String overviewModelToJson(OverviewModel data) => json.encode(data.toJson());

class OverviewModel extends OverviewEntity {
  OverviewModel({
    required int? employeeTotal,
    required List<EmployeeTotalAllYear>? employeeTotalAllYear,
    required double? salaryTotal,
    required List<SalaryTotalAllYear>? salaryTotalAllYear,
    required OtTotal? otTotal,
    required List<OtTotalAllYear>? otTotalAllYear,
    required EmployeeInfo? employeeInfo,
    required WorkingTimeEmployeeInfo? workingTimeEmployeeInfo,
    required EmployeeOtOver36Total? employeeOtOver36Total,
  }) : super(
          employeeTotal: employeeTotal,
          employeeTotalAllYear: employeeTotalAllYear,
          salaryTotal: salaryTotal,
          salaryTotalAllYear: salaryTotalAllYear,
          otTotal: otTotal,
          otTotalAllYear: otTotalAllYear,
          employeeInfo: employeeInfo,
          workingTimeEmployeeInfo: workingTimeEmployeeInfo,
          employeeOtOver36Total: employeeOtOver36Total,
        );

  factory OverviewModel.fromJson(Map<String, dynamic> json) => OverviewModel(
        employeeTotal: json["employeeTotal"],
        employeeTotalAllYear: json["employeeTotalAllYear"] == null
            ? []
            : List<EmployeeTotalAllYear>.from(json["employeeTotalAllYear"]!
                .map((x) => EmployeeTotalAllYear.fromJson(x))),
        salaryTotal: json["salaryTotal"]?.toDouble(),
        salaryTotalAllYear: json["salaryTotalAllYear"] == null
            ? []
            : List<SalaryTotalAllYear>.from(json["salaryTotalAllYear"]!
                .map((x) => SalaryTotalAllYear.fromJson(x))),
        otTotal:
            json["otTotal"] == null ? null : OtTotal.fromJson(json["otTotal"]),
        otTotalAllYear: json["otTotalAllYear"] == null
            ? []
            : List<OtTotalAllYear>.from(
                json["otTotalAllYear"]!.map((x) => OtTotalAllYear.fromJson(x))),
        employeeInfo: json["employeeInfo"] == null
            ? null
            : EmployeeInfo.fromJson(json["employeeInfo"]),
        workingTimeEmployeeInfo: json["workingTimeEmployeeInfo"] == null
            ? null
            : WorkingTimeEmployeeInfo.fromJson(json["workingTimeEmployeeInfo"]),
        employeeOtOver36Total: json["employeeOTOver36Total"] == null
            ? null
            : EmployeeOtOver36Total.fromJson(json["employeeOTOver36Total"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "employeeTotal": employeeTotal,
  //   "employeeTotalAllYear": employeeTotalAllYear == null ? [] : List<dynamic>.from(employeeTotalAllYear!.map((x) => x.toJson())),
  //   "salaryTotal": salaryTotal,
  //   "salaryTotalAllYear": salaryTotalAllYear == null ? [] : List<dynamic>.from(salaryTotalAllYear!.map((x) => x.toJson())),
  //   "otTotal": otTotal?.toJson(),
  //   "otTotalAllYear": otTotalAllYear == null ? [] : List<dynamic>.from(otTotalAllYear!.map((x) => x.toJson())),
  //   "employeeInfo": employeeInfo?.toJson(),
  //   "workingTimeEmployeeInfo": workingTimeEmployeeInfo?.toJson(),
  //   "employeeOTOver36Total": employeeOtOver36Total?.toJson(),
  // };
}

class EmployeeInfo extends EmployeeInfoEntity {
  EmployeeInfo({
    required int? maleTotal,
    required int? femaleTotal,
    required double? averageAge,
    required double? averageWorkExperience,
    required int? employeeInTotal,
    required List<dynamic>? employeeIn,
    required int? employeeOutTotal,
    required List<dynamic>? employeeOut,
  }) : super(
          maleTotal: maleTotal,
          femaleTotal: femaleTotal,
          averageAge: averageAge,
          averageWorkExperience: averageWorkExperience,
          employeeInTotal: employeeInTotal,
          employeeIn: employeeIn,
          employeeOutTotal: employeeOutTotal,
          employeeOut: employeeOut,
        );

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) => EmployeeInfo(
        maleTotal: json["maleTotal"],
        femaleTotal: json["femaleTotal"],
        averageAge: json["averageAge"]?.toDouble(),
        averageWorkExperience: json["averageWorkExperience"]?.toDouble(),
        employeeInTotal: json["employeeInTotal"],
        employeeIn: json["employeeIn"] == null
            ? []
            : List<dynamic>.from(json["employeeIn"]!.map((x) => x)),
        employeeOutTotal: json["employeeOutTotal"],
        employeeOut: json["employeeOut"] == null
            ? []
            : List<dynamic>.from(json["employeeOut"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "maleTotal": maleTotal,
        "femaleTotal": femaleTotal,
        "averageAge": averageAge,
        "averageWorkExperience": averageWorkExperience,
        "employeeInTotal": employeeInTotal,
        "employeeIn": employeeIn == null
            ? []
            : List<dynamic>.from(employeeIn!.map((x) => x)),
        "employeeOutTotal": employeeOutTotal,
        "employeeOut": employeeOut == null
            ? []
            : List<dynamic>.from(employeeOut!.map((x) => x)),
      };
}

class EmployeeOtOver36Total extends EmployeeOtOver36TotalEntity {
  EmployeeOtOver36Total({
    required List<WeekInMonth>? weekInMonth,
    required List<dynamic>? top5EmployeeOver36,
  }) : super(
          weekInMonth: weekInMonth,
          top5EmployeeOver36: top5EmployeeOver36,
        );

  factory EmployeeOtOver36Total.fromJson(Map<String, dynamic> json) =>
      EmployeeOtOver36Total(
        weekInMonth: json["weekInMonth"] == null
            ? []
            : List<WeekInMonth>.from(
                json["weekInMonth"]!.map((x) => WeekInMonth.fromJson(x))),
        top5EmployeeOver36: json["top5EmployeeOver36"] == null
            ? []
            : List<dynamic>.from(json["top5EmployeeOver36"]!.map((x) => x)),
      );

  // Map<String, dynamic> toJson() => {
  //   "weekInMonth": weekInMonth == null ? [] : List<dynamic>.from(weekInMonth!.map((x) => x.toJson())),
  //   "top5EmployeeOver36": top5EmployeeOver36 == null ? [] : List<dynamic>.from(top5EmployeeOver36!.map((x) => x)),
  // };
}

class WeekInMonth extends WeekInMonthEntity {
  WeekInMonth({
    required DateTime? weekStartDate,
    required DateTime? weekEndDate,
    required int? yearWeek,
    required DateTime? weekStartDateText,
    required DateTime? weekEndDateText,
    required int? over36HoursEmployeeTotal,
    required List<dynamic>? over36HoursEmployee,
  }) : super(
          weekStartDate: weekStartDate,
          weekEndDate: weekEndDate,
          yearWeek: yearWeek,
          weekStartDateText: weekStartDateText,
          weekEndDateText: weekEndDateText,
          over36HoursEmployeeTotal: over36HoursEmployeeTotal,
          over36HoursEmployee: over36HoursEmployee,
        );

  factory WeekInMonth.fromJson(Map<String, dynamic> json) => WeekInMonth(
        weekStartDate: json["weekStartDate"] == null
            ? null
            : DateTime.parse(json["weekStartDate"]),
        weekEndDate: json["weekEndDate"] == null
            ? null
            : DateTime.parse(json["weekEndDate"]),
        yearWeek: json["yearWeek"],
        weekStartDateText: json["weekStartDateText"] == null
            ? null
            : DateTime.parse(json["weekStartDateText"]),
        weekEndDateText: json["weekEndDateText"] == null
            ? null
            : DateTime.parse(json["weekEndDateText"]),
        over36HoursEmployeeTotal: json["over36HoursEmployeeTotal"],
        over36HoursEmployee: json["over36HoursEmployee"] == null
            ? []
            : List<dynamic>.from(json["over36HoursEmployee"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "weekStartDate": weekStartDate?.toIso8601String(),
        "weekEndDate": weekEndDate?.toIso8601String(),
        "yearWeek": yearWeek,
        "weekStartDateText":
            "${weekStartDateText!.year.toString().padLeft(4, '0')}-${weekStartDateText!.month.toString().padLeft(2, '0')}-${weekStartDateText!.day.toString().padLeft(2, '0')}",
        "weekEndDateText":
            "${weekEndDateText!.year.toString().padLeft(4, '0')}-${weekEndDateText!.month.toString().padLeft(2, '0')}-${weekEndDateText!.day.toString().padLeft(2, '0')}",
        "over36HoursEmployeeTotal": over36HoursEmployeeTotal,
        "over36HoursEmployee": over36HoursEmployee == null
            ? []
            : List<dynamic>.from(over36HoursEmployee!.map((x) => x)),
      };
}

class EmployeeTotalAllYear extends EmployeeTotalAllYearEntity {
  EmployeeTotalAllYear({
    required int? month,
    required int? year,
    required int? employeeTotal,
  }) : super(
          month: month,
          year: year,
          employeeTotal: employeeTotal,
        );

  factory EmployeeTotalAllYear.fromJson(Map<String, dynamic> json) =>
      EmployeeTotalAllYear(
        month: json["month"],
        year: json["year"],
        employeeTotal: json["employeeTotal"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "employeeTotal": employeeTotal,
      };
}

class OtTotal extends OtTotalEntity {
  OtTotal({
    required The15? the2,
    required The15? the3,
    required The15? the15,
  }) : super(
          the2: the2,
          the3: the3,
          the15: the15,
        );

  factory OtTotal.fromJson(Map<String, dynamic> json) => OtTotal(
        the2: json["2"] == null ? null : The15.fromJson(json["2"]),
        the3: json["3"] == null ? null : The15.fromJson(json["3"]),
        the15: json["1.5"] == null ? null : The15.fromJson(json["1.5"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "2": the2?.toJson(),
  //   "3": the3?.toJson(),
  //   "1.5": the15?.toJson(),
  // };
}

class The15 extends The15Entity {
  The15({
    required double? payTotal,
    required double? hourTotal,
  }) : super(payTotal: payTotal, hourTotal: hourTotal);

  factory The15.fromJson(Map<String, dynamic> json) => The15(
        payTotal: json["payTotal"]?.toDouble(),
        hourTotal: json["hourTotal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "payTotal": payTotal,
        "hourTotal": hourTotal,
      };
}

class OtTotalAllYear extends OtTotalAllYearEntity {
  OtTotalAllYear({
    required double? payTotal,
    required int? month,
    required int? year,
  }) : super(
          payTotal: payTotal,
          month: month,
          year: year,
        );

  factory OtTotalAllYear.fromJson(Map<String, dynamic> json) => OtTotalAllYear(
        payTotal: json["payTotal"]?.toDouble(),
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "payTotal": payTotal,
        "month": month,
        "year": year,
      };
}

class SalaryTotalAllYear extends SalaryTotalAllYearEntity {
  SalaryTotalAllYear({
    required int? month,
    required int? year,
    required double? salaryTotal,
  }) : super(
          month: month,
          year: year,
          salaryTotal: salaryTotal,
        );

  factory SalaryTotalAllYear.fromJson(Map<String, dynamic> json) =>
      SalaryTotalAllYear(
        month: json["month"],
        year: json["year"],
        salaryTotal: json["salaryTotal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "salaryTotal": salaryTotal,
      };
}

class WorkingTimeEmployeeInfo extends WorkingTimeEmployeeInfoEntity {
  WorkingTimeEmployeeInfo({
    required List<Leave>? leave,
    required int? leaveTotal,
    required int? lateTotal,
    required int? absentTotal,
    required List<dynamic>? top5LateEmployees,
    required List<Top5AbsentEmployee>? top5AbsentEmployees,
  }) : super(
          leave: leave,
          leaveTotal: leaveTotal,
          lateTotal: lateTotal,
          absentTotal: absentTotal,
          top5LateEmployees: top5LateEmployees,
          top5AbsentEmployees: top5AbsentEmployees,
        );

  factory WorkingTimeEmployeeInfo.fromJson(Map<String, dynamic> json) =>
      WorkingTimeEmployeeInfo(
        leave: json["leave"] == null
            ? []
            : List<Leave>.from(json["leave"]!.map((x) => Leave.fromJson(x))),
        leaveTotal: json["leaveTotal"],
        lateTotal: json["lateTotal"],
        absentTotal: json["absentTotal"],
        top5LateEmployees: json["top5LateEmployees"] == null
            ? []
            : List<dynamic>.from(json["top5LateEmployees"]!.map((x) => x)),
        top5AbsentEmployees: json["top5AbsentEmployees"] == null
            ? []
            : List<Top5AbsentEmployee>.from(json["top5AbsentEmployees"]!
                .map((x) => Top5AbsentEmployee.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //   "leave": leave == null ? [] : List<dynamic>.from(leave!.map((x) => x.toJson())),
  //   "leaveTotal": leaveTotal,
  //   "lateTotal": lateTotal,
  //   "absentTotal": absentTotal,
  //   "top5LateEmployees": top5LateEmployees == null ? [] : List<dynamic>.from(top5LateEmployees!.map((x) => x)),
  //   "top5AbsentEmployees": top5AbsentEmployees == null ? [] : List<dynamic>.from(top5AbsentEmployees!.map((x) => x.toJson())),
  // };
}

class Leave extends LeaveEntity {
  Leave({
    required int? idLeave,
    required int? idLeaveType,
    required String? name,
    required String? name_EN,
    required String? description,
    required DateTime? start,
    required String? startText,
    required DateTime? end,
    required String? endText,
    required int? isFullDay,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? firstname_EN,
    required String? lastname_EN,
    required String? imageProfile,
  }) : super(
          idLeave: idLeave,
          idLeaveType: idLeaveType,
          name: name,
          nameEn: name_EN,
          description: description,
          start: start,
          startText: startText,
          end: end,
          endText: endText,
          isFullDay: isFullDay,
          firstnameTh: firstnameTh,
          lastnameTh: lastnameTh,
          firstnameEn: firstname_EN,
          lastnameEn: lastname_EN,
          imageProfile: imageProfile,
        );

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        idLeave: json["idLeave"],
        idLeaveType: json["idLeaveType"],
        name: json["name"],
        name_EN: json["name_EN"],
        description: json["description"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        startText: json["startText"],
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        endText: json["endText"],
        isFullDay: json["isFullDay"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        firstname_EN: json["firstname_EN"],
        lastname_EN: json["lastname_EN"],
        imageProfile: json["imageProfile"],
      );

  Map<String, dynamic> toJson() => {
        "idLeave": idLeave,
        "idLeaveType": idLeaveType,
        "name": name,
        "name_EN": nameEn,
        "description": description,
        "start": start?.toIso8601String(),
        "startText": startText,
        "end": end?.toIso8601String(),
        "endText": endText,
        "isFullDay": isFullDay,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "firstname_EN": firstnameEn,
        "lastname_EN": lastnameEn,
        "imageProfile": imageProfile,
      };
}

class Top5AbsentEmployee extends Top5AbsentEmployeeEntity {
  Top5AbsentEmployee({
    required int? idEmployees,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? firstname_EN,
    required String? lastname_EN,
    required String? imageName,
    required int? lateTotal,
    required int? absentTotal,
    required String? imageProfile,
  }) : super(
          idEmployees: idEmployees,
          firstnameTh: firstnameTh,
          lastnameTh: lastnameTh,
          firstnameEn: firstname_EN,
          lastnameEn: lastname_EN,
          imageName: imageName,
          lateTotal: lateTotal,
          absentTotal: absentTotal,
          imageProfile: imageProfile,
        );

  factory Top5AbsentEmployee.fromJson(Map<String, dynamic> json) =>
      Top5AbsentEmployee(
        idEmployees: json["idEmployees"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        firstname_EN: json["firstname_EN"],
        lastname_EN: json["lastname_EN"],
        imageName: json["imageName"],
        lateTotal: json["lateTotal"],
        absentTotal: json["absentTotal"],
        imageProfile: json["imageProfile"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "firstname_EN": firstnameEn,
        "lastname_EN": lastnameEn,
        "imageName": imageName,
        "lateTotal": lateTotal,
        "absentTotal": absentTotal,
        "imageProfile": imageProfile,
      };
}
