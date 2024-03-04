import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/features/user/travelling/presentation/widgets/preview.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/loading.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/LocationBloc_bloc.dart';
import '../pages/travelling_history.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationBloc locationBloc = sl<LocationBloc>();
  Position? userLocation;

  Map<String, String?> isError = {"ErrMsg": null};
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    final ProfileProvider user = Provider.of<ProfileProvider>(context,listen: false);
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
        setState(() {
          userLocation = position;
        });
        locationBloc.add(GetCurrentAddress(
          lat: position.latitude,
          lng: position.longitude,
          now: now, idEmp: user.profileData.idEmployees!,
        ));
        setState(() {});
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    return BlocProvider(
        create: (context) => locationBloc,
        child: Stack(
          children: [
            if (userLocation == null) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Loading(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "กำลังดึงข้อมูลแผนที่...",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )
            ]
            else if (isError['ErrMsg'] == null && userLocation != null) ...[
              GoogleMap(
                compassEnabled: true,
                initialCameraPosition: CameraPosition(
                    bearing: 192.8334901395799,
                    target:
                        LatLng(userLocation!.latitude, userLocation!.longitude),
                    zoom: 19.151926040649414),
                markers: {
                  Marker(
                    markerId: MarkerId('Sydney'),
                    position:
                        LatLng(userLocation!.latitude, userLocation!.longitude),
                  )
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PreviewWidget(
                  bloc: locationBloc,
                  lat: userLocation!.latitude,
                  lng: userLocation!.longitude,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6FC9E4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: TravellingHistoryPage(
                              idEmp: user.profileData.idEmployees!,
                              userLocation: userLocation!)),
                    );
                  },
                  child: Text(
                    "${AppLocalizations.of(context)!.travelhistory}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ]
            else if (isError['ErrMsg'] != null) ...[
              Center(
                child: Text(
                  "${isError['ErrMsg']}",
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ],
        ));
  }
}
