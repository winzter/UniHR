import 'package:flutter/material.dart';

class TestType extends StatelessWidget {
  const TestType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Text(
                "Test Type",
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
                "Quiz",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
