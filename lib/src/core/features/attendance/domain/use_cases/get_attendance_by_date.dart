import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceByDate {
  final AttendanceRepository repository;
  GetAttendanceByDate({required this.repository});

  Future<Either<ErrorMessage, List<AttendanceEntity>>> call(
      String startDate, String endDate) async {
    return await repository.getAttendanceByDate(startDate, endDate);
  }
}