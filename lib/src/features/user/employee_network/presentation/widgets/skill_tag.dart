import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class SkillTag extends StatelessWidget {

  final EachEmployeeEntity eachEmpData;
  const SkillTag({super.key, required this.eachEmpData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: (eachEmpData.skills!= null && eachEmpData.skills!.isNotEmpty)? eachEmpData.skills!.map((e) =>  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            padding:
            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              "${e.skill!}",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),).toList():[Text("-")]
      ),
    );
  }
}
