import 'package:equatable/equatable.dart';

class BeaconsEntity extends Equatable{
  final int? idBeacon;
  final String? name;
  final String? macAddress;
  final int? idCompany;

  BeaconsEntity({
    this.idBeacon,
    this.name,
    this.macAddress,
    this.idCompany,
  });

  @override
  List<Object?> get props => [
    idBeacon,
    name,
    macAddress,
    idCompany,
  ];

}
