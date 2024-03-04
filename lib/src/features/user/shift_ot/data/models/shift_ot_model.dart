import 'dart:convert';

import 'package:unihr/src/features/user/shift_ot/domain/entities/shift_ot_entitiy.dart';

ShiftAndOtModel shiftAndOtModelFromJson(String str) => ShiftAndOtModel.fromJson(json.decode(str));
// String shiftAndOtToJson(List<ShiftAndOtModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftAndOtModel extends ShiftAndOtEntity{


  ShiftAndOtModel({
    required DateTime? start,
    required DateTime? end,
    required int? idPaymentType,
    required DockModel? dock,
    required List<DataTableModel>? dataTable,
    required RateModel? rate,
    required int? isShiftFee,
  }):super(
    start: start,
    end: end,
    idPaymentType: idPaymentType,
    dock: dock,
    dataTable: dataTable,
    rate: rate,
    isShiftFee: isShiftFee,
  );

  factory ShiftAndOtModel.fromJson(Map<String, dynamic> json) => ShiftAndOtModel(
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    idPaymentType: json["idPaymentType"],
    dock: json["dock"] == null ? null : DockModel.fromJson(json["dock"]),
    isShiftFee: json["isShiftFee"],
    dataTable: json["dataTable"] == null ? [] : List<DataTableModel>.from(json["dataTable"]!.map((x) => DataTableModel.fromJson(x))),
    rate: json["rate"] == null ? null : RateModel.fromJson(json["rate"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
  //   "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
  //   "idPaymentType": idPaymentType,
  //   "dock": dock?.toJson(),
  //   "isShiftFee": isShiftFee,
  //   "dataTable": dataTable == null ? [] : List<dynamic>.from(dataTable!.map((x) => x.toJson())),
  //   "rate": rate?.toJson(),
  // };
}

class DataTableModel extends DataTableEntity{


  DataTableModel({
    required String? date,
    required double? otOneHours,
    required double? otOneAmount,
    required double? otOneFiveHours,
    required double? otOneFiveAmount,
    required double? otTwoHours,
    required double? otTwoAmount,
    required double? otThreeHours,
    required double? otThreeAmount,
    required DataRenderModel? dataRender,
    required double? shiftPayMorning,
    required double? shiftPayAfternoon,
    required double? shiftPayNight,
    required double? shiftPayTotal,
  }):super(
      date:date,
      otOneHours: otOneHours,
      otOneAmount:otOneAmount,
      otOneFiveHours: otOneFiveHours,
      otOneFiveAmount: otOneFiveAmount,
      otTwoHours: otTwoHours,
      otTwoAmount: otTwoAmount,
      otThreeHours: otThreeHours,
      otThreeAmount: otThreeAmount,
      dataRender: dataRender,
      shiftPayMorning: shiftPayMorning,
      shiftPayAfternoon: shiftPayAfternoon,
      shiftPayNight: shiftPayNight,
      shiftPayTotal: shiftPayTotal
  );

  factory DataTableModel.fromJson(Map<String, dynamic> json) => DataTableModel(
    date: json["date"],
    otOneHours: json["otOneHours"]?.toDouble(),
    otOneAmount: json["otOneAmount"]?.toDouble(),
    otOneFiveHours: json["otOneFiveHours"]?.toDouble(),
    otOneFiveAmount: json["otOneFiveAmount"]?.toDouble(),
    otTwoHours: json["otTwoHours"]?.toDouble(),
    otTwoAmount: json["otTwoAmount"]?.toDouble(),
    otThreeHours: json["otThreeHours"]?.toDouble(),
    otThreeAmount: json["otThreeAmount"]?.toDouble(),
    dataRender: json["dataRender"] == null ? null : DataRenderModel.fromJson(json["dataRender"]),
    shiftPayMorning: json["shiftPayMorning"]?.toDouble(),
    shiftPayAfternoon: json["shiftPayAfternoon"]?.toDouble(),
    shiftPayNight: json["shiftPayNight"]?.toDouble(),
    shiftPayTotal: json["shiftPayTotal"]?.toDouble(),
  );

  // Map<String, dynamic> toJson() => {
  //   "date": date,
  //   "otOneHours": otOneHours,
  //   "otOneAmount": otOneAmount,
  //   "otOneFiveHours": otOneFiveHours,
  //   "otOneFiveAmount": otOneFiveAmount,
  //   "otTwoHours": otTwoHours,
  //   "otTwoAmount": otTwoAmount,
  //   "otThreeHours": otThreeHours,
  //   "otThreeAmount": otThreeAmount,
  //   "dataRender": dataRender?.toJson(),
  //   "shiftPayMorning": shiftPayMorning,
  //   "shiftPayAfternoon": shiftPayAfternoon,
  //   "shiftPayNight": shiftPayNight,
  //   "shiftPayTotal": shiftPayTotal,
  // };
}

class DataRenderModel extends DataRenderEntity{


  DataRenderModel({
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
    required int? lateIn,
    required int? workingHours,
    required int? period,
    required int? idShiftGroup,
    required String? shiftGroupName,
    required int? shiftStartInMonday,
    required DateTime? shiftStartDate,
    required int? shiftNumber,
    required int? workDay,
    required int? isTimeFrame,
    required int? idWorkingType,
    required String? workingTypeName,
  }):super(
    idShiftPattern : idShiftPattern,
    indexScheduleId : indexScheduleId,
    idShift : idShift,
    shiftName : shiftName,
    idShiftType : idShiftType,
    shiftTypeName : shiftTypeName,
    timeIn : timeIn,
    timeOut : timeOut,
    breakTime : breakTime,
    isWorkingDay : isWorkingDay,
    lateIn : lateIn,
    workingHours : workingHours,
    period : period,
    idShiftGroup : idShiftGroup,
    shiftGroupName : shiftGroupName,
    shiftStartInMonday : shiftStartInMonday,
    shiftStartDate : shiftStartDate,
    shiftNumber : shiftNumber,
    workDay : workDay,
    isTimeFrame : isTimeFrame,
    idWorkingType : idWorkingType,
    workingTypeName : workingTypeName,
  );

  factory DataRenderModel.fromJson(Map<String, dynamic> json) => DataRenderModel(
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
    lateIn: json["lateIn"],
    workingHours: json["workingHours"],
    period: json["period"],
    idShiftGroup: json["idShiftGroup"],
    shiftGroupName: json["shiftGroupName"],
    shiftStartInMonday: json["shiftStartInMonday"],
    shiftStartDate: json["shiftStartDate"] == null ? null : DateTime.parse(json["shiftStartDate"]),
    shiftNumber: json["shiftNumber"],
    workDay: json["workDay"],
    isTimeFrame: json["isTimeFrame"],
    idWorkingType: json["idWorkingType"],
    workingTypeName: json["workingTypeName"],
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
    "lateIn": lateIn,
    "workingHours": workingHours,
    "period": period,
    "idShiftGroup": idShiftGroup,
    "shiftGroupName": shiftGroupName,
    "shiftStartInMonday": shiftStartInMonday,
    "shiftStartDate": shiftStartDate?.toIso8601String(),
    "shiftNumber": shiftNumber,
    "workDay": workDay,
    "isTimeFrame": isTimeFrame,
    "idWorkingType": idWorkingType,
    "workingTypeName": workingTypeName,
  };
}

class DockModel extends DockEntity{

  DockModel({
    required DateTime? start,
    required DateTime? end,
    required AbsentModel? lateEarly,
    required AbsentModel? absent,
  }):super(
    start: start,
    end: end,
    lateEarly: lateEarly,
    absent: absent
  );

  factory DockModel.fromJson(Map<String, dynamic> json) => DockModel(
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    lateEarly: json["lateEarly"] == null ? null : AbsentModel.fromJson(json["lateEarly"]),
    absent: json["absent"] == null ? null : AbsentModel.fromJson(json["absent"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
  //   "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
  //   "lateEarly": lateEarly?.toJson(),
  //   "absent": absent?.toJson(),
  // };
}

class AbsentModel extends AbsentEntity{


  AbsentModel({
    required int? value,
    required int? amount,
  }):super(
    value: value,
    amount: amount
  );

  factory AbsentModel.fromJson(Map<String, dynamic> json) => AbsentModel(
    value: json["value"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "amount": amount,
  };
}

class RateModel extends RateEntity{


  RateModel({
    required double? manDay,
    required double? otRate,
    required double? proRate,
  }):super(
    manDay: manDay,
    otRate: otRate,
    proRate: proRate
  );

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
    manDay: json["manDay"]?.toDouble(),
    otRate: json["otRate"]?.toDouble(),
    proRate: json["proRate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "manDay": manDay,
    "otRate": otRate,
    "proRate": proRate,
  };
}
