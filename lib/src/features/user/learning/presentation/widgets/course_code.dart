import 'package:flutter/material.dart';

class CourseCode extends StatelessWidget {
  const CourseCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Text(
                "Code",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(
                Icons.circle,
                size: 10,
              ),
              Text(
                " 123456789986254",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }
}
