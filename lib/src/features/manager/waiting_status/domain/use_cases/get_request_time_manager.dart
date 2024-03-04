import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/waiting_status_repository.dart';

class GetRequestTimeManager{
  final WaitingStatusRepository repository;

  GetRequestTimeManager({required this.repository});

  Future<Either<ErrorMessage,List<RequestTimeManager>>> call({String? start , String? end}) async{
    return await repository.getRequestTimeManager(start: start,end: end);
  }

}