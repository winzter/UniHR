import 'package:flutter/material.dart';

class Assessors extends StatelessWidget {
  const Assessors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Text(
                "Assessor",
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child:  Icon(Icons.person,size: 45,),
                  ),
                  title: Text("พิชาพัทธิ์ สิริเจริญพานิช"),
                  subtitle: Text("บริษัท Vertex\n099-9999999"),
                  isThreeLine: true,
                ),
              ),
            )
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child:  Icon(Icons.person,size: 45,),
                  ),
                  title: Text("พิชาพัทธิ์ สิริเจริญพานิช"),
                  subtitle: Text("บริษัท Vertex\n099-9999999"),
                  isThreeLine: true,
                ),
              ),
            )
        ),
      ],
    );
  }
}
