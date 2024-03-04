import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';

class ChangePassword{
  final EditProfileRepository chRepository;
  ChangePassword({required this.chRepository});

  Future<Either<ErrorMessage, void>> call(String oldPass,String newPass,String confirm) async {
    return await chRepository.changePassword(oldPass,newPass,confirm);
  }
}
