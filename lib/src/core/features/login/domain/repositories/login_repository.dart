import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<ErrorMessage, LoginEntity>> login(String username ,String password,String deviceId);
}