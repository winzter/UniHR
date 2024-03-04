import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

class GetProfile{
  final ProfileRepository repository;
  GetProfile({required this.repository});

  Future<Either<ErrorMessage, ProfileEntity>> call() async {
    return await repository.getProfile();
  }
}