import 'package:flutter/material.dart';
import '../../../learning/presentation/widgets/main_page/card_online_course.dart';
import '../../../learning/presentation/widgets/main_page/card_onsite_course.dart';

class RecommendedCourse extends StatelessWidget {
  const RecommendedCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).devicePixelRatio * 7.5,
              right: MediaQuery.of(context).devicePixelRatio * 7.5,
              bottom: MediaQuery.of(context).devicePixelRatio * 4
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "คอร์สออนไลน์ยอดฮิต",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 3.5,
                    width: MediaQuery.of(context).size.width * 0.4,
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
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).devicePixelRatio * 7.5,
              right: MediaQuery.of(context).devicePixelRatio * 7.5,
              bottom: MediaQuery.of(context).devicePixelRatio * 7.5
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardOnlineCourse(imgPath: 'assets/images/test_learning3.png', title: 'Webflow for Designers',),
                CardOnlineCourse(imgPath: 'assets/images/test_learning2.png', title: 'Getting Started with Kotlin',),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).devicePixelRatio * 7.5,
              right: MediaQuery.of(context).devicePixelRatio * 7.5,
              bottom: MediaQuery.of(context).devicePixelRatio * 4
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "คอร์สในห้องยอดฮิต",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 3.5,
                    width: MediaQuery.of(context).size.width * 0.4,
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
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).devicePixelRatio * 7.5,
              right: MediaQuery.of(context).devicePixelRatio * 7.5,
              bottom: MediaQuery.of(context).devicePixelRatio * 7.5
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardOnsiteCourse(imgPath: 'assets/images/test_learning4.png', title: 'Building Impactful Dashboard',),
                CardOnsiteCourse(imgPath: 'assets/images/test_learning5.png', title: 'Getting started with UX/UI Design',),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
