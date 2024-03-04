import 'package:flutter/material.dart';

class CourseCompany extends StatelessWidget {
  const CourseCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left:MediaQuery.of(context).devicePixelRatio*11),
            child: Text("ผู้สอน",style: TextStyle(fontSize: 17),),
          ),
          ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              radius: 45,
              child: Icon(Icons.local_airport,size: 40,),
            ),
            title: Text(
              "MindDoJo (Thailand)",
              style: TextStyle(color: const Color(0xff275F77)),
            ),
            subtitle: Text(
                "ตำแหน่ง อาจารย์ประจำหลักสูตร Technology and Creative Innovation (MSTCI), CMKL University"),
          ),
        ],
      ),
    );
  }
}
