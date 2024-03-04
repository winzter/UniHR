import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../widgets/challenge_skill_page/widgets_challenge_skill.dart';

class ChallengeSkillDealPage extends StatelessWidget {
  const ChallengeSkillDealPage({super.key});

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                Color(0xff6FC9E4),
                Color(0xffE793B8),
              ])),
        ),
        centerTitle: true,
        title: Text(
          'Challenge Skill',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xff6FC9E4), Color(0xffE793B8)])),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).devicePixelRatio * 4),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            child:
                                Image.asset("assets/images/test_lerning.png"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                          "User",
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?img=0'),
                      ),
                      title: Text("สุชาติ ยิ้มแย้ม"),
                      subtitle: Text("บริษัท Vertex"),
                    ),
                  ),
                  SkillDetails(),
                  TestType(),
                  DateAndTime(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                          "Assessment Result",
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.0, color: const Color(0xff47D92F)),
                            ),
                            child: Text(
                              "Pass",
                              style: TextStyle(
                                  color: const Color(0xff47D92F), fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.0, color: const Color(0xffF54747)),
                            ),
                            child: Text(
                              "Not Pass",
                              style: TextStyle(
                                  color: const Color(0xffF54747), fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                          "Detail",
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          "ไม่ให้ผ่าน",
                          style: TextStyle(
                              fontSize: 15),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
