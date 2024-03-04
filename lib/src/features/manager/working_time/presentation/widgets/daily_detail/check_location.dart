import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/entities.dart';

class CheckInStatus extends StatelessWidget {
  final EmployeesAttendanceEntity data;
  final bool isCheckIn;
  const CheckInStatus({super.key, required this.data,required this.isCheckIn});

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;

    if (data.idAttendanceType == 1) {
      iconWidget = SvgPicture.asset("assets/icons/${isCheckIn?'green':'red'}_location.svg");
    } else if (data.idAttendanceType == 5) {
      iconWidget = SvgPicture.asset("assets/icons/${isCheckIn?'green':'red'}_barcode.svg");
    } else if (data.idAttendanceType == 4) {
      iconWidget = Icon(
        Icons.gps_fixed,
        color: isCheckIn?const Color(0xff229A16):const Color(0xffB72136),
      );
    }
    else if (data.idAttendanceType == 7) {
      iconWidget = Icon(
        Icons.bluetooth_connected,
        color: isCheckIn?const Color(0xff229A16):const Color(0xffB72136),
      );
    }

    else {
      iconWidget = SvgPicture.asset("assets/icons/${isCheckIn?'green':'red'}_finger.svg");
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: data.isCheckIn == 1 ? const Color(0xffD8F2DC) : Color(0xffFFD7DB),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                iconWidget,
                SizedBox(width: 5,),
                Text("${data.time}",
                    style: GoogleFonts.kanit(fontSize: 13,color: isCheckIn? Color(0xff229A16):Color(0xffB72136),fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        data.idAttendanceType == 4?
        SizedBox(
          width: 100,
          child: Center(
            child: Text("${data.gpsAddress??''}",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.kanit(color: Color(0xff757575)),),
          ),
        )
        :SizedBox(
          width: 100,
          child: Center(
            child: Text("${data.gpsLocationsName??''}",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.kanit(color: Color(0xff757575)),),
          ),
        )
      ],
    );
  }
}
