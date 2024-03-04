import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:unihr/src/core/provider/bottom_navbar/language_provider.dart';
import 'package:unihr/src/core/provider/bottom_navbar/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final List<String> languageList = ["us","th"];

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
      var groupValue = localizationProvider.locale.languageCode;
      return Scaffold(
        appBar: AppBar(
          title: Text('${AppLocalizations.of(context)!.language}'),
        ),
        body: ListView.builder(
          itemCount: languageModel.length,
          itemBuilder: (context, index) {
            var item = languageModel[index];
            return RadioListTile(
              value: item.languageCode,
              groupValue: groupValue,
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/${languageList[index]}.svg",height: 20,),
                  const SizedBox(width: 5,),
                  Text(item.language,style: TextStyle(fontSize: 20),),
                ],
              ),
              subtitle: Text(item.subLanguage),
              onChanged: (value) {
                groupValue = value.toString();
                localizationProvider.setLocale(Locale(item.languageCode));
                Restart.restartApp();
              },
            );
          },
        ),
      );
    });
  }
}
