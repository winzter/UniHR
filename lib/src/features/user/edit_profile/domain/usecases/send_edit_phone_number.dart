import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';

class SendEditPhoneNumber{
  final EditProfileRepository repository;
  SendEditPhoneNumber(this.repository);

  Future<Either<ErrorMessage, void>> call(String phoneNum) async {
    return await repository.sendEditPhoneNumber(phoneNum);
  }
}
