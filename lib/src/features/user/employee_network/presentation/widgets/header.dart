import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final String firstnameTH;
  const Header({super.key, required this.firstnameTH});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "สวัสดี , $firstnameTH",
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "คุณอยากค้นหาใครเป็นพิเศษ ?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff757575)),
            ),
          ],
        ),
      ],
    );
  }
}
