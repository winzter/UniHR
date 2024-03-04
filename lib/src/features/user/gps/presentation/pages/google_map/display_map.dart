import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/components/widgets/loading.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../bluetooth_beacon/presentation/widgets/check_detail_bluetooth.dart';
import '../../../domain/entities/beacons_entity.dart';
import '../../bloc/gps_bloc.dart';
import '../../widgets/appbar.dart';
import '../../widgets/widgets.dart';
import 'google_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayGoogleMap extends StatefulWidget {
  final bool checkInOut;
  final int isGps;
  final int isBluetooth;
  final Map<String, List<dynamic>> beacons;

  const DisplayGoogleMap({
    super.key,
    required this.checkInOut,
    required this.isGps,
    required this.isBluetooth,
    required this.beacons,
  });

  @override
  State<DisplayGoogleMap> createState() => _DisplayGoogleMapState();
}

class _DisplayGoogleMapState extends State<DisplayGoogleMap> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GpsBloc gpsBloc = sl<GpsBloc>();
  String? foundDevice = null;
  List<BluetoothDevice> devices = [];
  bool isBluetoothSupport = true;
  List<BeaconsEntity> macAddress = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    scanForDevices(context);
  }

  Future<void> scanForDevices(BuildContext context) async {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (widget.isGps == 1 && widget.isBluetooth == 1) {
      var status = await Permission.bluetoothScan.request();
      var locationStatus = await Permission.location.request();
      if (mounted) {
        setState(() {
          isLoading = true;
        });
        if (await FlutterBluePlus.isSupported == false) {
          bluetoothErrorAlert('อุปกรณ์ไม่รองรับ',
              "อุปกรณ์เครื่องนี้ไม่รองรับการใช้งาน Bluetooth", false);
          setState(() {
            isBluetoothSupport = false;
          });
          gpsBloc.add(
              GetGPSLocation(idEmp: profileProvider.profileData.idEmployees!));
        }
        FlutterBluePlus.adapterState
            .listen((BluetoothAdapterState state) async {
          if (state == BluetoothAdapterState.on) {
            if (status.isGranted && locationStatus.isGranted) {
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
                var subscription =
                    FlutterBluePlus.scanResults.listen((results) {
                  if (results.isNotEmpty) {
                    for (ScanResult result in results) {
                      if (!devices.contains(result.device)) {
                        if (widget.beacons
                            .containsKey(result.device.remoteId.toString())) {
                          devices.add(result.device);
                          foundDevice = widget
                              .beacons[result.device.remoteId.toString()]![1];
                          isLoading = false;
                          setState(() {});
                          FlutterBluePlus.stopScan();
                          return;
                        }
                      }
                    }
                  }
                });
                FlutterBluePlus.cancelWhenScanComplete(subscription);
                await FlutterBluePlus.startScan(timeout: Duration(seconds: 10));
                await FlutterBluePlus.isScanning
                    .where((val) => val == false)
                    .first;
                await FlutterBluePlus.stopScan();
              }
            }
          } else if (state == BluetoothAdapterState.off) {
            bluetoothErrorAlert(
                "Bluetooth ถูกปิดอยู่",
                "กรุณาเปิด Bluetooth ${widget.isGps == 1 ? 'หรือ ลงเวลาด้วย GPS' : ''}",
                false);
            if (mounted) {
              setState(() {
                isLoading = false;
              });
              gpsBloc.add(GetGPSLocation(
                  idEmp: profileProvider.profileData.idEmployees!));
            }
          }
        });
      }
    } else if (widget.isGps == 1) {
      gpsBloc
          .add(GetGPSLocation(idEmp: profileProvider.profileData.idEmployees!));
    } else if (widget.isBluetooth == 1) {
      var status = await Permission.bluetoothScan.request();
      var locationStatus = await Permission.location.request();
      if (await FlutterBluePlus.isSupported == false) {
        bluetoothErrorAlert('อุปกรณ์ไม่รองรับ',
            "อุปกรณ์เครื่องนี้ไม่รองรับการใช้งาน Bluetooth", true);
        return;
      }
      FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
        if (state == BluetoothAdapterState.on) {
          if (status.isGranted && locationStatus.isGranted) {
            if (mounted) {
              setState(() {
                isLoading = true;
              });
              var subscription = FlutterBluePlus.scanResults.listen((results) {
                if (results.isNotEmpty) {
                  for (ScanResult result in results) {
                    if (!devices.contains(result.device)) {
                      if (widget.beacons
                          .containsKey(result.device.remoteId.toString())) {
                        devices.add(result.device);
                        foundDevice = widget
                            .beacons[result.device.remoteId.toString()]![1];
                        isLoading = false;
                        setState(() {});
                        FlutterBluePlus.stopScan();
                        return;
                      }
                    }
                  }
                }
              });
              FlutterBluePlus.cancelWhenScanComplete(subscription);
              await FlutterBluePlus.startScan(timeout: Duration(seconds: 10));
              await FlutterBluePlus.isScanning
                  .where((val) => val == false)
                  .first;
              await FlutterBluePlus.stopScan();
            }
          }
        } else if (state == BluetoothAdapterState.off) {
          bluetoothErrorAlert(
              "Bluetooth ถูกปิดอยู่",
              "กรุณาเปิด Bluetooth ${widget.isGps == 1 ? 'หรือ ลงเวลาด้วย GPS' : ''}",
              true);
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        }
      });
    }
  }

  Future<void> bluetoothErrorAlert(
      String title, String des, bool isDoublePop) async {
    await QuickAlert.show(
        confirmBtnColor: const Color(0xFFF15E5E),
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: 'ตกลง',
        title: title,
        text: des,
        onConfirmBtnTap: () {
          Navigator.pop(context);
          if (isDoublePop) {
            Navigator.pop(context);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
            context,
            widget.checkInOut
                ? '${AppLocalizations.of(context)!.clockingout}'
                : '${AppLocalizations.of(context)!.clockingin}'),
        body: BlocProvider(
          create: (context) => gpsBloc,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    if (widget.isGps == 0 && widget.isBluetooth == 0) ...[
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 320,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/cancel.svg",
                              height: 90,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "ไม่พบกรอบพื้นที่ทำงาน",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "ไม่พบกรอบพื้นที่ทำงาน กรุณาติดต่อแอดมิน",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "ย้อนกลับ",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ] else if (widget.isGps == 1 &&
                        widget.isBluetooth == 1) ...[
                      if (foundDevice == null && !isLoading ||
                          !isBluetoothSupport) ...[
                        CheckDetail(
                            checkInOut: widget.checkInOut,
                            formKey: formKey,
                            bloc: gpsBloc),
                        BlocBuilder<GpsBloc, GpsState>(
                            builder: (context, state) {
                          if (state.status == FetchStatus.selected) {
                            int key = state.groupGpsLocations
                                .firstWhere((element) =>
                                    element.name == state.selectedLocation)
                                .idGroupGpsLocations!;
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: 320,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white),
                              child: GoogleMapDisplay(
                                subLocations: state.subLocations[key],
                                gpsBloc: gpsBloc,
                                isPoint: state.isPoint,
                              ),
                            );
                          }
                          if (state.status == FetchStatus.fetching) {
                            return const Loading();
                          } else if (state.status == FetchStatus.success) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: 320,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white),
                              child: GoogleMapDisplay(
                                subLocations: null,
                                gpsBloc: gpsBloc,
                                isPoint: state.isPoint,
                              ),
                            );
                          } else {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("กำลังค้นหาตำแหน่ง"),
                              ],
                            );
                          }
                        }),
                      ] else ...[
                        CheckDetailBluetooth(
                          isLoading: isLoading,
                          checkInOut: widget.checkInOut,
                          platFormName: foundDevice,
                        ),
                      ]
                    ] else if (widget.isBluetooth == 1) ...[
                      CheckDetailBluetooth(
                        isLoading: isLoading,
                        checkInOut: widget.checkInOut,
                        platFormName: foundDevice,
                      ),
                    ] else if (widget.isGps == 1) ...[
                      CheckDetail(
                          checkInOut: widget.checkInOut,
                          formKey: formKey,
                          bloc: gpsBloc),
                      BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
                        if (state.status == FetchStatus.selected) {
                          int key = state.groupGpsLocations
                              .firstWhere((element) =>
                                  element.name == state.selectedLocation)
                              .idGroupGpsLocations!;
                          return Container(
                            padding: const EdgeInsets.all(10),
                            height: 320,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: Colors.white),
                            child: GoogleMapDisplay(
                              subLocations: state.subLocations[key],
                              gpsBloc: gpsBloc,
                              isPoint: state.isPoint,
                            ),
                          );
                        }
                        if (state.status == FetchStatus.fetching) {
                          return const Loading();
                        } else if (state.status == FetchStatus.success) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            height: 320,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: Colors.white),
                            child: GoogleMapDisplay(
                              subLocations: null,
                              gpsBloc: gpsBloc,
                              isPoint: state.isPoint,
                            ),
                          );
                        } else {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 15,
                              ),
                              Text("กำลังค้นหาตำแหน่ง"),
                            ],
                          );
                        }
                      }),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    // FlutterBluePlus.isScanning.listen((isScanning) {
    //   if (isScanning) {
    //     // FlutterBluePlus.stopScan();
    //   }
    // });
    FlutterBluePlus.stopScan();
    gpsBloc.close();
  }
}
