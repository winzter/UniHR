import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseBox extends StatelessWidget {
  final String title;
  final num value;
  final String svgPath;
  const ExpenseBox(
      {super.key,
      required this.title,
      required this.value,
      required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 5,
            vertical: MediaQuery.of(context).devicePixelRatio * 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white),
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
                      style: TextStyle(fontSize: 18, color: Color(0xff5B4589)),
                    ),
                    Row(
                      children: [
                        Text(
                          NumberFormat("#,###.##").format(value),
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(0xff5B4589),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " ${AppLocalizations.of(context)!.baht}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff5B4589),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(
                  svgPath,
                  height: 70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
