import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/travelling/domain/entities/travelling_time_line_entity.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/travelling_repostiory.dart';

class GetTimelineById {
  final TravellingRepository repository;

  GetTimelineById({required this.repository});

  Future<Either<ErrorMessage, List<TravellingTimeLineEntity>>> call(
      DateTime date,
      int idEmp,
      ) async {
    return await repository.getTimelineById(date, idEmp);
  }
}
