import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/working_record_repository.dart';


class SendWorkingRecord {
  final WorkingRecordRepository repository;
  SendWorkingRecord({required this.repository});

  Future<Either<ErrorMessage, void>> call(String? description,int idCompany,int idEmp,bool isCheckIn,double lat,double lng,String locationName  ) async {
    return await repository.sendWorkingRecord(description, idCompany, idEmp, isCheckIn, lat, lng, locationName);
  }
}