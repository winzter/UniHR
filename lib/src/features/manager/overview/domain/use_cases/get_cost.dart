import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/cost_entity.dart';
import '../repositories/overview_repository.dart';

class GetCost{
  final OverviewRepository repository;

  GetCost({required this.repository});

  Future<Either<ErrorMessage, CostEntity>> call(
      String month,
      String year,
      int? idDepartment,
      int? idSection,
      ) async {
    return await repository.getCost(
      month,
      year,
      idDepartment,
      idSection,
    );
  }
}
