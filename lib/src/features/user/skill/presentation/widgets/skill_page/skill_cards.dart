import 'package:flutter/material.dart';

import '../../../../skill/presentation/pages/challenge_skill_page.dart';

class SkillCards extends StatelessWidget {
  const SkillCards({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeSkill(),));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              child: Image.asset(
                  "assets/images/test_learning.png",fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text("HTML Skill",style: TextStyle(fontSize: 15),),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Structured Query Language (SQL) is a standardized programming language that is used to manage relational databases and perform various operations....",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(fontSize: 12,color: const Color(0xff757575)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 25,
                      ),
                      Text(
                        " 1.2k views",
                        style: TextStyle(fontSize: 14),
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
