import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/core/features/attendance/domain/entities/attendance_entity.dart';

abstract class AttendanceRepository{
  Future<Either<ErrorMessage,List<AttendanceEntity>>> getAttendance();
  Future<Either<ErrorMessage,List<AttendanceEntity>>> getAttendanceByDate(String start,String end);
}