import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/edit_profile_repository.dart';

class UserLogOut{
  final EditProfileRepository repository;

  UserLogOut(this.repository);

  Future<Either<ErrorMessage, void>> call() async {
    return await repository.userLogOut();
  }
}