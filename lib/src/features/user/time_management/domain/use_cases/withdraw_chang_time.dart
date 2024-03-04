import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/error/failures.dart';

class WithDrawChangeTime {
  final TimeManagementRepository repository;

  WithDrawChangeTime({required this.repository});

  Future<Either<ErrorMessage, void>> call(int idEmployeeShiftDaily,int idEmployees) async {
    return await repository.withdrawChangTime(idEmployeeShiftDaily, idEmployees);
  }
}
