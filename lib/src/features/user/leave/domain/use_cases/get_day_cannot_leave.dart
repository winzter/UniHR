import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/leave/domain/entities/day_cannot_leave_entity.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/leave_repository.dart';


class GetDayCannotLeave {
  final LeaveRepository repository;
  GetDayCannotLeave({required this.repository});

  Future<Either<ErrorMessage,List<DayCannotLeave>>>call(DateTime start,DateTime end,int idEmp) async{
    return await repository.getDayCannotLeave(start,end,idEmp);
  }
}