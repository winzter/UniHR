import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderDetail extends StatelessWidget {
  final DateTime workDate;

  final String workTime;
  const HeaderDetail(
      {super.key, required this.workDate, required this.workTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${AppLocalizations.of(context)!.workingday}: ${DateFormat('dd/MM/yyyy').format(workDate)}",
                style: TextStyle(fontSize: 17, color: Colors.grey),
              )
            ],
          ),
          Row(
            children: [
              Text(
                workTime,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
