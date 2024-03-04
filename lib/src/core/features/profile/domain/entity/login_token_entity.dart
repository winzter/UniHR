import 'package:equatable/equatable.dart';

class UserTokenEntity extends Equatable{
  final int? id;
  final String? username;
  final List<String>? roles;
  final String? accessToken;

  const UserTokenEntity({
    this.id,
    this.username,
    this.roles,
    this.accessToken
  });

  @override
  List<Object?> get props => [];
}
