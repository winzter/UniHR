import 'package:flutter/material.dart';

class SuitableCourse extends StatelessWidget {
  const SuitableCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Text(
                "หลักสูตรนี้เหมาะกับ",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              const SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5, // Adjust the width as needed for spacing between icon and text
                  ),
                  Flexible(
                    child: Text(
                      "นักธุรกิจรุ่นใหม่ และ Start Up",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5, // Adjust the width as needed for spacing between icon and text
                  ),
                  Flexible(
                    child: Text(
                      "นักการตลาดหรือ ผู้ที่ต้องการนำ Graphic Design มาต่อยอด",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      "คนรุ่นใหม่ที่ต้องการสร้างธุรกิจของตัวเอง",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
