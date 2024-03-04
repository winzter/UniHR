import 'dart:convert';
import 'package:unihr/src/core/features/attendance/domain/entities/attendance_entity.dart';

List<AttendanceModel> attendanceFromJson(String str) =>
    List<AttendanceModel>.from(
        json.decode(str).map((x) => AttendanceModel.fromJson(x)));

// String attendanceToJson(List<AttendanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.date,
    required super.attendanceDisplay,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      attendanceDisplay: json["attendanceDisplay"] == null ? [] : List<AttendanceDisplayModel>.from(json["attendanceDisplay"]!.map((x) => AttendanceDisplayModel.fromJson(x))),
    );
  }
}

class AttendanceDisplayModel extends AttendanceDisplay {
  AttendanceDisplayModel({
    required super.checkIn,
    required super.checkOut,
  });

  factory AttendanceDisplayModel.fromJson(Map<String, dynamic> json) => AttendanceDisplayModel(
    checkIn: json["checkIn"] == null ? null : CheckModel.fromJson(json["checkIn"]),
    checkOut: json["checkOut"] == null ? null : CheckModel.fromJson(json["checkOut"]),
  );

}

class CheckModel extends CheckEntity {
  const CheckModel({
    // required super.idAttendance,
    required super.attendanceDateTime,
    required super.isCheckIn,
    required super.attendanceTextTime,
    required super.attendanceTextDateTime,
  });

  factory CheckModel.fromJson(Map<String, dynamic> json) => CheckModel(
    // idAttendance: json["idAttendance"],
    attendanceDateTime: json["attendanceDateTime"] == null ? null : DateTime.parse(json["attendanceDateTime"]),
    isCheckIn: json["isCheckIn"],
    attendanceTextTime: json["attendanceTextTime"],
    attendanceTextDateTime: json["attendanceTextDateTime"] == null ? null : DateTime.parse(json["attendanceTextDateTime"]),
      );
}
