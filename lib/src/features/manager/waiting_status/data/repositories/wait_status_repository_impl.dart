import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../../../user/item_status/data/models/models.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/waiting_status_repository.dart';
import '../data_sources/remote/waiting_status_remote_datasource.dart';
import '../data_sources/send_data/change_time.dart';
import '../models/models.dart';

class WaitingStatusRepositoryImpl implements WaitingStatusRepository{

  final WaitingStatusRemoteDataSource remoteDataSource;

  WaitingStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<ChangeTimeManager>>> getChangeTimeManager() async{
    try {
      final List<ChangeTimeManagerModel> data = await remoteDataSource.getChangeTimeManager();
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
  Future<Either<ErrorMessage, List<LeaveRequestManager>>> getLeaveRequestManager({String? start , String? end}) async{
    try {
      final List<LeaveRequestManagerModel> data = await remoteDataSource.getLeaveRequestManager(start: start,end: end);
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
  Future<Either<ErrorMessage, List<RequestTimeManager>>> getRequestTimeManager({String? start , String? end}) async{
    try {
      final List<RequestTimeManagerModel> data = await remoteDataSource.getRequestTimeManager(start: start,end: end);
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
  Future<Either<ErrorMessage, List<WithdrawLeaveManager>>> getWithdrawLeaveManager({String? start , String? end}) async{
    try {
      final List<WithdrawLeaveManagerModel> data = await remoteDataSource.getWithdrawLeaveManager(start: start,end: end);
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
  Future<Either<ErrorMessage, void>> isChangeTimeManagerApprove(
      List<ChangeTimeSendData> sendTimeData
      ) async{
    try {
      final data = await remoteDataSource.isChangeTimeManagerApprove(sendTimeData);
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
  Future<Either<ErrorMessage, void>> isLeaveWithdrawApprove() {
    // TODO: implement isLeaveWithdrawApprove
    throw UnimplementedError();
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
  Future<Either<ErrorMessage, void>> isLeaveApprove(String commentManager, List<int> idLeave, int isApprove, List<int>? idLeaveEmployeesWithdraw) async{
    try {
      final data = await remoteDataSource.isLeaveApprove(commentManager, idLeave, isApprove, idLeaveEmployeesWithdraw);
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
  Future<Either<ErrorMessage, void>> isRequestTimeApprove(
      String commentManagerLV1,
      String commentManagerLV2,
      List<int> idRequestTimeLv1,
      int isManagerLV1Approve,
      int? isManagerLV2Approve,
      List<int> idRequestTimeLv2) async{
    try {
      final data = await remoteDataSource.isRequestTimeApprove(
          commentManagerLV1,
          commentManagerLV2,
          idRequestTimeLv1,
          isManagerLV1Approve,
          isManagerLV2Approve,
          idRequestTimeLv2);
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