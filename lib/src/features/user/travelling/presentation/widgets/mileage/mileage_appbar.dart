import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

PreferredSizeWidget MileageAppBar(BuildContext context) {
  return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
        ),
      ),
      toolbarHeight: MediaQuery.of(context).size.height * 0.25,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/pink_mileage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.04,
            child: Image.asset("assets/images/map_pics.png", width: 170),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            bottom: MediaQuery.of(context).size.height * 0.035,
            child: Text(
              "${AppLocalizations.of(context)!.save} Mileage",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.45,
            top: MediaQuery.of(context).size.height * 0.09,
            child: SvgPicture.asset(
              "assets/icons/ellipse_red.svg",
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.1,
            top: MediaQuery.of(context).size.height * 0.04,
            child: SvgPicture.asset(
              "assets/icons/ellipse_red.svg",
              width: 15,
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.02,
            child: SvgPicture.asset(
              "assets/icons/ellipse_blue.svg",
              width: 15,
            ),
          ),
        ],
      ));
}
