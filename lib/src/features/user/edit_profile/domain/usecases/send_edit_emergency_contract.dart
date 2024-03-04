import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';

class SendEditEmergencyContract{
  final EditProfileRepository repository;

  SendEditEmergencyContract(this.repository);
  Future<Either<ErrorMessage, void>> call(String emergencyName,String phoneNum,String emergencyRelationship) async {
    return await repository.sendEditEmergencyContract(emergencyName,phoneNum,emergencyRelationship);
  }
}