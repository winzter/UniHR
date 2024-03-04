import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  final String title;
  const TextHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).devicePixelRatio * 7.5,
          right: MediaQuery.of(context).devicePixelRatio * 7.5,
          bottom: MediaQuery.of(context).devicePixelRatio * 4),
      child: Row(children: [Text(title,style: TextStyle(fontSize: 20))]),
    );
  }
}
