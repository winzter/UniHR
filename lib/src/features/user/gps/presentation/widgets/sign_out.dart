import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../pages/google_map/display_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignOut extends StatefulWidget {
  final bool isAlreadyCheck;
  final int isGps;
  final int isBluetooth;
  final Map<String,List<dynamic>> beacons;

  const SignOut({
    super.key,
    required this.isGps,
    required this.isBluetooth,
    required this.beacons,
    required this.isAlreadyCheck,
  });

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final allLoading = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 20),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio * 5,
          horizontal: MediaQuery.of(context).devicePixelRatio * 5,
        ),
        margin: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.40),
              Color.fromRGBO(255, 255, 255, 0.40),
            ],
            stops: [0.0, 1.0],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13),
              offset: Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // "จ. 18/4/66",
                  DateFormat("E dd/MM/yy").format(DateTime.now()),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (attendanceProvider.attendanceData.isNotEmpty
                      && attendanceProvider.attendanceData.length > 0
                      && attendanceProvider.attendanceData[1].attendanceDisplay != null
                      && attendanceProvider.attendanceData[1].attendanceDisplay!.isNotEmpty
                      && attendanceProvider.attendanceData[1].attendanceDisplay![0].checkOut != null)
                      ? attendanceProvider
                              .attendanceData[1]
                              .attendanceDisplay![0]
                              .checkOut
                              ?.attendanceTextTime ??
                          ""
                      : "",
                  style:
                      TextStyle(fontSize: 19, color: const Color(0xff27385E)),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton.icon(
              label: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).devicePixelRatio * 3),
                child: Text(
                  AppLocalizations.of(context)!.clockout,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              icon: const Icon(Icons.location_on_rounded, color: Colors.white),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(allLoading.isLoading
                    ? Colors.grey
                    : const Color(0xffE793B8)),
              ),
              onPressed: () {
                if (!allLoading.isLoading) {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayGoogleMap(
                                checkInOut: false,
                                isGps: widget.isGps,
                                isBluetooth: widget.isBluetooth,
                                beacons: widget.beacons,
                                  )))
                      .then((value) => attendanceProvider.getAttendanceData(context));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
