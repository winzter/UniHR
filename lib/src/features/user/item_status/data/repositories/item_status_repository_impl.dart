import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/item_status_repository.dart';
import '../data_sources/remote/item_status_remote_datasource.dart';
import '../models/models.dart';

class ItemStatusRepositoryImpl implements ItemStatusRepository{

  final ItemStatusRemoteDataSource remoteDataSource;

  ItemStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, void>> deleteItem({LeaveEntity? dataLeave, RequestTimeEntity? dataRequestTime}) async{
    try {
      if (dataLeave == null) {
        await remoteDataSource.deleteItem(
            dataRequestTime: dataRequestTime as RequestTimeModel);
      } else {
        await remoteDataSource.deleteItem(dataLeave: dataLeave as LeaveModel);
      }
      return const Right(null);
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

  @override
  Future<Either<ErrorMessage, List<LeaveEntity>>> getLeave(String startDate, String endDate) async{
    try {
      final data = await remoteDataSource.getLeave(startDate, endDate);
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

  @override
  Future<Either<ErrorMessage, PayrollSettingModel>> getPayrollSetting() async{
    try {
      final data = await remoteDataSource.getPayrollSetting();
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

  @override
  Future<Either<ErrorMessage, List<RequestTimeEntity>>> getRequestTime(String startDate, String endDate) async{
    try {
      final data = await remoteDataSource.getRequestTime(startDate, endDate);
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

  @override
  Future<Either<ErrorMessage, List<WithdrawEntity>>> getWithdraw(String startDate, String endDate) async{
    try {
      final data = await remoteDataSource.getWithdraw(startDate, endDate);
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

  @override
  String isFullDay(DateTime start, DateTime end) {
    if (DateFormat('HH:mm').format(start) == "00:00" &&
        DateFormat('HH:mm').format(end) == "00:00") {
      return "     เต็มวัน";
    } else {
      return "${DateFormat('HH:mm').format(start)} - ${DateFormat('HH:mm').format(end)}";
    }
  }

  @override
  int numIsNotApprove(List<RequestTimeEntity> requestData, List<LeaveEntity> leaveData) {
    int waitApprove = 0;
    for (var data in requestData) {
      if (data.isDoubleApproval == 0) {
        if (data.isManagerLv1Approve == null && data.isWithdraw == null) {
          waitApprove++;
        }
      } else {
        if (data.isManagerLv2Approve == null && data.isWithdraw == null) {
          waitApprove++;
        }
      }
    }
    for (var data in leaveData) {
      if (data.isApprove == null && data.isWithdraw == null) {
        waitApprove++;
      }
    }
    return waitApprove;
  }
  
}