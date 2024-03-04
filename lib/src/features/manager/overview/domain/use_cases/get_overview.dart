import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/overview_repository.dart';

class GetOverview {
  final OverviewRepository repository;

  GetOverview({required this.repository});

  Future<Either<ErrorMessage, OverviewEntity>> call(
    String month,
    String year,
    int? idDepartment,
    int? idSection,
  ) async {
    return await repository.getOverview(
      month,
      year,
      idDepartment,
      idSection,
    );
  }
}
