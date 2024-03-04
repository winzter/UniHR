part of 'WorkRecord_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class WorkRecordState extends Equatable {
  final bool isCheck;
  final List<Placemark>? address;

  final FetchStatus status;

  final String location;
  final IsCheckInEntity? isCheckInData;
  final bool isError;
  final double? lat;
  final double? lng;
  final ErrorMessage? error;

  WorkRecordState({
    this.isCheck = false,
    this.address,
    this.lat,
    this.lng,
    this.location = "",
    this.isError = false,
    this.status = FetchStatus.init,
    this.isCheckInData,
    this.error,
  });

  WorkRecordState copyWith({
    required List<Placemark> address,
    required bool isError,
    String? location,
    bool? isCheck,
    double? lat,
    ErrorMessage? error,
    double? lng,
    IsCheckInEntity? isCheckInData,
    FetchStatus? status,
  }) {
    return WorkRecordState(
        address: address,
        isCheck: isCheck ?? this.isCheck,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        error: error??this.error,
        isError: isError,
        status: status ?? this.status,
        isCheckInData: isCheckInData ?? this.isCheckInData,
        location: address.isNotEmpty?"${address.reversed.last.name ?? ''} ${address.reversed.last.street ?? ''} ${address.reversed.last.subLocality ?? ''} ${address.reversed.last.locality ?? ''} ${address.reversed.last.postalCode ?? ''} ${address.reversed.last.country ?? ''}":"",);
            // "${address.reversed.last.name ?? ''} ${address.reversed.last.street ?? ''} ${address.reversed.last.subLocality ?? ''} "
            // "${address.reversed.last.locality ?? ''} ${address.reversed.last.postalCode ?? ''} ${address.reversed.last.country ?? ''}");
  }

  @override
  List<Object> get props => [isCheck, status];
}

final class LocationInitial extends WorkRecordState {}
