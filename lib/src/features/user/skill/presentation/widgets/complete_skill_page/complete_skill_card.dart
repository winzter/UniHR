import 'package:flutter/material.dart';

class CompleteSkillCard extends StatelessWidget {
  const CompleteSkillCard({Key? key}) : super(key: key);

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
    return InkWell(
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
                  Text(
                    "Structured Query Language (SQL) is a standardized programming language that is used to manage relational databases and perform various operations....",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 11, color: const Color(0xff757575)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                    decoration: BoxDecoration(
                        color: levelColor("Level 1"),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("Level 1",style: TextStyle(color: Colors.white,fontSize: 12),),
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
