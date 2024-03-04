import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../entities/location_entity.dart';
import '../repositories/gps_repository.dart';

class GetLocation{
  final GpsRepository repository;

  GetLocation({required this.repository});

  Future<Either<ErrorMessage,LineCheckIn>> call(int idEmp) async{
    return await repository.getLocation(idEmp);
  }
}