import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable{
  final DateTime? date;
  final List<AttendanceDisplay>? attendanceDisplay;

  const AttendanceEntity({
    this.date,
    this.attendanceDisplay,
  });

  @override
  List<Object?> get props => [
    date,
    attendanceDisplay,
  ];
}

class AttendanceClassEntity extends Equatable{
  final List<CheckEntity?>? checkIn;
  final List<CheckEntity?>? checkOut;

  const AttendanceClassEntity({
    this.checkIn,
    this.checkOut,
  });

  @override
  List<Object?> get props => [
    checkIn,
    checkOut,
  ];
}

class AttendanceDisplay {
  final CheckEntity? checkIn;
  final CheckEntity? checkOut;

  AttendanceDisplay({
    this.checkIn,
    this.checkOut,
  });

}

class CheckEntity extends Equatable{
  // final int? idAttendance;
  final DateTime? attendanceDateTime;
  final int? isCheckIn;
  final String? attendanceTextTime;
  final DateTime? attendanceTextDateTime;

  const CheckEntity({
    // this.idAttendance,
    this.attendanceDateTime,
    this.isCheckIn,
    this.attendanceTextTime,
    this.attendanceTextDateTime,
  });

  @override
  List<Object?> get props => [
    // idAttendance,
    attendanceDateTime,
    isCheckIn,
    attendanceTextTime,
    attendanceTextDateTime,
  ];
}