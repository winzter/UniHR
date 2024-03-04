import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/leave_repository.dart';

class GetLeaveSettingData{
  final LeaveRepository repository;
  GetLeaveSettingData({required this.repository});

  Future<Either<ErrorMessage,LeaveSettingEntity>> call() async{
    return await repository.getLeaveSettingData();
  }
}