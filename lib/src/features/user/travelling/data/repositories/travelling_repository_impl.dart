import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/travelling/domain/entities/is_checkin_entity.dart';
import 'package:unihr/src/features/user/travelling/domain/entities/travelling_time_line_entity.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/repositories/travelling_repostiory.dart';
import '../data_sources/remote/travelling_remote_data_source.dart';

class TravellingRepositoryImpl implements TravellingRepository {
  final TravellingRemoteDataSource remoteDataSource;

  TravellingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<TravellingTimeLineEntity>>> getTimelineById(
      DateTime date, int idEmp) async {
    try {
      var data = await remoteDataSource.getTimelineById(
        date,
        idEmp,
      );
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, void>> sendRouteRecord(
      int idCompany,
      int idEmp,
      bool isCheckIn,
      double lat,
      String locationName,
      double lng,
      String mile,
      String type) async{
    try {
      var data = await remoteDataSource.sendRouteRecord(
        idCompany,
        idEmp,
        isCheckIn,
        lat,
        locationName,
        lng,
        mile,
        type,
      );
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, IsCheckInEntity>> isCheckIn(int idEmp) async{
    try {
      var data = await remoteDataSource.isCheckIn(
        idEmp,
      );
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }
}
