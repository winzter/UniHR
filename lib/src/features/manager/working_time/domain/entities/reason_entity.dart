import 'package:equatable/equatable.dart';

class ReasonEntity extends Equatable{
  final int? idRequestReason;
  final String? name;
  final int? idCompany;
  final int? isPayShift;
  final int? index;

  const ReasonEntity({
    this.idRequestReason,
    this.name,
    this.idCompany,
    this.isPayShift,
    this.index,
  });


  @override
  List<Object?> get props => [
    idRequestReason,
    name,
    idCompany,
    isPayShift,
    index,
  ];
}