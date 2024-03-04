import 'package:flutter/material.dart';

class GifPics extends StatelessWidget {
  const GifPics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        // elevation: 5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ]
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/gifs/dollar2.gif",
                  width: 70,
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/gifs/wallet.gif",
                  width: 150,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/gifs/dollar1.gif",
                  width: 70,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
