import 'dart:convert';
import '../../domain/entities/login_entity.dart';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel extends LoginEntity{
  LoginModel({
    required List<String>? roles,
    required String? accessToken}) :
        super(
          roles: roles,
          accessToken: accessToken);

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "accessToken": accessToken,
  };

}