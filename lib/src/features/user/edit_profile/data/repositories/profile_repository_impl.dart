import 'package:dartz/dartz.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../data_sources/remote/edit_profile_remote_data_source.dart';

class EditProfileRepositoryImpl implements EditProfileRepository{

  final EditProfileRemoteDataSourceImpl chRemoteDataSource;

  EditProfileRepositoryImpl({required this.chRemoteDataSource});

  @override
  Future<Either<ErrorMessage, void>> sendEditAddress(
      String zipcode,
      String district,
      String province,
      String alley,
      String houseNo,
      String road,
      String subDistrict,
      String village,
      String villageNo
      ) async{
    try {
      await chRemoteDataSource.sendEditAddress(
          zipcode,
          district,
          province,
          alley,
          houseNo,
          road,
          subDistrict,
          village,
          villageNo);
      return const Right(null);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }

  @override
  Future<Either<ErrorMessage, void>> sendEditEmergencyContract(String emergencyName,String phoneNum,String emergencyRelationship) async{
    try {
      await chRemoteDataSource.sendEditEmergencyContract(emergencyName, phoneNum, emergencyRelationship);
      return const Right(null);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }

  @override
  Future<Either<ErrorMessage, void>> changePassword(String oldPass,String newPass,String confirm) async{
    try {
      await chRemoteDataSource.changePassword(oldPass, newPass, confirm);
      return const Right(null);
    } on ErrorException {
      return Left(ErrorMessage(errMsgText: "รหัสผ่านปัจจุบัน ไม่ถูกต้อง"));
    }
  }

  @override
  Future<Either<ErrorMessage, void>> sendEditPhoneNumber(String phoneNum) async{
    try {
      await chRemoteDataSource.sendEditPhoneNumber(phoneNum);
      return const Right(null);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }

  @override
  Future<Either<ErrorMessage, void>> userLogOut() {
    // TODO: implement userLogOut
    throw UnimplementedError();
  }

}