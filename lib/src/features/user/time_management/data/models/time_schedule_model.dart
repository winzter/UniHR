import 'dart:convert';
import '../../domain/entities/time_schedule.dart';

List<TimeScheduleModel> timeScheduleModelFromJson(String str) =>
    List<TimeScheduleModel>.from(
        json.decode(str).map((x) => TimeScheduleModel.fromJson(x)));

String timeScheduleModelToJson(List<TimeScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeScheduleModel extends TimeScheduleEntity {
  final DateTime? date;
  final DataRenderModel? dataRender;
  final List<RequestChangeModel>? requestChange;

  TimeScheduleModel({
    this.date,
    this.dataRender,
    this.requestChange,
  });

  factory TimeScheduleModel.fromJson(Map<String, dynamic> json) =>
      TimeScheduleModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dataRender: json["dataRender"] == null
            ? null
            : DataRenderModel.fromJson(json["dataRender"]),
        requestChange: json["requestChange"] == null
            ? []
            : List<RequestChangeModel>.from(json["requestChange"]!
                .map((x) => RequestChangeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "dataRender": dataRender?.toJson(),
        "requestChange": requestChange == null
            ? []
            : List<dynamic>.from(requestChange!.map((x) => x.toJson())),
      };
}

class DataRenderModel extends DataRenderEntity {
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
    required int? idWorkingType,
    required String? workingTypeName,
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
          lateIn: lateIn,
          workingHours: workingHours,
          period: period,
          idShiftGroup: idShiftGroup,
          shiftGroupName: shiftGroupName,
          shiftStartInMonday: shiftStartInMonday,
          shiftStartDate: shiftStartDate,
          shiftNumber: shiftNumber,
          workDay: workDay,
          idWorkingType: idWorkingType,
          workingTypeName: workingTypeName,
        );

  factory DataRenderModel.fromJson(Map<String, dynamic> json) =>
      DataRenderModel(
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
        shiftStartDate: json["shiftStartDate"] == null
            ? null
            : DateTime.parse(json["shiftStartDate"]),
        shiftNumber: json["shiftNumber"],
        workDay: json["workDay"],
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
        "idWorkingType": idWorkingType,
        "workingTypeName": workingTypeName,
      };
}

class RequestChangeModel extends RequestChangeEntity {
  RequestChangeModel({
    required int? idEmployeeShiftDaily,
    required int? idEmployees,
    required int? idShift,
    required int? idShiftType,
    required DateTime? workingDate,
    required int? idShiftGroup,
    required int? isWorkingDay,
    required int? isApprove,
    required int? isActive,
    required DateTime? createDate,
    required int? approveBy,
    required DateTime? approveDate,
    required String? approveComment,
    required dynamic fillInApprove,
    required dynamic idHoliday,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? email,
    required DateTime? workingDateText,
    required String? approveDateText,
    required String? createDateText,
  }) : super(
          idEmployeeShiftDaily:idEmployeeShiftDaily,
          idEmployees: idEmployees,
          idShift: idShift,
          idShiftType: idShiftType,
          workingDate: workingDate,
          idShiftGroup: idShiftGroup,
          isWorkingDay: isWorkingDay,
          isApprove: isApprove,
          isActive: isActive,
          createDate: createDate,
          approveBy: approveBy,
          approveDate: approveDate,
          approveComment: approveComment,
          fillInApprove: fillInApprove,
          idHoliday: idHoliday,
          firstnameTh: firstnameTh,
          lastnameTh: lastnameTh,
          email: email,
          workingDateText: workingDateText,
          approveDateText: approveDateText,
          createDateText: createDateText,
        );

  factory RequestChangeModel.fromJson(Map<String, dynamic> json) =>
      RequestChangeModel(
        idEmployeeShiftDaily: json["idEmployeeShiftDaily"],
        idEmployees: json["idEmployees"],
        idShift: json["idShift"],
        idShiftType: json["idShiftType"],
        workingDate: json["workingDate"] == null
            ? null
            : DateTime.parse(json["workingDate"]),
        idShiftGroup: json["idShiftGroup"],
        isWorkingDay: json["isWorkingDay"],
        isApprove: json["isApprove"],
        isActive: json["isActive"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        approveBy: json["approveBy"],
        approveDate: json["approveDate"] == null
            ? null
            : DateTime.parse(json["approveDate"]),
        approveComment: json["approveComment"],
        fillInApprove: json["fillInApprove"],
        idHoliday: json["idHoliday"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        email: json["email"],
        workingDateText: json["workingDateText"] == null
            ? null
            : DateTime.parse(json["workingDateText"]),
        approveDateText: json["approveDateText"],
        createDateText: json["createDateText"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployeeShiftDaily": idEmployeeShiftDaily,
        "idEmployees": idEmployees,
        "idShift": idShift,
        "idShiftType": idShiftType,
        "workingDate": workingDate?.toIso8601String(),
        "idShiftGroup": idShiftGroup,
        "isWorkingDay": isWorkingDay,
        "isApprove": isApprove,
        "isActive": isActive,
        "createDate": createDate?.toIso8601String(),
        "approveBy": approveBy,
        "approveDate": approveDate?.toIso8601String(),
        "approveComment": approveComment,
        "fillInApprove": fillInApprove,
        "idHoliday": idHoliday,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "email": email,
        "workingDateText":
            "${workingDateText!.year.toString().padLeft(4, '0')}-${workingDateText!.month.toString().padLeft(2, '0')}-${workingDateText!.day.toString().padLeft(2, '0')}",
        "approveDateText": approveDateText,
        "createDateText": createDateText,
      };
}
