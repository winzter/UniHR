import 'package:equatable/equatable.dart';

class LeaveSettingEntity extends Equatable{
  final int? idLeaveSetting;
  final int? idCompany;
  final int? resetEndOfMonth;

  LeaveSettingEntity({
    this.idLeaveSetting,
    this.idCompany,
    this.resetEndOfMonth,
  });

  @override
  List<Object?> get props => [idLeaveSetting,idCompany,resetEndOfMonth];

}
