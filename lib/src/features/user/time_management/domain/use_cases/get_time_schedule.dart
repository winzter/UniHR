import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/domain/entities/time_schedule.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/error/failures.dart';

class GetTimeSchedule {
  final TimeManagementRepository repository;

  GetTimeSchedule({required this.repository});

  Future<Either<ErrorMessage, List<TimeScheduleEntity>>> call(String startDate) async {
    return await repository.getTimeSchedule(startDate);
  }
}
