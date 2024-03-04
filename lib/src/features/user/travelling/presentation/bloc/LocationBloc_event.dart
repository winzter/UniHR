part of 'LocationBloc_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

class GetCurrentAddress extends GpsEvent {
  final double lat;
  final double lng;
  final int idEmp;
  final DateTime now;

  GetCurrentAddress({
    required this.lat,
    required this.lng,
    required this.now,
    required this.idEmp,
  });

  @override
  List<Object?> get props => [lat, lng, now, idEmp];
}

class GetTimeLineDataById extends GpsEvent {
  final int idEmp;
  final DateTime date;

  GetTimeLineDataById({required this.idEmp, required this.date});

  @override
  List<Object?> get props => [idEmp, date];
}

class GetIsCheckIn extends GpsEvent {
  final int idEmp;
  final DateTime now;

  GetIsCheckIn({
    required this.idEmp,
    required this.now,
  });

  @override
  List<Object?> get props => [idEmp, now];
}

class SendRouteRecordData extends GpsEvent {
  final int idEmp;
  final int idCompany;

  final BuildContext context;
  final DateTime date;

  final bool isCheckIn;
  final double lat;
  final double lng;

  final String mile;
  final String type;

  final String location;

  SendRouteRecordData({
    required this.idEmp,
    required this.date,
    required this.lat,
    required this.lng,
    required this.isCheckIn,
    required this.mile,
    required this.type,
    required this.context,
    required this.idCompany,
    required this.location,
  });

  @override
  List<Object?> get props => [
        idEmp,
        date,
        isCheckIn,
        mile,
        type,
        context,
        idCompany,
        location,
        lng,
        lat,
      ];
}
