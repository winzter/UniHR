import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/overview_repository.dart';

class GetOverTime{
  final OverviewRepository repository;

  GetOverTime({required this.repository});

  Future<Either<ErrorMessage, OvertimeEntity>> call(
      String month,
      String year,
      int? idDepartment,
      int? idSection,
      ) async {
    return await repository.getOverTime(
      month,
      year,
      idDepartment,
      idSection,
    );
  }
}
