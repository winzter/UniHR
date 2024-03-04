import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';

class SendEditAddress{
  final EditProfileRepository repository;
  SendEditAddress(this.repository);

  Future<Either<ErrorMessage, void>> call(
      String zipcode,
      String district,
      String province,
      String alley,
      String houseNo,
      String road,
      String subDistrict,
      String village,
      String villageNo) async {
    return await repository.sendEditAddress(
        zipcode,
        district,
        province,
        alley,
        houseNo,
        road,
        subDistrict,
        village,
        villageNo
    );
  }
}
