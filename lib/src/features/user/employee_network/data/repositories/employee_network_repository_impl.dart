import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/employee_network/data/data_sources/remote/employee_network_remote_datasources.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/employee_network_repository.dart';

class EmployeeNetworkRepositoryImpl implements EmployeeNetworkRepository{

  final EmployeeNetworkRemoteDataSource remoteDataSource;

  EmployeeNetworkRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<ErrorMessage, EachEmployeeEntity>> getEachEmployeeData(int idEmp) async{
    try {
      final data = await remoteDataSource.getEachEmployeeData(idEmp);
      return Right(data);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }

  @override
  Future<Either<ErrorMessage, List<EmployeeNetworkEntity>>> getEmployeeNetworkData() async{
    try {
      final data = await remoteDataSource.getEmployeeNetworkData();
      return Right(data);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }

}