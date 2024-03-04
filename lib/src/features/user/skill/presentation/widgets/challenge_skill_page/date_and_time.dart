import 'package:flutter/material.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Text(
                "Date and Time",
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Image.asset(
                "assets/images/learning_user/pink_check_circle.png",
                width: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "24 มิถุนายน 2566",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Image.asset(
                "assets/images/learning_user/pink_check_circle.png",
                width: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "09:00 - 12:00 น.",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
