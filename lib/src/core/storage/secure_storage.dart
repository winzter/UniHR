import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorage {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String myToken = 'userToken';
  static const String idRoles = "idRole";
  static const String employeeId = "idEmployees";
  static const String idCompany = "idCompany";
  static const String iat = "iat";
  static const String exp = "exp";


  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<bool> isLoggedIn() async {
    String? value = await secureStorage.read(key: isLoggedInKey);
    return value != null && value.toLowerCase() == 'true';
  }




  static Future<void> setMapData(int? idRoles,String? employeeId,
      int? idCompany, int? iat, int? exp) async {
    await secureStorage.write(key: 'idRoles', value: idRoles.toString());
    await secureStorage.write(key: 'idEmployees', value: employeeId.toString());
    await secureStorage.write(key: 'idCompany', value: idCompany.toString());
    await secureStorage.write(key: 'iat', value: iat.toString());
    await secureStorage.write(key: 'exp', value: exp.toString());
  }

  static Future readIdRoles() async {
    return await secureStorage.read(key: 'idRoles');
  }


  static Future readEmployeeId() async {
    return await secureStorage.read(key: 'idEmployees');
  }


  static Future readIdCompany() async {
    return await secureStorage.read(key: 'idCompany');
  }

  static Future readIat() async {
    return await secureStorage.read(key: 'iat');
  }

  static Future readExp() async {
    return await secureStorage.read(key: 'exp');
  }

  static Future<void> setLoggedIn(bool value) async {
    await secureStorage.write(key: isLoggedInKey, value: value.toString());
  }

  static Future setToken(String token) async {
    await secureStorage.write(key: "userToken", value: token);
  }

  static Future readToken() async {
    return await secureStorage.read(key: "userToken");
  }

  static Future deleteAll() async{
    return await secureStorage.deleteAll();
  }
}
