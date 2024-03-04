import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/overview_repository.dart';

class GetWorkingTime {
  final OverviewRepository repository;

  GetWorkingTime({required this.repository});

  Future<Either<ErrorMessage, WorkingTimeEntity>> call(
      String month,
      String year,
      int? idDepartment,
      int? idSection,
      ) async {
    return await repository.getWorkingTime(
      month,
      year,
      idDepartment,
      idSection,
    );
  }
}
