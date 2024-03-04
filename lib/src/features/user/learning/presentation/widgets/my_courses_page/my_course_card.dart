import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyCourseCards extends StatelessWidget {

  final bool isOnsite;
  const MyCourseCards({super.key, required this.isOnsite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              // width: MediaQuery.of(context).size.width,
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
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Building Hybrid Applications with Flutter",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if(isOnsite)...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            "assets/icons/learning_user/fluent_learning-app-24-filled.svg",
                            width: 20),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            "วันที่ 2 มกราคม 2566",
                            style: TextStyle(fontSize: 11,color: const Color(0xff757575)),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            "assets/icons/learning_user/clarity_certificate-solid.svg",
                            width: 20),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "09:00 - 12.00",
                          style: TextStyle(fontSize: 11,color: const Color(0xff757575)),
                        )
                      ],
                    ),
                  ]
                  else...[
                    const SizedBox(
                      height: 20,
                    ),
                    LinearPercentIndicator(
                      padding: EdgeInsets.all(0),
                      animation: true,
                      lineHeight: 8.0,
                      animationDuration: 2000,
                      percent: 0.8,
                      barRadius: Radius.circular(10),
                      linearGradient: LinearGradient(colors: [
                        Color(0xff6FC9E4),
                        Color(0xffE793B8),
                      ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          " 80% COMPLETED",
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xff858585)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
