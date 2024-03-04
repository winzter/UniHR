import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';

class CheckInLocationTwo extends StatelessWidget {

  final TimeLineEntity data;
  const CheckInLocationTwo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int indexCheckIn = 0;
    int indexCheckOut = 0;
    for(var i=data.attendance!.checkIn!.length-1;i>=0;i--){
      if(data.attendance!.checkIn![i] != null){
        indexCheckIn = i;
        break;
      }
    }
    for(var i=data.attendance!.checkOut!.length-1;i>=0;i--){
      if(data.attendance!.checkOut![i] != null){
        indexCheckOut = i;
        break;
      }
    }
    bool isCheckIn = data.attendance!.checkIn?[indexCheckIn] != null;
    bool isCheckOut = data.attendance!.checkOut?[indexCheckOut] != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 50,
            child:  (isCheckIn && data.holiday == null)
                ? Center(
              child: data.attendance!.checkIn![indexCheckIn]?.idAttendanceType == 4?
              Text(data.attendance!.checkIn![indexCheckIn]?.gpsAddress??"",
                style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xff757575)),overflow: TextOverflow.ellipsis,)
              :Text(data.attendance!.checkIn![indexCheckIn]?.gpsLocationsName
                  ?? data.attendance!.checkIn![indexCheckIn]?.groupGpsLocationsName??"",
                style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xff757575)),overflow: TextOverflow.ellipsis,),
            )
                : const Text(""),),
          Expanded(
            flex: 50,
            child: (isCheckOut && data.holiday == null)
                ? Center(
              child:
              data.attendance!.checkOut![indexCheckOut]?.idAttendanceType == 4?
              Text(data.attendance!.checkOut![indexCheckOut]?.gpsAddress ??"",
                style: TextStyle(
                    fontSize: 12,
                    color: const Color(
                        0xff757575)),overflow: TextOverflow.ellipsis,)
              :Text(data.attendance!.checkOut![indexCheckOut]?.gpsLocationsName
                  ?? data.attendance!.checkOut![indexCheckOut]?.groupGpsLocationsName
                  ??"",
                style: TextStyle(
                    fontSize: 12,
                    color: const Color(
                        0xff757575)),overflow: TextOverflow.ellipsis,),
            )
                : const Text(""),)
        ],
      ),
    );
  }
}
