import 'package:equatable/equatable.dart';

class ManagerLeave extends Equatable{
  final int? idEmployees;
  final String? firstnameTh;
  final String? lastnameTh;
  // final String? idPosition;
  final int? idPosition;
  final String? positionName;
  final int? idRole;
  final String? email;

  ManagerLeave({
    this.idEmployees,
    this.firstnameTh,
    this.lastnameTh,
    this.idPosition,
    this.positionName,
    this.idRole,
    this.email,
  });

  @override
  List<Object?> get props => [
    idEmployees,
    firstnameTh,
    lastnameTh,
    idPosition,
    positionName,
    idRole,
    email,
  ];

}
