import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/gps/domain/entities/beacons_entity.dart';
import '../repositories/gps_repository.dart';

class GetBeacons{
  final GpsRepository repository;

  GetBeacons({required this.repository});

  Future<Either<ErrorMessage,List<BeaconsEntity>>> call()  async{
    return await repository.getBeacons();
  }
}