import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:unihr/src/core/error/exception.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../domain/repositories/working_record_repository.dart';
import '../data_sources/remote/working_record_remote_datasource.dart';
import '../models/is_checkin_model.dart';

class WorkingRecordRepositoryImpl implements WorkingRecordRepository {
  final WorkingRecordRemoteDataSource remoteDataSource;

  WorkingRecordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, void>> sendWorkingRecord(
    String? description,
    int idCompany,
    int idEmp,
    bool isCheckIn,
    double lat,
    double lng,
    String locationName,
  ) async {
    try {
      await remoteDataSource.sendWorkingRecord(
        description,
        idCompany,
        idEmp,
        isCheckIn,
        lat,
        lng,
        locationName,
      );
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
  Future<Either<ErrorMessage, IsCheckInModel>> isCheckInWorkRecord(int idEmp) async{
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
    } on ClientException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.clientError));
    } on FormatException catch (e){
      ErrorText.logger.e("${e.message}");
      return Left(ErrorMessage(errMsgText: ErrorText.formatError));
    }
  }
}
