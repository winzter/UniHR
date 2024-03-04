import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/employee_network_repository.dart';

class GetEachEmployeeNetworkData{
  final EmployeeNetworkRepository repository;

  GetEachEmployeeNetworkData({required this.repository});

  Future<Either<ErrorMessage, EachEmployeeEntity>> call(int idEmp)async{
    return repository.getEachEmployeeData(idEmp);
  }
}