import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';

abstract class EmployeesListRemoteDataSource{
  Future<List<EmployeesListModel>> getEmployeesList();
  Future<EachEmployeeModel> getEachEmployee(int idEmp);
}

class EmployeesListRemoteDataSourceImpl implements EmployeesListRemoteDataSource{

  final Dio dio;

  EmployeesListRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<EmployeesListModel>> getEmployeesList() async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/employees',
        queryParameters: {"filter":'manager'},
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return employeesListModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<EachEmployeeModel> getEachEmployee(int idEmp) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/employees/profile/$idEmp',
        queryParameters: {"filter":'admin'},
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return eachEmployeeModelFromJson(jsonEncode(response.data));
  }

}