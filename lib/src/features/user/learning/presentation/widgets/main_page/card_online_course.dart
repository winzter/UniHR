import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/learning/presentation/pages/course_online_page.dart';

class CardOnlineCourse extends StatelessWidget {

  final String imgPath;
  final String title;
  const CardOnlineCourse({super.key, required this.imgPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseOnlinePage(),
            ));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              child: Image.asset(imgPath),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(
                    height: 5,
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
    );
  }
}
