import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 5),
          child: Text(
            AppLocalizations.of(context)!.entryandexit,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30 * MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
