import 'package:equatable/equatable.dart';

class ReasonEntity extends Equatable {
  final int? idRequestReason;
  final String? name;
  final String? name_EN;
  final dynamic idCompany;
  final int? isPayShift;
  final int? index;
  final int? idRequestType;
  final int? isStandard;
  final String? startDate;
  final int? isActive;

  const ReasonEntity({
    this.idRequestReason,
    this.name,
    this.name_EN,
    this.idCompany,
    this.isPayShift,
    this.index,
    this.idRequestType,
    this.isStandard,
    this.startDate,
    this.isActive,
  });

  @override
  List<Object?> get props => [
        idRequestReason,
        name,
        name_EN,
        idCompany,
        isPayShift,
        index,
      ];
}
