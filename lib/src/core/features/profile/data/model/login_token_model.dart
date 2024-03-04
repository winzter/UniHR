import 'dart:convert';
import '../../domain/entity/login_token_entity.dart';

UserTokenModel userTokenFromJson(String str) => UserTokenModel.fromJson(json.decode(str));

String userTokenToJson(UserTokenModel data) => json.encode(data.toJson());

class UserTokenModel extends UserTokenEntity{

  const UserTokenModel({
    required int? id,
    required String? username,
    required List<String>? roles,
    required String? accessToken,
  }):super(
    id: id,
    username: username,
    roles: roles,
    accessToken: accessToken
  );

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => UserTokenModel(
    id: json["id"],
    username: json["username"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "accessToken": accessToken,
  };
}
