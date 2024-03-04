import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/leave/domain/entities/entities.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';


class GetHolidayLeave {
  final LeaveRepository repository;
  GetHolidayLeave({required this.repository});

  Future<Either<ErrorMessage,List<HolidayLeaveEntity>>>call() async{
    return await repository.getHolidayLeave();
  }
}