import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeanBox extends StatelessWidget {
  final String title;
  final String age;
  const MeanBox({super.key, required this.title, required this.age});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 20,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 5,
            vertical: MediaQuery.of(context).devicePixelRatio * 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
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
            Text(
              title,
              style: TextStyle(color: Color(0xff757575)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  age,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  " ${AppLocalizations.of(context)!.year}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
