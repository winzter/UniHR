import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../../../components/widgets/loading.dart';
import '../../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../domain/entities/location_entity.dart';
import '../../bloc/gps_bloc.dart';

class GoogleMapDisplay extends StatefulWidget {
  final List<Locations>? subLocations;
  final GpsBloc gpsBloc;

  final bool isPoint;

  const GoogleMapDisplay(
      {required this.subLocations,
      required this.gpsBloc,
      required this.isPoint});

  @override
  State<GoogleMapDisplay> createState() => _GoogleMapDisplayState();
}

class _GoogleMapDisplayState extends State<GoogleMapDisplay> {
  Position? userLocation;
  loc.Location location = loc.Location();

  Set<Polygon>? myPolygon() {
    final attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    Set<Polygon> polygonSet = {};
    if (widget.subLocations != null) {
      for (var i = 0; i < widget.subLocations!.length; i++) {
        List<LatLng> polygonCoords = [];
        List<mp.LatLng> checkLocation = [];
        for (var j = 0; j < widget.subLocations![i].positions!.length; j++) {
          polygonCoords.add(LatLng(widget.subLocations![i].positions![j].lat!,
              widget.subLocations![i].positions![j].lng!));
          checkLocation.add(mp.LatLng(
              widget.subLocations![i].positions![j].lat!,
              widget.subLocations![i].positions![j].lng!));
        }
        polygonSet.add(Polygon(
            polygonId: PolygonId('${widget.subLocations![i].idGpsLocations}'),
            fillColor: const Color.fromRGBO(255, 208, 1, 0.486),
            points: polygonCoords,
            strokeWidth: 3,
            strokeColor: const Color.fromARGB(255, 245, 200, 0)));
        attendanceProvider.setCheckIsInPolygons(
            widget.subLocations![i].idGpsLocations!, checkLocation);
      }
      attendanceProvider.locationCheck(
          userLocation!.latitude, userLocation!.longitude);
      return polygonSet;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlertCannotAccessLocation(null);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlertLocationDenied();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        userLocation = position;
        myPolygon();
        if (widget.isPoint) {
          widget.gpsBloc.add(GetCurrentAddress(
            lat: position.latitude,
            lng: position.longitude,
          ));
        }
        if (mounted) {
          setState(() {});
        }
      }).catchError((e) async {
        showAlertCannotAccessLocation(e);
      });
    }
  }

  Future showAlertCannotAccessLocation(dynamic e) async {
    if (e != null) {
      await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: 'ตกลง',
          title: 'ไม่สามารถเข้าถึงตำแหน่งได้',
          text: "$e",
          confirmBtnColor: Colors.red,
          onConfirmBtnTap: () async {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } else {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: 'ย้อนกลับ',
        title: 'ไม่สามารถเข้าถึงตำแหน่งได้',
        text: "Location permissions are denied.",
        confirmBtnColor: Colors.grey,
        onConfirmBtnTap: () {
          openAppSettings();
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    }
  }

  Future showAlertLocationDenied() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      confirmBtnText: 'ย้อนกลับ',
      title: 'ไม่สามารถเข้าถึงตำแหน่งได้',
      text: "Location permissions are denied.",
      confirmBtnColor: Colors.grey,
      onConfirmBtnTap: () {
        openAppSettings();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: userLocation == null
            ? Loading()
            : GoogleMap(
                mapType: MapType.normal,
                polygons: myPolygon() ?? {},
                compassEnabled: true,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(userLocation!.latitude, userLocation!.longitude),
                  zoom: 18,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('Sydney'),
                    position:
                        LatLng(userLocation!.latitude, userLocation!.longitude),
                  )
                },
              ));
  }
}
