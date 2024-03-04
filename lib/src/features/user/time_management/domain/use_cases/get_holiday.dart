import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/error/failures.dart';
import '../entities/enitities.dart';

class GetHoliday {
  final TimeManagementRepository repository;

  GetHoliday({required this.repository});

  Future<Either<ErrorMessage, List<HolidayEntity>>> call() async {
    return await repository.getHoliday();
  }
}
