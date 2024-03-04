import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IsCheckIn extends StatelessWidget {
  final TimeLineEntity data;
  IsCheckIn({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isLeave = false;
    if (data.leave!.isNotEmpty) {
      for (var i in data.leave!) {
        if (i.isApprove == 1) {
          isLeave = true;
          break;
        }
      }
    }
    if (data.absent != true &&
        isLeave &&
        data.attendance!.checkIn != null &&
        data.attendance!.checkIn!.isEmpty &&
        data.attendance!.checkOut != null &&
        data.attendance!.checkOut!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5,
            ),
            SvgPicture.asset(
              "assets/icons/break.svg",
              width: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              AppLocalizations.of(context)!.leave,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      );
    }

    Widget attendanceIcon(TimeLineEntity data){
      switch(data.attendanceDisplay![0].checkIn!
          .idAttendanceType) {
        case 1:
          return SvgPicture.asset(
              "assets/icons/green_location.svg");
        default: return SvgPicture.asset("assets/icons/green_finger.svg");
      }

    }

    bool isCheckIn = data.attendanceDisplay!.isNotEmpty &&
        data.attendanceDisplay![0].checkIn != null;
    bool isCheckOut = data.attendanceDisplay!.isNotEmpty &&
        data.attendanceDisplay![0].checkOut != null;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Row(
        children: [
          if (!isCheckIn && !isCheckOut) ...[
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.notimetowork,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Colors.blue),
            ))
          ] else ...[
            Expanded(
              flex: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isCheckIn
                          ? const Color(0xffD8F2DC)
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          if (isCheckIn)
                            if (data.attendanceDisplay![0].checkIn!
                                    .idAttendanceType == 1)
                              SvgPicture.asset(
                                  "assets/icons/green_location.svg")
                            else if (data.attendanceDisplay![0].checkIn!
                                    .idAttendanceType == 5)
                              SvgPicture.asset("assets/icons/green_barcode.svg")
                            else if (isCheckIn &&
                                data.attendanceDisplay![0].checkIn!
                                        .idAttendanceType == 4)
                              const Icon(
                                Icons.gps_fixed,
                                color: Color(0xff229A16),
                              )
                            else if (isCheckIn &&
                                data.attendanceDisplay![0].checkIn!
                                        .idAttendanceType == 7)
                              const Icon(
                                Icons.bluetooth_connected,
                                color: Color(0xff229A16),
                              )
                            else
                              SvgPicture.asset("assets/icons/green_finger.svg"),
                          const SizedBox(width: 5),
                          Text(
                            isCheckIn
                                ? data.attendanceDisplay![0].checkIn!
                                    .attendanceTextTime!
                                : "-",
                            style: TextStyle(
                              color: const Color(0xff229A16),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isCheckOut
                          ? const Color(0xffFFD7DB)
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          if (isCheckOut)
                            if (data.attendanceDisplay![0].checkOut!
                                    .idAttendanceType ==
                                1)
                              SvgPicture.asset("assets/icons/red_location.svg")
                            else if (data.attendanceDisplay![0].checkOut!
                                    .idAttendanceType ==
                                5)
                              SvgPicture.asset("assets/icons/red_barcode.svg")
                            else if (data.attendanceDisplay![0].checkOut!
                                    .idAttendanceType ==
                                4)
                              const Icon(
                                Icons.gps_fixed,
                                color: Color(0xffB72136),
                              )
                            else if (data.attendanceDisplay![0].checkOut!
                                    .idAttendanceType ==
                                7)
                              const Icon(
                                Icons.bluetooth_connected,
                                color: Color(0xffB72136),
                              )
                            else
                              SvgPicture.asset("assets/icons/red_finger.svg"),
                          const SizedBox(width: 5),
                          Text(
                            isCheckOut
                                ? data.attendanceDisplay![0].checkOut!
                                    .attendanceTextTime!
                                : "-",
                            style: TextStyle(
                              color: const Color(0xffB72136),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
