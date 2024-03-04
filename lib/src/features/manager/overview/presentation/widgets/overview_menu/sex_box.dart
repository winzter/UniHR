import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SexBox extends StatelessWidget {
  final String sex;
  final Color color;
  final String svgPath;
  final int num;

  const SexBox(
      {super.key,
      required this.sex,
      required this.svgPath,
      required this.num,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 3,
            vertical: MediaQuery.of(context).devicePixelRatio * 4.5),
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
            color: color),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(svgPath),
                Column(
                  children: [
                    Text(
                      sex,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          num.toString(),
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " ${AppLocalizations.of(context)!.person}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
