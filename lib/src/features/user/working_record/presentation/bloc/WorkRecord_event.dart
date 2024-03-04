part of 'WorkRecord_bloc.dart';

abstract class WorkRecordEvent extends Equatable {
  const WorkRecordEvent();
}

class GetCurrentAddress extends WorkRecordEvent {
  final bool isCheck;
  final double lat;
  final double lng;

  GetCurrentAddress(
      {required this.lat, required this.lng, required this.isCheck});

  @override
  List<Object?> get props => [lat, lng, isCheck];
}

class GetIsCheckIn extends WorkRecordEvent {
  final int idEmp;

  GetIsCheckIn({required this.idEmp});

  @override
  List<Object?> get props => [idEmp];
}
class SendWorkingRecordData extends WorkRecordEvent {
  final int idEmp;
  final int idCompany;

  final String? description;
  final BuildContext context;

  SendWorkingRecordData({
    required this.idEmp,
    required this.idCompany,
    required this.description,
    required this.context,
  });

  @override
  List<Object?> get props => [
        idEmp,
        idCompany,
        description,
        context,
      ];
}
