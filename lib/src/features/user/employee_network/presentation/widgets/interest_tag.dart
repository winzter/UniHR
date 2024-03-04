import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';

class InterestTag extends StatelessWidget {

  final EachEmployeeEntity eachEmpData;
  const InterestTag({super.key, required this.eachEmpData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: (eachEmpData.interests!= null && eachEmpData.interests!.isNotEmpty)? eachEmpData.interests!.map((e) =>  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              padding:
              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "${e.interest!}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),).toList():[Text("-")]
      ),
    );
  }
}
