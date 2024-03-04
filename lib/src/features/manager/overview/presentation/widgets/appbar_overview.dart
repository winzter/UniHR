import 'package:flutter/material.dart';

PreferredSizeWidget appBarOverview(BuildContext context,String title){
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios_sharp, size: 30),
    ),
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: MediaQuery.of(context).size.height*0.1,
    flexibleSpace: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffF9A47A),
                    Color(0xffE793B8),
                    Color(0xff6FC9E4),
                  ])),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.3)
                  ])),
        ),
      ],
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
    ),
  );
}