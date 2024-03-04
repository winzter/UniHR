import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/error/failures.dart';
import '../entities/enitities.dart';

class GetCheckHoliday {
  final TimeManagementRepository repository;

  GetCheckHoliday({required this.repository});

  Future<Either<ErrorMessage, List<CheckHolidayEntity>>> call(String startDate) async {
    return await repository.getCheckHoliday(startDate);
  }
}
