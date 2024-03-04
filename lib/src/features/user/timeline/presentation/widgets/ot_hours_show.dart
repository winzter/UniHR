import 'package:flutter/material.dart';

class OTHoursShow extends StatelessWidget {

  final String title;
  final String otValue;
  const OTHoursShow({super.key, required this.title, required this.otValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).devicePixelRatio*5),
      child: Row(
        children: [
          Expanded(
              flex: 50,
              child: Text(title,style: TextStyle(fontSize: 18.5,color: const Color(0xff757575)),)),
          Expanded(
              flex: 50,
              child: Text("$otValue",style: TextStyle(fontSize: 19),)),
        ],
      ),
    );
  }
}
