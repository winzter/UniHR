import 'package:flutter/material.dart';

PreferredSizeWidget empNetworkAppbar(BuildContext context){
  return AppBar(
    scrolledUnderElevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    title: Text(
      'Employee Network',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    toolbarHeight: MediaQuery.of(context).size.height*0.1,
    elevation: 0,
    centerTitle: true,
    flexibleSpace: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_img.png"),
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //             Colors.white.withOpacity(0),
        //             Colors.white.withOpacity(0),
        //             Colors.white.withOpacity(0.2),
        //             Colors.white.withOpacity(0.9)
        //           ])
        //   ),
        // ),
      ],
    ),
  );
}