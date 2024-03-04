import 'package:equatable/equatable.dart';

class IsCheckInEntity extends Equatable{
  final String? idEmployees;
  final int? checkIn;
  final String? type;

  IsCheckInEntity({
    this.idEmployees,
    this.checkIn,
    this.type,
  });

  @override
  List<Object?> get props => [
    idEmployees,
    checkIn,
    type,
  ];

}
