import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapDisplay extends StatefulWidget {

  const GoogleMapDisplay({super.key});

  @override
  State<GoogleMapDisplay> createState() => _GoogleMapDisplayState();
}

class _GoogleMapDisplayState extends State<GoogleMapDisplay> {
  List<Placemark> address = [];
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  late Position userLocation;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }



    userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    address = await placemarkFromCoordinates(userLocation.latitude, userLocation.longitude);
    return userLocation;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: determinePosition(),
        builder: (context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            Position userLocation = snapshot.data!;
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(userLocation.latitude, userLocation.longitude),
                zoom: 18,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',style: TextStyle(),),
            );
          } else {
            return Center(
              child: Text('ไม่มีข้อมูลสถานที่',style: TextStyle()),
            );
          }
        },
      ),
    );
  }

}
