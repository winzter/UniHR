import 'package:flutter/material.dart';

AppBar appBar(BuildContext context,String title){
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: 80,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background_img.png"),
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover),
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
    ),
    leading: IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        )),
  );
}