import 'package:chips_choice/chips_choice.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:unihr/src/features/user/learning/presentation/pages/my_courses.dart';
import '../widgets/learning_app_bar.dart';
import '../widgets/main_page/all_course.dart';
import '../widgets/main_page/hit_course.dart';
import '../widgets/main_page/pic_indicator.dart';
import '../widgets/main_page/newest_course.dart';
import 'pages.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int tag = 0;
  int index = 0;
  List<String> options = [
    'ทักษะทั้งหมด', 'Programming', 'Adaptability',
    'Problem-Solving', 'Communication', 'Leadership',
  ];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "Learning", () {}),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 3),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (BuildContext builderContext) {
                      return DrawerButton(
                        onPressed: () {
                          Scaffold.of(builderContext).openDrawer();
                        },
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).devicePixelRatio*5),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      index = 0;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: index==0? const [
                                          Color(0xff68D5E8),
                                          Color(0xffF394BC),
                                        ]:[Colors.transparent,Colors.transparent]
                                      )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text("คอร์สทั้งหมด",style: TextStyle(fontSize: 19),)],),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      index = 1;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: index==1? const [
                                              Color(0xff68D5E8),
                                              Color(0xffF394BC),
                                            ]:[Colors.transparent,Colors.transparent]
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text("เรียนออนไลน์",style: TextStyle(fontSize: 19),)],),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      index = 2;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors:index==2? const [
                                              Color(0xff68D5E8),
                                              Color(0xffF394BC),
                                            ]:[Colors.transparent,Colors.transparent]
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text("เรียนในห้อง",style: TextStyle(fontSize: 19),)],),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color(0xff68D5E8),
                            ),
                            borderRadius: BorderRadius.circular(20))),
                    child: GradientText(
                      "ตัวเลือก",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      colors: const [
                        Color(0xff68D5E8),
                        Color(0xffF394BC),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
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
                              ],
                            )),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.43,
                        child: DotsIndicator(
                          dotsCount: 3,
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "หมวดหมู่",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17.5),
                    ),
                    GradientText(
                      "ดูทั้งหมด",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                      colors: const [
                        Color(0xff68D5E8),
                        Color(0xffF394BC),
                      ],
                    ),
                  ],
                ),
              ),
              ChipsChoice<int>.single(
                scrollPhysics: const BouncingScrollPhysics(),
                value: tag,
                onChanged: (val) => setState(() => tag = val),
                choiceItems: C2Choice.listFrom<int, String>(
                  source: options,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
              ),
              HitCourse(),
              NewestCourse(),
              AllCourse(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCourses(),
                        ));
                  },
                  title: const Text("หลักสุตรของฉัน",style: TextStyle(fontSize:  18),),
                  leading: const Icon(Icons.menu_book_sharp),
                ),
                const Divider(thickness: 1,color: const Color(0xffc4c4c4),),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LearningHistoryPage(),
                        ));
                  },
                  title: const Text("ประวัติการเรียนรู้",style: TextStyle(fontSize:  18),),
                  leading: const Icon(Icons.menu_book_sharp),
                ),
                const Divider(thickness: 1,color: const Color(0xffc4c4c4),),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCertificatePage(),
                        ));
                  },
                  title: const Text("ใบประกาศของฉัน",style: TextStyle(fontSize:  18),),
                  leading: const Icon(Icons.menu_book_sharp),
                ),
                const Divider(thickness: 1,color: const Color(0xffc4c4c4),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
