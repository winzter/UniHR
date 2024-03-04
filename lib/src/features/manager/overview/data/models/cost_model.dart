import 'dart:convert';

import 'package:unihr/src/features/manager/overview/domain/entities/cost_entity.dart';

CostModel costModelFromJson(String str) => CostModel.fromJson(json.decode(str));

// String costModelToJson(CostModel data) => json.encode(data.toJson());

class CostModel extends CostEntity {
  CostModel({
    required int? employeeTotal,
    required double? salaryTotal,
    required List<SalaryTotalAllYearModel>? salaryTotalAllYear,
    required OtTotalModel? otTotal,
    required List<OtTotalAllYearModel>? otTotalAllYear,
  }) : super(
          employeeTotal: employeeTotal,
          salaryTotal: salaryTotal,
          salaryTotalAllYear: salaryTotalAllYear,
          otTotal: otTotal,
          otTotalAllYear: otTotalAllYear,
        );

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        employeeTotal: json["employeeTotal"],
        salaryTotal: json["salaryTotal"]?.toDouble(),
        salaryTotalAllYear: json["salaryTotalAllYear"] == null
            ? []
            : List<SalaryTotalAllYearModel>.from(json["salaryTotalAllYear"]!
                .map((x) => SalaryTotalAllYearModel.fromJson(x))),
        otTotal:
            json["otTotal"] == null ? null : OtTotalModel.fromJson(json["otTotal"]),
        otTotalAllYear: json["otTotalAllYear"] == null
            ? []
            : List<OtTotalAllYearModel>.from(
                json["otTotalAllYear"]!.map((x) => OtTotalAllYearModel.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "employeeTotal": employeeTotal,
  //       "salaryTotal": salaryTotal,
  //       "salaryTotalAllYear": salaryTotalAllYear == null
  //           ? []
  //           : List<dynamic>.from(salaryTotalAllYear!.map((x) => x.toJson())),
  //       "otTotal": otTotal?.toJson(),
  //       "otTotalAllYear": otTotalAllYear == null
  //           ? []
  //           : List<dynamic>.from(otTotalAllYear!.map((x) => x.toJson())),
  //     };
}

class OtTotalModel extends OtTotal{


  OtTotalModel({
    required The15Model? the2,
    required The15Model? the3,
    required The15Model? the15,
  }):super(
    the2: the2,
    the15: the15,
    the3: the3
  );

  factory OtTotalModel.fromJson(Map<String, dynamic> json) => OtTotalModel(
        the2: json["2"] == null ? null : The15Model.fromJson(json["2"]),
        the3: json["3"] == null ? null : The15Model.fromJson(json["3"]),
        the15: json["1.5"] == null ? null : The15Model.fromJson(json["1.5"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "2": the2?.toJson(),
  //       "3": the3?.toJson(),
  //       "1.5": the15?.toJson(),
  //     };
}

class The15Model extends The15{


  The15Model({
    required double? payTotal,
    required double? hourTotal,
  }):super(
    payTotal:payTotal,
    hourTotal:hourTotal
  );

  factory The15Model.fromJson(Map<String, dynamic> json) => The15Model(
        payTotal: json["payTotal"]?.toDouble(),
        hourTotal: json["hourTotal"]?.toDouble(),
      );

  // Map<String, dynamic> toJson() => {
  //       "payTotal": payTotal,
  //       "hourTotal": hourTotal,
  //     };
}

class OtTotalAllYearModel extends OtTotalAllYear{


  OtTotalAllYearModel({
    required double? payTotal,
    required int? month,
    required int? year,
  }):super(
    payTotal: payTotal,
    month: month,
    year: year
  );

  factory OtTotalAllYearModel.fromJson(Map<String, dynamic> json) => OtTotalAllYearModel(
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

class SalaryTotalAllYearModel extends SalaryTotalAllYear{


  SalaryTotalAllYearModel({
    required int? month,
    required int? year,
    required double? salaryTotal,
  }):super(
    month: month,
    year: year,
    salaryTotal: salaryTotal
  );

  factory SalaryTotalAllYearModel.fromJson(Map<String, dynamic> json) =>
      SalaryTotalAllYearModel(
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
