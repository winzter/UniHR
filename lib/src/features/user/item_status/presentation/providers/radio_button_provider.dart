import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RadioButtonProvider extends ChangeNotifier {
  String _type = "all";

  String get type => _type;

  void setType(String userType) {
    // log("$userType");
    _type = userType;
    notifyListeners();
  }

  String isFullDay(DateTime start, DateTime end, BuildContext context) {
    if (DateFormat('HH:mm').format(start) == "00:00" &&
        DateFormat('HH:mm').format(end) == "00:00") {
      return "     ${AppLocalizations.of(context)!.fullday}";
    } else {
      return "${DateFormat('HH:mm').format(start)} - ${DateFormat('HH:mm').format(end)}";
    }
  }
}
