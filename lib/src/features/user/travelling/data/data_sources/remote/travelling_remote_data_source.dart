import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/models.dart';

abstract class TravellingRemoteDataSource {
  Future<List<TravellingTimeLineModel>> getTimelineById(
      DateTime date,
      int idEmp,
      );

  Future<IsCheckInModel> isCheckIn(
      int idEmp,
      );

  Future<void> sendRouteRecord(
      int idCompany,
      int idEmp,
      bool isCheckIn,
      double lat,
      String locationName,
      double lng,
      String mile,
      String type,
      );
}

class TravellingRemoteDataSourceImpl implements TravellingRemoteDataSource{

  final Dio dio;

  TravellingRemoteDataSourceImpl({required this.dio});
  @override
  Future<List<TravellingTimeLineModel>> getTimelineById(DateTime date, int idEmp) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/getTimelineById/area/$idEmp',
        queryParameters: {'date': DateFormat("yyyy-MM-dd").format(date)},
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return travellingTimeLineModelFromJson(jsonEncode(response.data));
  }

  @override
  Future<void> sendRouteRecord(int idCompany, int idEmp, bool isCheckIn, double lat, String locationName, double lng, String mile, String type) async{
    final Response response = await dio.post('${NetworkAPI.baseURL}/api/addTimeline/',
        data: jsonEncode({
          'attendanceDateTime':DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          'idCompany':idCompany,
          'idEmployees':idEmp,
          'isCheckIn':isCheckIn,
          'latitude':lat,
          'locationName':locationName,
          'longitude':lng,
          'mile':mile,
          'type':type,
        }),
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}',
            "Content-Type": "application/json;charset=UTF-8",},
        ));
    if (response.statusCode == 200) {
      log("Send TravelLocation Success");
    } else {
      throw ErrorException(message: "Server Error Status : ${response.statusCode}");
    }
  }

  @override
  Future<IsCheckInModel> isCheckIn(int idEmp) async{
    final Response response = await dio.get('${NetworkAPI.baseURL}/api/getCheckTimelineById/area/$idEmp',
        options: Options(
          headers: {'X-Access-Token': '${await LoginStorage.readToken()}'},
        ));
    return isCheckInModelFromJson(jsonEncode(response.data));
  }

}