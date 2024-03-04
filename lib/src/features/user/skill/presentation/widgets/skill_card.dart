import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class SkillCard extends StatelessWidget {
  final String level;
  const SkillCard({Key? key, required this.level}) : super(key: key);



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

            ],
          ),
        ),
      ),
    );
  }
}
