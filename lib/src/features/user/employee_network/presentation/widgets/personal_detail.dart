import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';
import 'widgets.dart';

class PersonalDetail extends StatelessWidget {

  final EachEmployeeEntity eachEmpData;
  const PersonalDetail({super.key, required this.eachEmpData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(" Gender : ",style: TextStyle(fontSize: 18),),
              Text("-",style: TextStyle(fontSize: 18),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(" Nickname : ",style: TextStyle(fontSize: 18),),
              Text("${eachEmpData.nicknameTh??'-'}",style: TextStyle(fontSize: 18),)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.construction,color: Colors.indigo,),
              Text(" Skill",style: TextStyle(fontSize: 18),),
            ],
          ),
          const SizedBox(height: 5),
          SkillTag(eachEmpData: eachEmpData),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.interests,color: Colors.pinkAccent,),
              Text(" Interest",style: TextStyle(fontSize: 18),),
            ],
          ),
          const SizedBox(height: 5),
          InterestTag(eachEmpData: eachEmpData),
        ],
      ),
    );
  }
}
