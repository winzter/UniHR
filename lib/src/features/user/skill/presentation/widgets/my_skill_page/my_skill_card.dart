import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../pages/challenge_skill_page.dart';


class MySkillCards extends StatelessWidget {
  final String level;
  final bool isAppointed;
  const MySkillCards({super.key, required this.level, required this.isAppointed});

  Color levelColor(String level){
    if(level == "Level 1"){
      return const Color(0xff47D92F);
    }
    else if(level == "Level 2"){
      return const Color(0xffFFC700);
    }
    else{
      return const Color(0xffF54747);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          if(isAppointed){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeSkill(),));
          }
        },
        child: Card(
          elevation: 10,
          child: FillImageCard(
            width: 300,
            // heightImage: 150,
            imageProvider: AssetImage('assets/images/test_learning.png'),
            title: Text("HTML Skill",style: TextStyle(fontSize: 18),),
            tags: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                decoration: BoxDecoration(
                  color: levelColor(level),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text(level,style: TextStyle(color: Colors.white,fontSize: 12),),
              )
            ],
            description: Column(
              children: [
                Text(
                  "Structured Query Language (SQL) is a standardized programming language that is used to manage relational databases and perform various operations....",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontSize: 11, color: const Color(0xff757575)),
                ),
                const SizedBox(
                  height: 10,
                ),
                if(isAppointed)...[
                  Row(
                    children: [
                      Icon(Icons.people,color: const Color(0xff757575),),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("1.2k Views",style: TextStyle(color: const Color(0xff757575)),)
                    ],
                  )
                ]
                else...[
                  LinearPercentIndicator(
                    width: 280,
                    animation: true,
                    lineHeight: 10.0,
                    animationDuration: 2000,
                    percent: 0.8,
                    barRadius: Radius.circular(10),
                    linearGradient: LinearGradient(colors: [
                      Color(0xff6FC9E4),
                      Color(0xffE793B8),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        " 80% COMPLETED",
                        style:
                        TextStyle(fontSize: 14, color: const Color(0xff858585)),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
