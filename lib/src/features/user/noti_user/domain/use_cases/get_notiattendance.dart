import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/noti_user/domain/entities/noti_attendance_entity.dart';
import 'package:unihr/src/features/user/noti_user/domain/repositories/noti_attiendance_repository.dart';

class GetNotiattendance {
  final NotiattiendanceRepository repository;
  GetNotiattendance({required this.repository});

  Future<Either<ErrorMessage, List<NotiattendanceEntity>>> call() async {
    return await repository.getNotiattiendance();
  }
}
