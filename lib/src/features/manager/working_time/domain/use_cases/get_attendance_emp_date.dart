import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../user/timeline/domain/entities/entities.dart';
import '../repositories/working_time_repository.dart';

class GetAttendanceEmpDate{
  final WorkingTimeRepository repository;

  GetAttendanceEmpDate({required this.repository});

  Future<Either<ErrorMessage,List<TimeLineEntity>>> call(int id,String start,String end) async{
    return await repository.getAttendanceEmpDate(id,start,end);
  }
}