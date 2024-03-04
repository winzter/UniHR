import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:unihr/src/features/user/learning/presentation/widgets/learning_app_bar.dart';
import '../widgets/challenge_skill_page/date_and_time.dart';
import '../widgets/challenge_skill_page/skill_detail.dart';
import '../widgets/challenge_skill_page/test_type.dart';

class ChallengeSkillDuel extends StatelessWidget {
  const ChallengeSkillDuel({super.key});

  Color levelColor(String level) {
    if (level == "Level 1") {
      return const Color(0xff47D92F);
    } else if (level == "Level 2") {
      return const Color(0xffFFC700);
    } else {
      return const Color(0xffF54747);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "Challenge Skill", null),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 3),
          child: Column(
            children: [
              badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.transparent),
                position: badges.BadgePosition.bottomEnd(
                    end: MediaQuery.of(context).size.width * 1/1000,
                    bottom: MediaQuery.of(context).size.height * -0.01),
                badgeContent: Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  decoration: BoxDecoration(
                      color: levelColor("Level 1"),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Level 1",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/images/test_lerning.png"))),
              ),
              SkillDetails(),
              TestType(),
              DateAndTime(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Text(
                      "Assessor",
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ]
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 50,
                          child:  Icon(Icons.person,size: 45,),
                        ),
                        title: Text("พิชาพัทธิ์ สิริเจริญพานิช"),
                        subtitle: Text("บริษัท Vertex\n099-9999999"),
                        isThreeLine: true,
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff47D92F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onPressed: () {},
                      child: Text("Accept",style: TextStyle(fontSize: 17),),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF54747),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onPressed: () {},
                      child: Text("Reject",style: TextStyle(fontSize: 17),),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
