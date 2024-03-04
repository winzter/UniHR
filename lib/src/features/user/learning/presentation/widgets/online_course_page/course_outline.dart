import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseOutline extends StatelessWidget {
  const CourseOutline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "เค้าโครงหลักสูตร",
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            ListTile(
              leading: SvgPicture.asset("assets/icons/learning_user/check.svg",width: 20,),
              title: Text(
                  "Basic understanding of the AR Technology"),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                        " - Create dynamic web apps using the latest in web technology",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 13),
                      ))
                ],
              ),
            ),
            ListTile(
              leading: SvgPicture.asset("assets/icons/learning_user/check.svg",width: 20,),
              title: Text(
                  "Types of AR Experiences"),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                        " - Acquire the programming skills needed to obtain a software engineering job",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 13),
                      ))
                ],
              ),
            ),
            ListTile(
              leading:SvgPicture.asset("assets/icons/learning_user/check.svg",width: 20,),
              title: Text(
                  "Interaction Design for AR"),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                        " - Practice your skills with many large projects, exercises, and quizzes",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 13),
                      ))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
