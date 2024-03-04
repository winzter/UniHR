import 'package:flutter/material.dart';

PreferredSizeWidget appBarBluetooth(BuildContext context){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    title: Text(
      'Bluetooth Beacon',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    toolbarHeight: 120,
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
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.9)
                  ])
          ),
        ),
      ],
    ),
  );
}