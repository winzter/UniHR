import 'package:flutter/material.dart';

class Gap extends StatelessWidget {

  final double height;
  const Gap({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }
}
