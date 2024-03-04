import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    toolbarHeight: 90,
    flexibleSpace: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                Color(0xff69EAC6),
                Color(0xff6FC9E4),
                Color(0xff5B4589),
              ])),
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
      ],
    ),
    centerTitle: true,
    title: Text(
      AppLocalizations.of(context)!.request_list,
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
