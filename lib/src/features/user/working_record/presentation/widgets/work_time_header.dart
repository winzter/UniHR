import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkRecordHeader extends StatelessWidget {
  const WorkRecordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.blueGrey),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${AppLocalizations.of(context)!.date}",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 21)),
                    ],
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(DateTime.now()),
                    style: TextStyle(fontSize: 21),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined,
                          color: Colors.blueGrey),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.time}",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 21),
                      ),
                    ],
                  ),
                  DigitalClock(
                    showSecondsDigit: false,
                    hourMinuteDigitTextStyle:
                        TextStyle(fontSize: 21, color: Colors.black),
                    colon: Text(":",
                        style: TextStyle(color: Colors.black, fontSize: 21)),
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
