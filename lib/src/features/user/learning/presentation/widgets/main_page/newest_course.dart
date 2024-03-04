import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../pages/all_study_online_page.dart';
import '../../pages/all_study_onsite_page.dart';
import 'card_online_course.dart';
import 'card_onsite_course.dart';

class NewestCourse extends StatelessWidget {
  const NewestCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Newest",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 3.5,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff68D5E8),
                          Color(0xffF394BC),
                        ])),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "เรียนออนไลน์",
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllStudyOnlinePage(),));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xff68D5E8),
                        ),
                        borderRadius: BorderRadius.circular(20))),
                child: GradientText(
                  "ดูทั้งหมด",
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  colors: const [
                    Color(0xff68D5E8),
                    Color(0xffF394BC),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardOnlineCourse(imgPath: 'assets/images/test_learning6.png', title: 'Digital Business Essentials',),
                CardOnlineCourse(imgPath: 'assets/images/test_learning7.png', title: 'Getting User Insights through User Interviews',),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "เรียนในห้อง",
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllStudyOnsitePage(),));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xff68D5E8),
                        ),
                        borderRadius: BorderRadius.circular(20))),
                child: GradientText(
                  "ดูทั้งหมด",
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  colors: const [
                    Color(0xff68D5E8),
                    Color(0xffF394BC),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardOnsiteCourse(imgPath: 'assets/images/test_learning8.png', title: 'Intro to User Experience Design (UX)',),
                CardOnsiteCourse(imgPath: 'assets/images/test_learning9.png', title: 'UX Writing',),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
