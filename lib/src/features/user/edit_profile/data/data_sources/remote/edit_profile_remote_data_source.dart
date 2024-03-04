import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../../../../../core/constanst/network_api.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/storage/secure_storage.dart';

abstract class EditProfileRemoteDataSource{
  Future<void> sendEditAddress(
      String zipcode,
      String district,
      String province,
      String alley,
      String houseNo,
      String road,
      String subDistrict,
      String village,
      String villageNo);
  Future<void> sendEditPhoneNumber(String phoneNum);
  Future<void> changePassword(String oldPass,String newPass,String confirm);
  Future<void> sendEditEmergencyContract(
      String emergencyName,String phoneNum,String emergencyRelationship);
  Future<void> userLogOut();
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource{
  final http.Client client;

  EditProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<void> sendEditAddress(
      String zipcode,
      String district,
      String province,
      String alley,
      String houseNo,
      String road,
      String subDistrict,
      String village,
      String villageNo
      ) async{
    try {
      String idEmp = await LoginStorage.readEmployeeId();
      Map<String,dynamic> data = {
        "address": null,
        "alley" : alley,
        "areaCode": zipcode,
        "district": district,
        "houseNo": houseNo,
        "idEmployees": idEmp,
        "provience": province,
        "road": road,
        "subDistrict": subDistrict,
        "village": village,
        "villageNo": villageNo
      };
      var url = Uri.parse("${NetworkAPI.baseURL}/api/employees");
      var res = await http.put(url, headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "x-access-token": "${await LoginStorage.readToken()}"
      }, body: jsonEncode(data));
      log("${res.statusCode}");
      if (res.statusCode == 200) {
        // userData.setAddress(address, district, province, zipcode);
      }
    } catch (e) {
      Logger().e("EditAddress sendEditData Error : $e");
    }
  }

  @override
  Future<void> sendEditEmergencyContract(
      String emergencyName,String phoneNum,String emergencyRelationship) async{
    try {
      var idEmp = await LoginStorage.readEmployeeId();
      Map data = {
        "emergencyContact": emergencyName,
        "emergencyPhone": phoneNum,
        "emergencyRelationship":emergencyRelationship,
        "idEmployees":idEmp
      };
      var url = Uri.parse(
          "${NetworkAPI.baseURL}/api/employees");
      var res = await http.put(url, headers: {
      "Content-Type": "application/json;charset=UTF-8",
      "x-access-token": "${await LoginStorage.readToken()}"
      },body: jsonEncode(data));
      if (res.statusCode == 200) {
        // userData.setEmergency(emergencyName, emergencyRelationship, phoneNum);
      }
    } catch (e) {
      Logger().e("EditEmergency sendEditData Error : $e");
    }
  }

  @override
  Future<void> sendEditPhoneNumber(String phoneNum) async{
    try {
      var idEmp = await LoginStorage.readEmployeeId();
      Map data = {
        "idEmployees": idEmp,
        "telephoneMobile": phoneNum
      };
      var url = Uri.parse(
          "${NetworkAPI.baseURL}/api/employees");
      var res = await http.put(url, headers: {
      "Content-Type": "application/json;charset=UTF-8",
      "x-access-token": "${await LoginStorage.readToken()}"
      },body: jsonEncode(data));
      if (res.statusCode == 200) {
        // userData.setPhoneNum(phoneNum);
      }
    } catch (e) {
      Logger().e("EditProfile sendEditData Error : $e");
    }
  }

  @override
  Future<void> userLogOut() {
    // TODO: implement userLogOut
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(String oldPass, String newPass, String confirm) async{
    Map data = {
      "confirm": confirm,
      "new": newPass,
      "old":oldPass
    };
    var url = Uri.parse("${NetworkAPI.baseURL}/api/change-password");
    var res = await http.post(url, headers: {
      "Content-Type": "application/json;charset=UTF-8",
      "x-access-token": "${await LoginStorage.readToken()}"
    },body: jsonEncode(data));
    if (res.statusCode == 200) {
      log("Change Password Success");
    }else if(res.statusCode == 500){
      Logger().e("รหัสผ่านปัจจุบัน ไม่ถูกต้อง");
      throw ErrorException(message: "รหัสผ่านปัจจุบัน ไม่ถูกต้อง");
    }
  }

}