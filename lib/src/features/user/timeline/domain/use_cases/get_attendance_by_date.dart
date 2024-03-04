import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/timeline_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceByDate {
  final TimeLineRepository repository;
  GetAttendanceByDate({required this.repository});

  Future<Either<ErrorMessage, List<TimeLineEntity>>> call(
      String startDate, String endDate) async {
    return await repository.getAttendanceByDate(startDate, endDate);
  }
}