import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/components/widgets/loading.dart';
import 'package:unihr/src/features/user/working_record/presentation/bloc/WorkRecord_bloc.dart';
import '../../../../../../injection_container.dart';
import '../widgets/address_detail.dart';
import '../widgets/appBar.dart';

class MapPage extends StatefulWidget {
  final bool isCheck;

  const MapPage({super.key, required this.isCheck});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final WorkRecordBloc bloc = sl<WorkRecordBloc>();
  Position? userLocation;

  Map<String, String?> isError = {"ErrMsg": null};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async{
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
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          userLocation = position;
        });
        bloc.add(GetCurrentAddress(
            lat: position.latitude,
            lng: position.longitude,
            isCheck: widget.isCheck));
      }).catchError((e) async{
        showAlertCannotAccessLocation(e);
      });
    }
  }
  // _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     setState(() {
  //       isError.update("ErrMsg", (value) => 'Location services are disabled.');
  //     });
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       setState(() {
  //         isError.update(
  //             "ErrMsg", (value) => 'Location permissions are denied');
  //       });
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     setState(() {
  //       isError.update(
  //           "ErrMsg",
  //           (value) =>
  //               'Location permissions are permanently denied, we cannot request permissions.');
  //     });
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       userLocation = position;
  //     });
  //     bloc.add(GetCurrentAddress(
  //         lat: position.latitude,
  //         lng: position.longitude,
  //         isCheck: widget.isCheck));
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  Future showAlertCannotAccessLocation(dynamic e) async{
    if( e != null){
      await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: 'ตกลง',
          title: 'ไม่สามารถเข้าถึงตำแหน่งได้',
          text: "$e",
          confirmBtnColor: Colors.red,
          onConfirmBtnTap: () async{
            Navigator.pop(context);
          });

    }else{
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: 'ย้อนกลับ',
        title: 'ไม่สามารถเข้าถึงตำแหน่งได้',
        text: "Location permissions are denied.",
        confirmBtnColor: Colors.grey,
        onConfirmBtnTap: (){
          openAppSettings();
          Navigator.pop(context);
        },);
    }

  }

  Future showAlertLocationDenied() async{
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      confirmBtnText: 'ย้อนกลับ',
      title: 'ไม่สามารถเข้าถึงตำแหน่งได้',
      text: "Location permissions are denied.",
      confirmBtnColor: Colors.grey,
      onConfirmBtnTap: (){
        openAppSettings();
        Navigator.pop(context);
      },);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: userLocation == null
                        ? Column(
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
                        : GoogleMap(
                            mapType: MapType.normal,
                            compassEnabled: true,
                            markers: {
                              Marker(
                                markerId: MarkerId('Sydney'),
                                position: LatLng(userLocation!.latitude,
                                    userLocation!.longitude),
                              )
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(userLocation!.latitude,
                                  userLocation!.longitude),
                              zoom: 18,
                            ),
                          )),
                BlocBuilder<WorkRecordBloc, WorkRecordState>(
                  builder: (context, state) {
                    if (state.address != null) {
                      return AddressDetail(
                        address: state.address!,
                        isCheck: widget.isCheck,
                        bloc: bloc,
                      );
                    } else if(isError['ErrMsg']!=null){
                      return Center(
                        child: Text(
                          "${isError['ErrMsg']}",
                          style: TextStyle(fontSize: 17),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
