import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/travelling/domain/entities/entities.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/travelling_repostiory.dart';

class IsCheckIn {
  final TravellingRepository repository;

  IsCheckIn({required this.repository});

  Future<Either<ErrorMessage, IsCheckInEntity>> call(
      int idEmp,
      ) async {
    return await repository.isCheckIn(idEmp);
  }
}
