import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/travelling_repostiory.dart';

class SendRouteRecord {
  final TravellingRepository repository;

  SendRouteRecord({required this.repository});

  Future<Either<ErrorMessage, void>> call(
      int idCompany,
      int idEmp,
      bool isCheckIn,
      double lat,
      String locationName,
      double lng,
      String mile,
      String type,
  ) async {
    return await repository.sendRouteRecord(idCompany, idEmp, isCheckIn, lat, locationName, lng, mile, type);
  }
}
