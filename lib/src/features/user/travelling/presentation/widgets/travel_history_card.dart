import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../domain/entities/travelling_time_line_entity.dart';
import '../pages/location_map_page.dart';

class TravelHistoryCard extends StatelessWidget {
  final String locationName;

  final TravellingTimeLineEntity data;
  final String time;
  final Color mainColor;
  final Color bgColor;

  final bool isIn;

  const TravelHistoryCard(
      {Key? key,
      required this.locationName,
      required this.time,
      required this.mainColor,
      required this.bgColor,
      required this.data,
      required this.isIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, PageTransition(type:PageTransitionType.leftToRight,child: LocationMapPage(data: data, isIn: isIn,),));
      },
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: Icon(
              Icons.location_on,
              size: 30,
              color: mainColor,
            ),
            fit: FlexFit.loose, // Set FlexFit.loose
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 50,
            child: Text(
              locationName,
              style: TextStyle(fontSize: 18),
            ),
            fit: FlexFit.loose, // Set FlexFit.loose
          ),
          Flexible(
            flex: 25,
            child: Container(
              // width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: bgColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: mainColor,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 18,
                          color: mainColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
