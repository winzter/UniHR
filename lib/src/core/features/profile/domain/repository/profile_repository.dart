import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entity/profile_entity.dart';

abstract class ProfileRepository{
  Future<Either<ErrorMessage , ProfileEntity>> getProfile();
}