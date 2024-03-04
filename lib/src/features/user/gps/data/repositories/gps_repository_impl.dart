import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:unihr/src/core/error/exception.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../domain/repositories/gps_repository.dart';
import '../data_sources/remote/gps_remote_data_source.dart';
import '../models/beacons_model.dart';
import '../models/location_model.dart';

class GpsRepositoryImpl implements GpsRepository {
  final GpsRemoteDatasource remoteDatasource;

  GpsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<ErrorMessage, LineCheckInModel>> getLocation(int idEmp) async {
    try {
      final data = await remoteDatasource.getLocation(idEmp);
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
  Future<Either<ErrorMessage, void>> sentLocation(
    String attendanceDateTime,
    int isCheckIn,
    int idAttendanceType,
    int idGpsLocation,
    String idEmployee,
    String idCompany,
    String? address,
    double? lat,
    double? lng,
  ) async {
    try {
      await remoteDatasource.sendLocation(
        attendanceDateTime,
        isCheckIn,
        idAttendanceType,
        idGpsLocation,
        idEmployee,
        idCompany,
        address,
        lat,
        lng,
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
  Future<Either<ErrorMessage, List<BeaconsModel>>> getBeacons() async{
    try {
      final data = await remoteDatasource.getBeacons();
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
