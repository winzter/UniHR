import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/working_time_repository.dart';

class GetPayrollSettingManager {
  final WorkingTimeRepository repository;

  GetPayrollSettingManager({required this.repository});

  Future<Either<ErrorMessage,List<PayrollSettingEntity>>> call() async{
    return await repository.getPayrollSetting();
  }
}