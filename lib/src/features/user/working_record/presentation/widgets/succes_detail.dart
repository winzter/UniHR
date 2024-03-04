import 'package:flutter/material.dart';

class DetailSuccess extends StatelessWidget {
  final String title;
  final String detail;
  final bool isEnd;

  const DetailSuccess({
    super.key,
    required this.title,
    required this.detail,
    required this.isEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).devicePixelRatio * 7,
          bottom: isEnd?MediaQuery.of(context).devicePixelRatio * 7:0
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title  ",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Text(
              "$detail",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
