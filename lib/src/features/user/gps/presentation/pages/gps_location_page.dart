import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/components/widgets/gap.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/error/token_expires.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../bloc/gps_bloc.dart';
import '../widgets/widgets.dart';

class GpsLocationPage extends StatefulWidget {
  const GpsLocationPage({super.key});

  @override
  State<GpsLocationPage> createState() => _GpsLocationPageState();
}

class _GpsLocationPageState extends State<GpsLocationPage> {
  final GpsBloc gpsBloc = sl<GpsBloc>();

  Future<bool> onBackPress() async {
    final NavIndex navigationProvider = Provider.of<NavIndex>(context, listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    gpsBloc.add(GetGPSLocation(idEmp: profileProvider.profileData.idEmployees!));
    gpsBloc.add(GetBluetoothBeacons());
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return BlocProvider(
      create: (context) => gpsBloc,
      child: WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/splash.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: RefreshIndicator(
                  onRefresh: () async{
                    gpsBloc.add(GetGPSLocation(idEmp: profileProvider.profileData.idEmployees!));
                    gpsBloc.add(GetBluetoothBeacons());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const Gap(height: 15),
                        const Header(),
                        const Gap(height: 20),
                        const DigiClock(),
                        const Gap(height: 20),
                        BlocConsumer<GpsBloc, GpsState>(
                          listener: (context,state){
                            if(state.status == FetchStatus.failed){
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  confirmBtnText: "ปิด",
                                  confirmBtnColor: const Color(0xffE46A76),
                                  title: "เกิดข้อผิดพลาด",
                                  text: "ไม่สามารถดึงข้อมูลได้ กรุณาลองใหม่อีกครั้งหรือติดต่อแอดมิน"
                              );
                            }
                          },
                          builder: (context, state) {
                            if(state.status == FetchStatus.success){
                              return Column(
                                children: [
                                  SignIn(
                                    isCheckIn: true,isGps: state.isGps, isBluetooth: state.isBluetooth,beacons:state.beacons,
                                  ),
                                  SignOut(
                                    isAlreadyCheck: false, isGps: state.isGps, isBluetooth: state.isBluetooth,beacons:state.beacons,
                                  ),
                                ],
                              );
                            }
                            return Column(
                              children: [
                                SignIn(
                                  isCheckIn: true,isGps: state.isGps, isBluetooth: state.isBluetooth,beacons:state.beacons,
                                ),
                                SignOut(
                                  isAlreadyCheck: false, isGps: state.isGps, isBluetooth: state.isBluetooth,beacons:state.beacons,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 200,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
