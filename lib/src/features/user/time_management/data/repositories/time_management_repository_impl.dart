import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/shift_change.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/time_management_remote_data_source.dart';
import 'package:unihr/src/features/user/time_management/domain/repositories/time_management_repository.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../models/models.dart';

class TimeManagementRepositoryImpl implements TimeManagementRepository{

  final TimeManagementRemoteDataSource remoteDataSource;

  TimeManagementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<ShiftModel>>> getShift() async{
    try {
      final List<ShiftModel> data = await remoteDataSource.getShift();
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
  Future<Either<ErrorMessage, List<TimeScheduleModel>>> getTimeSchedule(String startDate) async{
    try {
      final List<TimeScheduleModel> data = await remoteDataSource.getTimeSchedule(startDate);
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
  Future<Either<ErrorMessage, List<HolidayModel>>> getHoliday() async{
    try {
      final List<HolidayModel> data = await remoteDataSource.getHoliday();
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
  Future<Either<ErrorMessage, void>> sendChangeTime(ShiftChange data) async{
    try {
      final res = await remoteDataSource.sendShiftChange(data);
      return Right(res);
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
  Future<Either<ErrorMessage, void>> withdrawChangTime(int idEmployeeShiftDaily, int idEmployees) async{
    try {
      final res = await remoteDataSource.withDrawChangeTime(idEmployeeShiftDaily, idEmployees);
      return Right(res);
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
  Future<Either<ErrorMessage, List<CheckHolidayModel>>> getCheckHoliday(String startDate) async{
    try {
      final List<CheckHolidayModel> data = await remoteDataSource.getCheckHoliday(startDate);
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