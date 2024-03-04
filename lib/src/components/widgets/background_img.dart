import 'package:flutter/material.dart';

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/employees_list_manager/background_img.png"),
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
                    Colors.white.withOpacity(0.95)
                  ])
          ),
        ),
      ],
    );
  }
}
