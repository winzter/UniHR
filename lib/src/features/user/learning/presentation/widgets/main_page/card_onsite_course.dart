import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/learning/presentation/pages/course_onsite_page.dart';

class CardOnsiteCourse extends StatelessWidget {
  final String imgPath;
  final String title;
  const CardOnsiteCourse({super.key, required this.imgPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseOnsitePage(),
            ));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              child: Image.asset(
                  imgPath),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 15,
                      ),
                      Text(
                        " 27 มีนาคม 2566",
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
