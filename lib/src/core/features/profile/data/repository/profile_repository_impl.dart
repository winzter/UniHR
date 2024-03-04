import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:unihr/src/core/constanst/errorText.dart';
import '../../../../error/exception.dart';
import '../../../../error/failures.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../datasource/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository{

  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, ProfileEntity>> getProfile() async{
    try {
      final data = await remoteDataSource.getProfile();
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on ClientException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.clientError));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }
}