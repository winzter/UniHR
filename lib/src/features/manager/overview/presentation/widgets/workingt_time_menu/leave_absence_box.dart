import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaveAndAbsenceBox extends StatelessWidget {
  final String title;
  final int rate;
  final Color color;
  final String svgPath;

  const LeaveAndAbsenceBox(
      {super.key,
      required this.title,
      required this.rate,
      required this.color,
      required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 20,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 3,
            vertical: MediaQuery.of(context).devicePixelRatio * 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          rate.toString(),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          " ${AppLocalizations.of(context)!.timesss}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(
                  svgPath,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
