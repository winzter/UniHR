import 'package:flutter/material.dart';

class PicIndicator extends StatelessWidget {
  const PicIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset("assets/images/test_lerning.png",fit: BoxFit.fill,)),
      ),
    );
  }
}
