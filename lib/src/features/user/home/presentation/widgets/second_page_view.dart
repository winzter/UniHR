import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unihr/src/core/features/attendance/presentation/provider/attendance_provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecondPageView extends StatelessWidget {
  const SecondPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.time_status,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 23, color: Colors.black),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              user.isLoading == false
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 7,
                          vertical:
                              MediaQuery.of(context).devicePixelRatio * 3),
                      child: Column(
                        children: [
                          if (attendanceProvider.attendanceData.isNotEmpty
                              && attendanceProvider.attendanceData.length > 0
                              && attendanceProvider.attendanceData[1].attendanceDisplay != null
                              && attendanceProvider.attendanceData[1].attendanceDisplay!.isNotEmpty
                              && attendanceProvider.attendanceData[1].attendanceDisplay!.last.checkIn != null) ...[
                            Text(
                              AppLocalizations.of(context)!.checkinsu,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                                "${attendanceProvider.attendanceData[1].attendanceDisplay!.last.checkIn!.attendanceTextTime}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ] else ...[
                            Text(
                              AppLocalizations.of(context)!.didntcheckin,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text("-",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ]
                        ],
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 70,
                        decoration: ShapeDecoration(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )),
              user.isLoading == false
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 7,
                          vertical:
                              MediaQuery.of(context).devicePixelRatio * 3),
                      child: Column(
                        children: [
                          if(attendanceProvider.attendanceData.isNotEmpty
                              && attendanceProvider.attendanceData.length > 0
                              && attendanceProvider.attendanceData[1].attendanceDisplay != null
                              && attendanceProvider.attendanceData[1].attendanceDisplay!.isNotEmpty
                              && attendanceProvider.attendanceData[1].attendanceDisplay!.last.checkOut != null) ...[
                            Text(
                              AppLocalizations.of(context)!.checkoutsu,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                                "${attendanceProvider.attendanceData[1].attendanceDisplay!.last.checkOut!.attendanceTextTime}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ] else ...[
                            Text(
                              AppLocalizations.of(context)!.didntcheckout,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text("-",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ]
                        ],
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 70,
                        decoration: ShapeDecoration(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )),
            ],
          )
        ],
      ),
      user.isLoading == false
          ? Positioned(
              left: MediaQuery.of(context).size.width * 0.20,
              top: MediaQuery.of(context).size.height * 0.055,
              child: (attendanceProvider.attendanceData.isNotEmpty
                  && attendanceProvider.attendanceData.length > 0
                  && attendanceProvider.attendanceData[1].attendanceDisplay != null
                  && attendanceProvider.attendanceData[1].attendanceDisplay!.isNotEmpty
                  && attendanceProvider.attendanceData[1].attendanceDisplay!.last.checkIn != null)
                  ? SvgPicture.asset("assets/icons/approve.svg")
                  : SvgPicture.asset("assets/icons/not_approve.svg"))
          : const SizedBox(),
      user.isLoading == false
          ? Positioned(
              right: MediaQuery.of(context).size.width * 0.20,
              top: MediaQuery.of(context).size.height * 0.055,
              child: (attendanceProvider.attendanceData.isNotEmpty
                  && attendanceProvider.attendanceData.length > 0
                  && attendanceProvider.attendanceData[1].attendanceDisplay != null
                  && attendanceProvider.attendanceData[1].attendanceDisplay!.isNotEmpty
                  && attendanceProvider.attendanceData[1].attendanceDisplay!.last.checkOut != null)
                  ? SvgPicture.asset("assets/icons/approve.svg")
                  : SvgPicture.asset("assets/icons/not_approve.svg"))
          : const SizedBox()
    ]);
  }
}
