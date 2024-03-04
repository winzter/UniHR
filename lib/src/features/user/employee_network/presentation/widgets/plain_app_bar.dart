import 'package:flutter/material.dart';

PreferredSizeWidget plainAppBar(BuildContext context){
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
