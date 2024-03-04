import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../pages/course_online_page.dart';

class StudyOnlineCard extends StatelessWidget {
  const StudyOnlineCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio * 2,
          horizontal: MediaQuery.of(context).devicePixelRatio * 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CourseOnlinePage(),));
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset(
                    "assets/images/test_learning.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText("Online Course", colors: [
                      Color(0xff6FC9E4),
                      Color(0xffE793B8),
                    ],
                        style: TextStyle(fontSize: 15)),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Building Hybrid Applications with Flutter",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 15,
                        ),
                        Text(
                          " 400 | ",
                          style: TextStyle(fontSize: 13),
                        ),
                        Icon(
                          Icons.access_time_outlined,
                          size: 15,
                        ),
                        Text(
                          " 27:04",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
