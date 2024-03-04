import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:unihr/src/features/manager/overview/data/data_sources/remote/overview_remote_data_source.dart';
import 'package:unihr/src/features/manager/overview/domain/repositories/overview_repository.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../models/cost_model.dart';
import '../models/models.dart';

class OverviewRepositoryImpl implements OverviewRepository{
  final OverviewRemoteDataSource remoteDataSource;

  OverviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<DepartmentModel>>> getDepartment() async{
    try {
      final List<DepartmentModel> data = await remoteDataSource.getDepartment();
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!} ${e.response!.statusMessage!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, OverviewModel>> getOverview(String month,String year,int? idDepartment,int? idSection) async{
    try {
      final  OverviewModel data = await remoteDataSource.getOverview(month, year,idDepartment,idSection);
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!} ${e.response!.statusMessage!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, OvertimeModel>> getOverTime(String month, String year, int? idDepartment, int? idSection) async{
    try {
      final  OvertimeModel data = await remoteDataSource.getOverTime(month, year,idDepartment,idSection);
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!} ${e.response!.statusMessage!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, WorkingTimeModel>> getWorkingTime(String month, String year, int? idDepartment, int? idSection) async{
    try {
      final  WorkingTimeModel data = await remoteDataSource.getWorkingTime(month, year,idDepartment,idSection);
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!} ${e.response!.statusMessage!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

  @override
  Future<Either<ErrorMessage, CostModel>> getCost(String month, String year, int? idDepartment, int? idSection) async{
    try {
      final  CostModel data = await remoteDataSource.getCost(month, year,idDepartment,idSection);
      return Right(data);
    } on ErrorException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: e.message));
    } on TypeError catch (e){
      ErrorText.logger.e("$e");
      return Left(ErrorMessage(errMsgText: ErrorText.typeError));
    } on DioException catch (e){
      ErrorText.logger.e("Status Code : ${e.response!.statusCode!}");
      return Left(ErrorMessage(errMsgText: "Status Code : ${e.response!.statusCode!} ${e.response!.statusMessage!}"));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }

}