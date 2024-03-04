part of 'LocationBloc_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class LocationState extends Equatable {
  final bool isSetLocation;
  final IsCheckInEntity? isCheckInData;
  final double lat;
  final double lng;

  final ErrorMessage? error;

  final List<TravellingTimeLineEntity> timeLineData;
  final List<Placemark>? address;

  final FetchStatus status;

  final String location;

  LocationState({
    this.isSetLocation = false,
    this.address,
    this.timeLineData = const [],
    this.location = "",
    this.status = FetchStatus.init,
    this.lat = 0,
    this.lng = 0,
    this.isCheckInData,
    this.error,
  });

  LocationState copyWith({
    bool? isSetLocation,
    List<TravellingTimeLineEntity>? timeLineData,
    List<Placemark>? address,
    String? location,
    FetchStatus? status,
    double? lat,
    double? lng,
    IsCheckInEntity? isCheckInData,
    ErrorMessage? error,
  }) {
    return LocationState(
      isSetLocation: isSetLocation ?? false,
      address: address ?? this.address,
      timeLineData: timeLineData ?? this.timeLineData,
      status: status ?? this.status,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      location: location ?? this.location,
      isCheckInData: isCheckInData ?? this.isCheckInData,
      error: error??this.error,
    );
    // "${address.reversed.last.name ?? ''} ${address.reversed.last.street ?? ''} ${address.reversed.last.subLocality ?? ''} "
    // "${address.reversed.last.locality ?? ''} ${address.reversed.last.postalCode ?? ''} ${address.reversed.last.country ?? ''}");
  }

  @override
  List<Object> get props => [
        isSetLocation,
        timeLineData,
        status,
        lat,
        lng,
      ];
}

final class LocationInitial extends LocationState {}
