import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/course_appbar.dart';
import '../widgets/course_code.dart';
import '../widgets/main_page/pic_indicator.dart';
import '../widgets/online_course_page/company_detail.dart';
import '../widgets/online_course_page/course_company.dart';
import '../widgets/online_course_page/course_description.dart';
import '../widgets/online_course_page/course_outline.dart';
import '../widgets/onsite_course/course_result.dart';
import '../widgets/onsite_course/suitable_course.dart';

class CourseOnsitePage extends StatefulWidget {
  const CourseOnsitePage({super.key});

  @override
  State<CourseOnsitePage> createState() => _CourseOnsitePageState();
}

class _CourseOnsitePageState extends State<CourseOnsitePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseAppbar(context, "คอร์ส Classroom"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16/9,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: PageView(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (int index) {
                              setState(() {
                                currentPageIndex = index;
                              });
                            },
                            // controller: controller,
                            children: [
                              PicIndicator(),
                              PicIndicator(),
                              PicIndicator(),
                              PicIndicator(),
                            ],
                          )),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.width * 0.43,
                      child: DotsIndicator(
                        dotsCount: 4,
                        position: currentPageIndex,
                        decorator: DotsDecorator(
                          color: const Color(0xffC4C4C4),
                          spacing: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context)
                                  .devicePixelRatio), // Inactive color
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            GradientText("Bussiness", colors: const [
                              Color(0xff68D5E8),
                              Color(0xffF394BC),
                            ])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                                  "Docker Zero to Hero - The Container's Fundamental",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                      ),
                      CourseDescription(),
                      CourseOutline(),
                      SuitableCourse(),
                      CourseResult(),
                      CourseCode(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              "รายละเอียด",
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
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                ),
                                Text(
                                  " 27 มีนาคม 2566",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 20,
                                ),
                                Text(
                                  " 09.00 - 16.00",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset("assets/icons/learning_user/certificate.svg",width: 20,),
                                Text(
                                  " มีใบประกาศนียบัตร",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset("assets/icons/learning_user/carbon_course.svg",width: 20,),
                                Text(
                                  " พื้นฐานโดยบริษัท",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset("assets/icons/learning_user/location.svg",width: 20,),
                                Text(
                                  " Skooldio Space",
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              "หมายเหตุ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            SvgPicture.asset(
                              "assets/icons/learning_user/warning.svg",
                              width: 20,
                            ),
                            Text(
                              " A Mac or Windows Computer",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 3,
                  indent: 15,
                  endIndent: 15,
                ),
                CourseCompany(),
                CompanyDetail(),
                const Divider(
                  thickness: 3,
                  indent: 15,
                  endIndent: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
