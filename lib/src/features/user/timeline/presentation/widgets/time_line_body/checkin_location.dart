import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';

class CheckInLocation extends StatelessWidget {
  final TimeLineEntity data;
  const CheckInLocation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 50,
            child:  ( data.attendance!.checkIn!.length >= 1
                && data.attendance!.checkIn?[0] != null
                && data.holiday == null
                )
              ? Center(
                child: data.attendance!.checkIn![0]?.idAttendanceType == 4?
                Text(data.attendance!.checkIn![0]?.gpsAddress??"",
                  style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xff757575)),overflow: TextOverflow.ellipsis,)
                :Text(data.attendance!.checkIn![0]?.gpsLocationsName
                    ?? data.attendance!.checkIn![0]?.groupGpsLocationsName
                    ??"",
            style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xff757575)),overflow: TextOverflow.ellipsis,),
              )
              : const Text(""),),
          Expanded(
            flex: 50,
            child: (data.attendance!.checkOut!.length >= 1
                && data.attendance!.checkOut?[0] != null
                && data.holiday == null
                )
              ? Center(
                child:
                data.attendance!.checkOut![0]?.idAttendanceType == 4?
                Text(data.attendance!.checkOut![0]?.gpsAddress??"",
                  style: TextStyle(
                      fontSize: 12,
                      color: const Color(
                          0xff757575)),overflow: TextOverflow.ellipsis,)
                :Text(data.attendance!.checkOut![0]?.gpsLocationsName
                    ?? data.attendance!.checkOut![0]?.groupGpsLocationsName
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
