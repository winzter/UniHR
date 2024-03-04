import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../error/exception.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/remote/login_api.dart';


class LoginRepositoryImpl implements LoginRepository{
  final LoginApi loginApi;
  LoginRepositoryImpl({required this.loginApi});
  @override
  Future<Either<ErrorMessage, LoginEntity>> login(String username, String password,String deviceId) async{
    try{
      final data = await loginApi.login(username, password,deviceId);
      return Right(data);
    } on ErrorException{
      return Left(ErrorMessage());
    }
  }
  
}