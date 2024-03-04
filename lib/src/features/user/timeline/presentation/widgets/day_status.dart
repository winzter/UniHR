import 'package:flutter/material.dart';

class DayStatus extends StatelessWidget {

  final String title;

  final Color fontColor;

  final Color bgColor;
  const DayStatus({Key? key, required this.title, required this.fontColor, required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).devicePixelRatio*7,
        vertical: MediaQuery.of(context).devicePixelRatio*3,),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ]
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text(title,style: TextStyle(color: fontColor,fontWeight: FontWeight.bold),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
