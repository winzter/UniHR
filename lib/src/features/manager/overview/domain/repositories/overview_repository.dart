import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/cost_entity.dart';
import '../entities/entities.dart';

abstract class OverviewRepository {
  Future<Either<ErrorMessage, OverviewEntity>> getOverview(
    String month,
    String year,
    int? idDepartment,
    int? idSection,
  );

  Future<Either<ErrorMessage, OvertimeEntity>> getOverTime(
      String month,
      String year,
      int? idDepartment,
      int? idSection,
      );

  Future<Either<ErrorMessage, WorkingTimeEntity>> getWorkingTime(
      String month,
      String year,
      int? idDepartment,
      int? idSection,
      );

  Future<Either<ErrorMessage, CostEntity>> getCost(
      String month,
      String year,
      int? idDepartment,
      int? idSection,
      );

  Future<Either<ErrorMessage, List<DepartmentEntity>>> getDepartment();
}
