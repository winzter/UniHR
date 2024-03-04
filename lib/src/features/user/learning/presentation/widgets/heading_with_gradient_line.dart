import 'package:flutter/material.dart';

class HeadingGradientLine extends StatelessWidget {

  final String title;
  final double width;
  const HeadingGradientLine({super.key, required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 3.5,
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff68D5E8),
                Color(0xffF394BC),
              ])),
        ),
      ],
    );
  }
}
