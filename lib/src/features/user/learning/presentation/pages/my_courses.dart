import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/my_courses_page/my_course_card.dart';
import '../widgets/learning_app_bar.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {

  int index = 0;

  String choice(int index){
    if(index==0){
      return "หลักสูตรทั้งหมด";
    }else if(index == 1){
      return "หลักสูตรออนไลน์";
    }
    else{
      return "หลักสูตรในห้อง";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "หลักสูตรของฉัน",null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${choice(index)}",style: TextStyle(color: const Color(0xff757575),fontSize:  18),),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
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
                                        children: [Text("หลักสูตรทั้งหมด",style: TextStyle(fontSize: 19),)],),
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
                                        children: [Text("หลักสูตรออนไลน์",style: TextStyle(fontSize: 19),)],),
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
                                        children: [Text("หลักสูตรในห้อง",style: TextStyle(fontSize: 19),)],),
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
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width*0.5,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: 1,
                itemBuilder: (context, index) {
                  if(index < 4){
                    return MyCourseCards(isOnsite: false,);
                  }else{
                    return MyCourseCards(isOnsite: true,);
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
