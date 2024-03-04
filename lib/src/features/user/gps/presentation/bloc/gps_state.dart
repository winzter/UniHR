part of 'gps_bloc.dart';

enum FetchStatus { fetching, success, failed, init, selected }

class GpsState extends Equatable {
  final FetchStatus status;
  final Map<String,List<dynamic>> beacons;
  final LineCheckIn? locationData;
  final List<Placemark>? address;
  final bool isPoint;
  final int isGps;
  final int isBluetooth;
  final List<DropdownMenuItem<String>> dropDownData;
  final Map<int, List<Locations>> subLocations;
  final List<GroupGpsLocation> groupGpsLocations;
  final String? selectedLocation;
  final ErrorMessage? error;

  GpsState({
    this.status = FetchStatus.init,
    this.beacons = const {},
    this.locationData = null,
    this.dropDownData = const [],
    this.subLocations = const {},
    this.selectedLocation = null,
    this.error = null,
    this.groupGpsLocations = const [],
    this.address,
    this.isPoint = false,
    this.isGps = 0,
    this.isBluetooth = 0,
  });

  GpsState copyWith({
    LineCheckIn? locationData,
    FetchStatus? status,
    Map<String,List<dynamic>>? beacons,
    List<DropdownMenuItem<String>>? dropDownData,
    Map<int, List<Locations>>? subLocations,
    String? selectedLocation,
    ErrorMessage? error,
    List<GroupGpsLocation>? groupGpsLocations,
    List<Placemark>? address,
    bool? isPoint,
    String? foundDevice,
    List<BluetoothDevice>? devices,
    int? isGps,
    int? isBluetooth,
  }) {
    return GpsState(
      status: status ?? this.status,
      beacons: beacons ?? this.beacons,
      locationData: locationData ?? this.locationData,
      dropDownData: dropDownData ?? this.dropDownData,
      subLocations: subLocations ?? this.subLocations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      error: error ?? this.error,
      groupGpsLocations: groupGpsLocations ?? this.groupGpsLocations,
      address: address ?? this.address,
      isPoint: isPoint ?? this.isPoint,
      isBluetooth: isBluetooth ?? this.isBluetooth,
      isGps: isGps ?? this.isGps,
    );
  }

  @override
  List<Object?> get props => [
        status,
        locationData,
        dropDownData,
        subLocations,
        selectedLocation,
        error,
        address,
        isPoint,
        isGps,
        isBluetooth,
        beacons,
      ];
}

class GpsInitial extends GpsState {
  @override
  List<Object> get props => [];
}
