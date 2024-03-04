import 'dart:convert';

import 'package:unihr/src/features/user/time_management/domain/entities/shift_entity.dart';

List<ShiftModel> shiftEntityFromJson(String str) =>
    List<ShiftModel>.from(json.decode(str).map((x) => ShiftModel.fromJson(x)));

// String shiftEntityToJson(List<ShiftModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftModel extends ShiftEntity {
  ShiftModel({
    required int? idShiftGroup,
    required String? shiftGroupName,
    required int? shiftStartInMonday,
    required DateTime? shiftStartDate,
    required int? workDay,
    required int? offDay,
    required int? shiftNumber,
    required int? idWorkingType,
    required List<ShiftPatternModel>? shiftPattern,
    required List<ShiftDataModel>? shift,
    required List<ShiftTypeModel>? shiftType,
  }):super(
    idShiftGroup : idShiftGroup,
    shiftGroupName : shiftGroupName,
    shiftStartInMonday : shiftStartInMonday,
    shiftStartDate : shiftStartDate,
    workDay : workDay,
    offDay : offDay,
    shiftNumber : shiftNumber,
    idWorkingType : idWorkingType,
    shiftPattern: shiftPattern,
    shift: shift,
    shiftType: shiftType
  );

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
        idShiftGroup: json["idShiftGroup"],
        shiftGroupName: json["shiftGroupName"],
        shiftStartInMonday: json["shiftStartInMonday"],
        shiftStartDate: json["shiftStartDate"] == null
            ? null
            : DateTime.parse(json["shiftStartDate"]),
        workDay: json["workDay"],
        offDay: json["offDay"],
        shiftNumber: json["shiftNumber"],
        idWorkingType: json["idWorkingType"],
        shiftPattern: json["shiftPattern"] == null
            ? []
            : List<ShiftPatternModel>.from(
                json["shiftPattern"]!.map((x) => ShiftPatternModel.fromJson(x))),
        shift: json["shift"] == null
            ? []
            : List<ShiftDataModel>.from(
                json["shift"]!.map((x) => ShiftDataModel.fromJson(x))),
        shiftType: json["shiftType"] == null
            ? []
            : List<ShiftTypeModel>.from(
                json["shiftType"]!.map((x) => ShiftTypeModel.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "idShiftGroup": idShiftGroup,
  //       "shiftGroupName": shiftGroupName,
  //       "shiftStartInMonday": shiftStartInMonday,
  //       "shiftStartDate": shiftStartDate?.toIso8601String(),
  //       "workDay": workDay,
  //       "offDay": offDay,
  //       "shiftNumber": shiftNumber,
  //       "idWorkingType": idWorkingType,
  //       "shiftPattern": shiftPattern == null
  //           ? []
  //           : List<dynamic>.from(shiftPattern!.map((x) => x.toJson())),
  //       "shift": shift == null
  //           ? []
  //           : List<dynamic>.from(shift!.map((x) => x.toJson())),
  //       "shiftType": shiftType == null
  //           ? []
  //           : List<dynamic>.from(shiftType!.map((x) => x.toJson())),
  //     };
}

class ShiftDataModel extends ShiftData {
  ShiftDataModel({
    required int? idShift,
    required String? shiftName,
    required int? idShiftGroup,
    required int? idCompany,
    required int? isActive,
  }) : super(
          idShift: idShift,
          shiftName: shiftName,
          idShiftGroup: idShiftGroup,
          idCompany: idCompany,
          isActive: isActive,
        );

  factory ShiftDataModel.fromJson(Map<String, dynamic> json) => ShiftDataModel(
        idShift: json["idShift"],
        shiftName: json["shiftName"],
        idShiftGroup: json["idShiftGroup"],
        idCompany: json["idCompany"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "idShift": idShift,
        "shiftName": shiftName,
        "idShiftGroup": idShiftGroup,
        "idCompany": idCompany,
        "isActive": isActive,
      };
}

class ShiftPatternModel extends ShiftPattern {
  ShiftPatternModel({
    required int? idShiftPattern,
    required int? indexScheduleId,
    required int? idShift,
    required String? shiftName,
    required int? idShiftType,
    required String? shiftTypeName,
    required String? timeIn,
    required String? timeOut,
    required int? breakTime,
    required int? isWorkingDay,
    required int? idShiftGroup,
    required String? shiftGroupName,
    required int? shiftStartInMonday,
  }) : super(
          idShiftPattern: idShiftPattern,
          indexScheduleId: indexScheduleId,
          idShift: idShift,
          shiftName: shiftName,
          idShiftType: idShiftType,
          shiftTypeName: shiftTypeName,
          timeIn: timeIn,
          timeOut: timeOut,
          breakTime: breakTime,
          isWorkingDay: isWorkingDay,
          idShiftGroup: idShiftGroup,
          shiftGroupName: shiftGroupName,
          shiftStartInMonday: shiftStartInMonday,
        );

  factory ShiftPatternModel.fromJson(Map<String, dynamic> json) =>
      ShiftPatternModel(
        idShiftPattern: json["idShiftPattern"],
        indexScheduleId: json["indexScheduleId"],
        idShift: json["idShift"],
        shiftName: json["shiftName"],
        idShiftType: json["idShiftType"],
        shiftTypeName: json["shiftTypeName"],
        timeIn: json["timeIn"],
        timeOut: json["timeOut"],
        breakTime: json["breakTime"],
        isWorkingDay: json["isWorkingDay"],
        idShiftGroup: json["idShiftGroup"],
        shiftGroupName: json["shiftGroupName"],
        shiftStartInMonday: json["shiftStartInMonday"],
      );

  Map<String, dynamic> toJson() => {
        "idShiftPattern": idShiftPattern,
        "indexScheduleId": indexScheduleId,
        "idShift": idShift,
        "shiftName": shiftName,
        "idShiftType": idShiftType,
        "shiftTypeName": shiftTypeName,
        "timeIn": timeIn,
        "timeOut": timeOut,
        "breakTime": breakTime,
        "isWorkingDay": isWorkingDay,
        "idShiftGroup": idShiftGroup,
        "shiftGroupName": shiftGroupName,
        "shiftStartInMonday": shiftStartInMonday,
      };
}

class ShiftTypeModel extends ShiftType {
  ShiftTypeModel({
    required int? idShiftType,
    required String? shiftTypeName,
    required String? timeIn,
    required String? timeOut,
    required int? lateIn,
    required int? idShiftGroup,
    required int? workingHours,
    required int? period,
    required int? isWorkingDay,
  }) : super(
          idShiftType: idShiftType,
          shiftTypeName: shiftTypeName,
          timeIn: timeIn,
          timeOut: timeOut,
          lateIn: lateIn,
          idShiftGroup: idShiftGroup,
          workingHours: workingHours,
          period: period,
          isWorkingDay: isWorkingDay,
        );

  factory ShiftTypeModel.fromJson(Map<String, dynamic> json) => ShiftTypeModel(
        idShiftType: json["idShiftType"],
        shiftTypeName: json["shiftTypeName"],
        timeIn: json["timeIn"],
        timeOut: json["timeOut"],
        lateIn: json["lateIn"],
        idShiftGroup: json["idShiftGroup"],
        workingHours: json["workingHours"],
        period: json["period"],
        isWorkingDay: json["isWorkingDay"],
      );

  Map<String, dynamic> toJson() => {
        "idShiftType": idShiftType,
        "shiftTypeName": shiftTypeName,
        "timeIn": timeIn,
        "timeOut": timeOut,
        "lateIn": lateIn,
        "idShiftGroup": idShiftGroup,
        "workingHours": workingHours,
        "period": period,
        "isWorkingDay": isWorkingDay,
      };
}
