import 'dart:convert';
import 'package:unihr/src/core/constanst/network_api.dart';
import 'package:unihr/src/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../../storage/secure_storage.dart';
import '../../../domain/entities/login_entity.dart';
import '../../models/login_model.dart';


abstract class LoginApi{
  Future<LoginEntity> login(String username,String password,String deviceId);
}

class LoginApiImpl implements LoginApi{
  final http.Client client;
  LoginApiImpl({required this.client});

  @override
  Future<LoginEntity> login(username,password,deviceId) async{
    var url = Uri.parse("${NetworkAPI.baseURL}/api/auth/signin");
    Map tokenData;
    final res = await client.post(url,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Platform" : "NativeApp",
          "Device-Id" : deviceId
        },
        body: jsonEncode({
          "username":username,
          "password":password
        }));
    if(res.statusCode == 200){
      var data = loginFromJson(res.body);
      tokenData = JwtDecoder.decode(data.accessToken!);
      await LoginStorage.setMapData(
          tokenData['idRole'],
          tokenData['idEmployees'].toString(),
          tokenData['idCompany'],
          tokenData['iat'],
          tokenData['exp'],
      );
      await LoginStorage.setToken(data.accessToken!);
      return LoginEntity(
          roles: data.roles,
          accessToken: data.accessToken);
    }else{
      throw ErrorException(message: "Server error occurred");
    }
  }

}

