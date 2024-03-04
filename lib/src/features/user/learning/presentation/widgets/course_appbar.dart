import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar CourseAppbar(BuildContext context, String title) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: MediaQuery.of(context).size.height * 0.1,
    flexibleSpace: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                Color(0xff6FC9E4),
                Color(0xffE793B8),
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
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        )),
    centerTitle: true,
    title: Text(
      title,
      style: GoogleFonts.kanit(
          fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}
