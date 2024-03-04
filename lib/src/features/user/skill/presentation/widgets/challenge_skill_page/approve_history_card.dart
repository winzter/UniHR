import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ApproveHistoryCards extends StatelessWidget {
  const ApproveHistoryCards({super.key});

  Color levelColor(String level) {
    if (level == "อนุมัติแล้ว") {
      return const Color(0xff47D92F);
    } else {
      return const Color(0xffF54747);
    }
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(badgeColor: Colors.transparent),
      position: badges.BadgePosition.topStart(
          start: MediaQuery.of(context).size.width * 1/1000,
          top: MediaQuery.of(context).size.height * -0.03),
      badgeContent: CircleAvatar(
        radius: 25,
        backgroundImage:
        NetworkImage("https://i.pravatar.cc/150?img=15"),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 50,
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 120,
                  height: 120,
                  child: FittedBox(
                    child: Image.asset(
                        'assets/images/learning_user/figma_skill.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
            Expanded(
              flex: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Figma Skill",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          "24 มิถุนายน 2566",
                          style:
                          TextStyle(color: const Color(0xff757575)),
                        )
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          "09:00 - 12.00 น.",
                          style:
                          TextStyle(color: const Color(0xff757575)),
                        )
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            decoration: BoxDecoration(
                                color: levelColor("อนุมัติแล้ว"),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "อนุมัติแล้ว",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
