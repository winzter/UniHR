import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/waiting_status/domain/repositories/waiting_status_repository.dart';
import '../../../../../core/error/failures.dart';
import '../../../../user/item_status/domain/entities/entities.dart';


class GetPayrollSettingManager{
  final WaitingStatusRepository repository;

  GetPayrollSettingManager({required this.repository});

  Future<Either<ErrorMessage,PayrollSettingEntity>> call() async{
    return await repository.getPayrollSetting();
  }
}