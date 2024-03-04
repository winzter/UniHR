import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBarLearning(
    BuildContext context, String title, void Function()? callbackAction) {
  return AppBar(
    actions: [
      if (callbackAction != null)
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.25), // border color
              shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(2, 3),
                  ),
                ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff6FC9E4),
                    Color(0xffE793B8),
                  ]
              )
            ),
            child: Center(
              child: IconButton(
                  onPressed: (){
                    callbackAction();
                  },
                  icon: SvgPicture.asset("assets/icons/learning_user/search_icon.svg")),
            ),
          ),
        ),
    ],
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
