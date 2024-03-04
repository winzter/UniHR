import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';

abstract class EmployeeNetworkRemoteDataSource {
  Future<List<EmployeeNetworkModel>> getEmployeeNetworkData();
  Future<EachEmployeeNetworkModel> getEachEmployeeData(int idEmp);
}

class EmployeeNetworkRemoteDataSourceImpl implements EmployeeNetworkRemoteDataSource{

  final Dio dio;

  EmployeeNetworkRemoteDataSourceImpl({required this.dio});
  @override
  Future<EachEmployeeNetworkModel> getEachEmployeeData(int idEmp) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/employeesNetwork/$idEmp',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return eachEmployeeNetworkModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

  @override
  Future<List<EmployeeNetworkModel>> getEmployeeNetworkData() async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/employees',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    if (response.statusCode == 200) {
      return employeeNetworkModelFromJson(jsonEncode(response.data));
    } else {
      throw ErrorException(message: "Server error occurred");
    }
  }

}