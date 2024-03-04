import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:unihr/src/core/error/exception.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/failures.dart';
import '../../../../user/timeline/domain/entities/timeline_entity.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/working_time_repository.dart';
import '../data_sources/remote/working_time_remote_datasource.dart';

class WorkingTimeRepositoryImpl implements WorkingTimeRepository{

  final WorkingTimeRemoteDataSource remoteDataSource;

  WorkingTimeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<EmployeesEntity>>> getEmployees() async{
    try{
      final data = await remoteDataSource.getEmployees();
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
  Future<Either<ErrorMessage, List<EmployeesAttendanceEntity>>> getEmployeesAttendance(String start) async{
    try{
      final data = await remoteDataSource.getEmployeesAttendance(start);
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
  Future<Either<ErrorMessage, List<EmployeesLeaveEntity>>> getEmployeesLeave(String start) async{
    try{
      final data = await remoteDataSource.getEmployeesLeave(start);
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
  Future<Either<ErrorMessage, List<PayrollSettingEntity>>> getPayrollSetting() async{
    try{
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
  Future<Either<ErrorMessage, List<TimeLineEntity>>> getAttendanceEmpDate(int id, String start, String end) async{
    try{
      final data = await remoteDataSource.getAttendanceEmpDate(id, start, end);
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
  Future<Either<ErrorMessage, List<ReasonEntity>>> getReasonManager() async {
    try {
      final data = await remoteDataSource.getReasonManager();
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

  // @override
  // Future<Either<ErrorMessage, void>> sendTimeRequestManager(CalculateTimeEntity result, int idEmployee, int idRequestType, String requestReason, String otherReason, DateTime start, DateTime end, DateTime workEndDate, EmployeesEntity profileData) async{
  //   try {
  //     final data = await remoteDataSource.sendTimeRequestManager(
  //         result,
  //         idEmployee,
  //         idRequestType,
  //         requestReason,
  //         otherReason,
  //         start,
  //         end,
  //         workEndDate,
  //         profileData
  //     );
  //     return Right(data);
  //   } on ErrorException {
  //     return Left(ErrorMessage());
  //   }
  // }
}