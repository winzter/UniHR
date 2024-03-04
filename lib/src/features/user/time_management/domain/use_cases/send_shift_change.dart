import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/shift_change.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/error/failures.dart';


class SendShiftChange {
  final TimeManagementRepository repository;

  SendShiftChange({required this.repository});

  Future<Either<ErrorMessage, void>> call(ShiftChange data) async {
    return await repository.sendChangeTime(data);
  }
}
