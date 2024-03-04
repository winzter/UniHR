import 'package:flutter/material.dart';

class SkillDetails extends StatelessWidget {
  const SkillDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Text(
                "Figma Skill",
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
                "การจัดวางเลเอาท์อินเทอร์เฟซ",
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
                "การสร้างแบบจำลอง (Prototype)",
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
                "ออกแบบ (Design)",
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
                "ออกแบบระบบ (Design System)",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
