import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/domain/entities/shift_entity.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/error/failures.dart';

class GetShift {
  final TimeManagementRepository repository;

  GetShift({required this.repository});

  Future<Either<ErrorMessage, List<ShiftEntity>>> call() async {
    return await repository.getShift();
  }
}
