import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendance {
  final AttendanceRepository repository;
  GetAttendance({required this.repository});

  Future<Either<ErrorMessage, List<AttendanceEntity>>> call() async {
    return await repository.getAttendance();
  }
}