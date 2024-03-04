import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/timeline_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendance {
  final TimeLineRepository repository;
  GetAttendance({required this.repository});

  Future<Either<ErrorMessage, List<TimeLineEntity>>> call() async {
    return await repository.getAttendance();
  }
}