import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/item_status_repository.dart';
import '../entities/entities.dart';

class GetPayrollSetting {
  final ItemStatusRepository repository;
  GetPayrollSetting({required this.repository});

  Future<Either<ErrorMessage, PayrollSettingEntity>> call() async {
    return await repository.getPayrollSetting();
  }
}
