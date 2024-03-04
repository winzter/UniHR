import 'package:flutter/material.dart';

class EditAppbar extends StatelessWidget {
  final String title;
  const EditAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: 150,
          child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                  )),
              elevation: 0,
              toolbarHeight: 80,
              centerTitle: true,
              flexibleSpace: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background_img.png"),
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
                        Colors.white.withOpacity(0.4)
                      ])),
                ),
              ]),
              primary: false,
              title: Text(
                "$title",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
        ));
  }
}
