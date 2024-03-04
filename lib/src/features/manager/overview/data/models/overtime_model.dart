import 'dart:convert';
import '../../domain/entities/overtime_entity.dart';


OvertimeModel overtimeModelFromJson(String str) =>
    OvertimeModel.fromJson(json.decode(str));

// String overtimeModelToJson(OvertimeModel data) => json.encode(data.toJson());

class OvertimeModel extends OvertimeEntity {
  OvertimeModel({
    required int? employeeTotal,
    required OtTotal? otTotal,
    required List<OtTotalAllYearModel>? otTotalAllYear,
    required List<OtEmployeeTop5Model>? otEmployeeTop5,
    required EmployeeOtOver36TotalModel? employeeOtOver36Total,
  }) : super(
            employeeTotal: employeeTotal,
            otTotal: otTotal,
            otTotalAllYear: otTotalAllYear,
            otEmployeeTop5: otEmployeeTop5,
            employeeOtOver36Total: employeeOtOver36Total);

  factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        employeeTotal: json["employeeTotal"],
        otTotal: json["otTotal"] == null
            ? null
            : OtTotalModel.fromJson(json["otTotal"]),
        otTotalAllYear: json["otTotalAllYear"] == null
            ? []
            : List<OtTotalAllYearModel>.from(json["otTotalAllYear"]!
                .map((x) => OtTotalAllYearModel.fromJson(x))),
        otEmployeeTop5: json["otEmployeeTop5"] == null
            ? []
            : List<OtEmployeeTop5Model>.from(json["otEmployeeTop5"]!
                .map((x) => OtEmployeeTop5Model.fromJson(x))),
        employeeOtOver36Total: json["employeeOTOver36Total"] == null
            ? null
            : EmployeeOtOver36TotalModel.fromJson(
                json["employeeOTOver36Total"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "employeeTotal": employeeTotal,
  //       "otTotal": otTotal?.toJson(),
  //       "otTotalAllYear": otTotalAllYear == null
  //           ? []
  //           : List<dynamic>.from(otTotalAllYear!.map((x) => x.toJson())),
  //       "otEmployeeTop5": otEmployeeTop5 == null
  //           ? []
  //           : List<dynamic>.from(otEmployeeTop5!.map((x) => x.toJson())),
  //       "employeeOTOver36Total": employeeOtOver36Total?.toJson(),
  //     };
}

class EmployeeOtOver36TotalModel extends EmployeeOtOver36Total {
  EmployeeOtOver36TotalModel({
    required List<WeekInMonth>? weekInMonth,
    required List<OtEmployeeTop5>? top5EmployeeOver36,
  }) : super(weekInMonth: weekInMonth, top5EmployeeOver36: top5EmployeeOver36);

  factory EmployeeOtOver36TotalModel.fromJson(Map<String, dynamic> json) =>
      EmployeeOtOver36TotalModel(
        weekInMonth: json["weekInMonth"] == null
            ? []
            : List<WeekInMonthModel>.from(
                json["weekInMonth"]!.map((x) => WeekInMonthModel.fromJson(x))),
        top5EmployeeOver36: json["top5EmployeeOver36"] == null
            ? []
            : List<OtEmployeeTop5Model>.from(json["top5EmployeeOver36"]!
                .map((x) => OtEmployeeTop5Model.fromJson(x))),
      );

// Map<String, dynamic> toJson() => {
//   "weekInMonth": weekInMonth == null ? [] : List<dynamic>.from(weekInMonth!.map((x) => x.toJson())),
//   "top5EmployeeOver36": top5EmployeeOver36 == null ? [] : List<dynamic>.from(top5EmployeeOver36!.map((x) => x.toJson())),
// };
}

class OtEmployeeTop5Model extends OtEmployeeTop5 {
  OtEmployeeTop5Model({
    required int? idEmployees,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? imageName,
    required int? over36Total,
    required String? imageProfile,
    required double? hourTotal,
  }) : super(
            idEmployees: idEmployees,
            firstnameTh: firstnameTh,
            lastnameTh: lastnameTh,
            imageName: imageName,
            over36Total: over36Total,
            imageProfile: imageProfile,
            hourTotal: hourTotal);

  factory OtEmployeeTop5Model.fromJson(Map<String, dynamic> json) =>
      OtEmployeeTop5Model(
        idEmployees: json["idEmployees"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        imageName: json["imageName"],
        over36Total: json["over36Total"],
        imageProfile: json["imageProfile"],
        hourTotal: json["hourTotal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "imageName": imageName,
        "over36Total": over36Total,
        "imageProfile": imageProfile,
        "hourTotal": hourTotal,
      };
}

class WeekInMonthModel extends WeekInMonth {
  WeekInMonthModel({
    required DateTime? weekStartDate,
    required DateTime? weekEndDate,
    required int? yearWeek,
    required DateTime? weekStartDateText,
    required DateTime? weekEndDateText,
    required int? over36HoursEmployeeTotal,
    required List<Over36HoursEmployee>? over36HoursEmployee,
  }) : super(
            weekStartDate: weekStartDate,
            weekEndDate: weekEndDate,
            yearWeek: yearWeek,
            weekStartDateText: weekStartDateText,
            weekEndDateText: weekEndDateText,
            over36HoursEmployeeTotal: over36HoursEmployeeTotal,
            over36HoursEmployee: over36HoursEmployee);

  factory WeekInMonthModel.fromJson(Map<String, dynamic> json) =>
      WeekInMonthModel(
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
            : List<Over36HoursEmployeeModel>.from(json["over36HoursEmployee"]!
                .map((x) => Over36HoursEmployeeModel.fromJson(x))),
      );

// Map<String, dynamic> toJson() => {
//       "weekStartDate": weekStartDate?.toIso8601String(),
//       "weekEndDate": weekEndDate?.toIso8601String(),
//       "yearWeek": yearWeek,
//       "weekStartDateText":
//           "${weekStartDateText!.year.toString().padLeft(4, '0')}-${weekStartDateText!.month.toString().padLeft(2, '0')}-${weekStartDateText!.day.toString().padLeft(2, '0')}",
//       "weekEndDateText":
//           "${weekEndDateText!.year.toString().padLeft(4, '0')}-${weekEndDateText!.month.toString().padLeft(2, '0')}-${weekEndDateText!.day.toString().padLeft(2, '0')}",
//       "over36HoursEmployeeTotal": over36HoursEmployeeTotal,
//       "over36HoursEmployee": over36HoursEmployee == null
//           ? []
//           : List<dynamic>.from(over36HoursEmployee!.map((x) => x.toJson())),
//     };
}

class Over36HoursEmployeeModel extends Over36HoursEmployee {
  Over36HoursEmployeeModel({
    required String? idEmployees,
  }) : super(idEmployees: idEmployees);

  factory Over36HoursEmployeeModel.fromJson(Map<String, dynamic> json) =>
      Over36HoursEmployeeModel(
        idEmployees: json["idEmployees"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
      };
}

class OtTotalModel extends OtTotal {
  OtTotalModel({
    required The15? the2,
    required The15? the3,
    required The15? the15,
  }) : super(the2: the2, the3: the3, the15: the15);

  factory OtTotalModel.fromJson(Map<String, dynamic> json) => OtTotalModel(
        the2: json["2"] == null ? null : The15Model.fromJson(json["2"]),
        the3: json["3"] == null ? null : The15Model.fromJson(json["3"]),
        the15: json["1.5"] == null ? null : The15Model.fromJson(json["1.5"]),
      );
}

class The15Model extends The15 {
  The15Model({
    required double? payTotal,
    required double? hourTotal,
  }) : super(payTotal: payTotal, hourTotal: hourTotal);

  factory The15Model.fromJson(Map<String, dynamic> json) => The15Model(
        payTotal: json["payTotal"]?.toDouble(),
        hourTotal: json["hourTotal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "payTotal": payTotal,
        "hourTotal": hourTotal,
      };
}

class OtTotalAllYearModel extends OtTotalAllYear {
  OtTotalAllYearModel({
    required double? payTotal,
    required int? month,
    required int? year,
  }) : super(payTotal: payTotal, month: month, year: year);

  factory OtTotalAllYearModel.fromJson(Map<String, dynamic> json) =>
      OtTotalAllYearModel(
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
