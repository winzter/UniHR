import 'package:http/http.dart' as http;
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';
import '../../models/shift_ot_model.dart';

abstract class ShiftAndOTRemoteDataSource {
  Future<ShiftAndOtModel> getShiftAndOT(String start,String end);
}

class ShiftAndOTRemoteDataSourceImpl implements ShiftAndOTRemoteDataSource{
  final http.Client client;

  ShiftAndOTRemoteDataSourceImpl({required this.client});

  @override
  Future<ShiftAndOtModel> getShiftAndOT(String start,String end) async{
    try{
      final response = await client.get(
        Uri.parse(
            "${NetworkAPI.baseURL}/api/summary-time?start=$start&end=$end"),
        headers: {'x-access-token': '${await LoginStorage.readToken()}'},
      );

      if (response.statusCode == 200) {
        return shiftAndOtModelFromJson(response.body);
      } else {
        throw ErrorException(message: 'Server Error : ${response.statusCode}');
      }
    }on ErrorException{
      throw ErrorException(message: "Server error occurred");
    }
    on http.ClientException{
      throw http.ClientException("No internet connection");
    } on TypeError{
      throw TypeError();
    }

  }

}