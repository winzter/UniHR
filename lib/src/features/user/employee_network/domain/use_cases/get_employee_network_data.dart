import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/employee_network_entity.dart';
import '../repositories/employee_network_repository.dart';

class GetEmployeeNetworkData{
  final EmployeeNetworkRepository repository;
  GetEmployeeNetworkData({required this.repository});

  Future<Either<ErrorMessage, List<EmployeeNetworkEntity>>> call() async{
    return repository.getEmployeeNetworkData();
  }
}