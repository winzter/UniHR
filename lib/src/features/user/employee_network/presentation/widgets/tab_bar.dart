import 'package:flutter/material.dart';

class TabsMenu extends StatelessWidget {
  final String title;
  const TabsMenu({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              title,
              style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
