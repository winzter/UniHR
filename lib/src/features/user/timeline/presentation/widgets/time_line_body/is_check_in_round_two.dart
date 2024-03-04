import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../domain/entities/entities.dart';

class IsCheckInRoundTwo extends StatelessWidget {

  final TimeLineEntity data;
  const IsCheckInRoundTwo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isCheckIn = data.attendanceDisplay!.last.checkIn != null;
    bool isCheckOut = data.attendanceDisplay!.last.checkOut != null;
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
      child: Row(
        children: [
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
                          if (data.attendanceDisplay!.last.checkIn!.idAttendanceType == 1)
                            SvgPicture.asset("assets/icons/green_location.svg")
                          else if (data.attendanceDisplay!.last.checkIn!.idAttendanceType == 5)
                            SvgPicture.asset("assets/icons/green_barcode.svg")
                          else if (isCheckIn &&
                                data.attendanceDisplay!.last.checkIn!.idAttendanceType == 4)
                              const Icon(
                                Icons.gps_fixed,
                                color: Color(0xff229A16),
                              )
                            else if (isCheckIn &&
                                  data.attendanceDisplay!.last.checkIn!.idAttendanceType == 7)
                                const Icon(
                                  Icons.bluetooth_connected,
                                  color: Color(0xff229A16),
                                )
                            else
                              SvgPicture.asset("assets/icons/green_finger.svg"),
                        const SizedBox(width: 5),
                        Text(
                          isCheckIn
                              ? data.attendanceDisplay!.last.checkIn!.attendanceTextTime!
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
                          if (data.attendanceDisplay!.last.checkOut!.idAttendanceType == 1)
                            SvgPicture.asset("assets/icons/red_location.svg")
                          else if (data.attendanceDisplay!.last.checkOut!.idAttendanceType == 5)
                            SvgPicture.asset("assets/icons/red_barcode.svg")
                          else if (data.attendanceDisplay!.last.checkOut!.idAttendanceType == 4)
                              const Icon(
                                Icons.gps_fixed,
                                color: Color(0xffB72136),
                              )
                            else if (data.attendanceDisplay!.last.checkOut!.idAttendanceType == 7)
                                const Icon(
                                  Icons.bluetooth_connected,
                                  color: Color(0xffB72136),
                                )
                            else
                              SvgPicture.asset("assets/icons/red_finger.svg"),
                        const SizedBox(width: 5),
                        Text(
                          isCheckOut
                              ? data.attendanceDisplay!.last.checkOut!.attendanceTextTime!
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
        ],
      ),
    );
  }
}
