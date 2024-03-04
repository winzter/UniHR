import 'package:flutter/material.dart';

import 'heading_with_gradient_line.dart';

class OverviewDetail extends StatelessWidget {

  final String overviewDetail;
  const OverviewDetail({Key? key, required this.overviewDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).devicePixelRatio*5,vertical: MediaQuery.of(context).devicePixelRatio*3),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.dashboard_rounded),
              HeadingGradientLine(title: ' Overview', width: MediaQuery.of(context).size.width*0.2,),
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Flexible(child: Text("$overviewDetail")),
            ],
          )
        ],
      ),
    );
  }
}
