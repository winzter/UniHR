import 'package:flutter/material.dart';

class TurnOverBox extends StatelessWidget {
  final String title;
  final int rate;
  const TurnOverBox({super.key, required this.title, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:20,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 3,
            vertical: MediaQuery.of(context).devicePixelRatio * 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(title,style: TextStyle(color: Color(0xff757575)),),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(rate.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                Text(" %",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)],)
          ],
        ),
      ),
    );
  }
}
