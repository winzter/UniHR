import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/cost_model.dart';
import '../../models/models.dart';

abstract class OverviewRemoteDataSource {
  Future<OverviewModel> getOverview(String month,String year, int? idDepartment, int? idSection);
  Future<OvertimeModel> getOverTime(String month,String year, int? idDepartment, int? idSection);
  Future<WorkingTimeModel> getWorkingTime(String month,String year, int? idDepartment, int? idSection);
  Future<CostModel> getCost(String month,String year, int? idDepartment, int? idSection);
  Future<List<DepartmentModel>> getDepartment();
}

class OverviewRemoteDataSourceImpl implements OverviewRemoteDataSource{

  final Dio dio;

  OverviewRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<DepartmentModel>> getDepartment() async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/departments?includes[]=section',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return departmentModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<OverviewModel> getOverview(String month, String year,int? idDepartment,int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/overview',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return overviewModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<OvertimeModel> getOverTime(String month, String year, int? idDepartment, int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/overtime',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return overtimeModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<WorkingTimeModel> getWorkingTime(String month, String year, int? idDepartment, int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/workingtime',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return workingTimeModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<CostModel> getCost(String month, String year, int? idDepartment, int? idSection) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/dashboard/cost',
        queryParameters: {
          'mode':'manager',
          'month': month,
          'year': year,
          if(idDepartment != null && idDepartment != 999)
            'idDepartment':idDepartment,
          if(idSection != null && idSection != 999)
            'idSection':idSection
        },
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return costModelFromJson(jsonEncode(response.data));
  }
}