import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardDayDetail extends StatefulWidget {
  final double sumOT;
  final double sumShiftMorning;
  final double sumShiftNoon;
  final double sumShiftNight;
  final double sumLoss;

  const CardDayDetail(
      {super.key,
      required this.sumOT,
      required this.sumShiftMorning,
      required this.sumShiftNoon,
      required this.sumShiftNight,
      required this.sumLoss});

  @override
  State<CardDayDetail> createState() => _CardDayDetailState();
}

class _CardDayDetailState extends State<CardDayDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "OT ฿ ${NumberFormat("#,###.##").format(widget.sumOT)}",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              "${AppLocalizations.of(context)!.shiftpaymorning}  ฿ ${NumberFormat("#,###.##").format(widget.sumShiftMorning)}",
              /* ****************************************************************************** */
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${AppLocalizations.of(context)!.shiftpayafternoon}  ฿ ${NumberFormat("#,###.##").format(widget.sumShiftNoon)}",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              "${AppLocalizations.of(context)!.shiftpaynight}  ฿ ${NumberFormat("#,###.##").format(widget.sumShiftNight)}",
              /* ****************************************************************************** */
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff30B98F),
                      child: Icon(
                        Icons.arrow_downward_sharp,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.addition,
                      style: TextStyle(
                          color: const Color(0xff94AFB6), fontSize: 15),
                    ),
                    Text(
                      "฿${NumberFormat("#,###.##").format(widget.sumShiftNight + widget.sumShiftNoon + widget.sumShiftMorning + widget.sumOT)}",
                      /* ****************************************************************************** */
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xffFF6575),
                      child: Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deduction,
                      style: TextStyle(
                          color: const Color(0xff94AFB6), fontSize: 15),
                    ),
                    Text(
                      "฿${NumberFormat("#,###.##").format(widget.sumLoss)}",
                      /* ****************************************************************************** */
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
