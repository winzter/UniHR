import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/timeline/domain/entities/entities.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class GetPayrollSettingTimeLine {
  final TimeLineRepository repository;
  GetPayrollSettingTimeLine({required this.repository});

  Future<Either<ErrorMessage, PayrollSetting>> call() async {
    return await repository.getPayrollSettingTimeLine();
  }
}