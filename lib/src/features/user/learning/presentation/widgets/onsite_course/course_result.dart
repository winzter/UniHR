import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseResult extends StatelessWidget {
  const CourseResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Text(
                "สิ่งที่จะได้รับ",
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
                  SvgPicture.asset("assets/icons/learning_user/check_list.svg",width: 13,),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      "สามารถนำ Mendix Low Code สร้างแอปอย่างง่ายได้",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/learning_user/check_list.svg",width: 13,),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      "สามารถมีความรู้เพียงพอในการทดสอบ Mendix Rapid Certificate",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/learning_user/check_list.svg",width: 13,),
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
