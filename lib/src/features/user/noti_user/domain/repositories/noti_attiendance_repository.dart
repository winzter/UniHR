import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/noti_user/domain/entities/noti_attendance_entity.dart';

abstract class NotiattiendanceRepository {
  Future<Either<ErrorMessage, List<NotiattendanceEntity>>> getNotiattiendance();
}
