import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/manager/employees_list/data/data_sources/remote/employees_remote_data_source.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/each_emp_entity.dart';
import '../../../../../core/constanst/errorText.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/repositories/employees_repository.dart';
import '../models/employees_model.dart';

class EmployeesListRepositoryImpl implements EmployeesListRepository{

  final EmployeesListRemoteDataSource remoteDataSource;

  EmployeesListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<EmployeesListModel>>> getEmployeesList() async{
    try {
      final List<EmployeesListModel> data = await remoteDataSource.getEmployeesList();
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
  Future<Either<ErrorMessage, EachEmployeeEntity>> getEachEmployee(int idEmp) async{
    try {
      final EachEmployeeEntity data = await remoteDataSource.getEachEmployee(idEmp);
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