import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BenefitBox extends StatefulWidget {
  final String title;
  final num total;
  num profit1;
  num profit2;
  BenefitBox(
      {super.key,
      required this.title,
      required this.total,
      this.profit1 = 0,
      this.profit2 = 0});

  @override
  State<BenefitBox> createState() => _BenefitBoxState();
}

class _BenefitBoxState extends State<BenefitBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.40),
            Color.fromRGBO(255, 255, 255, 0.40),
          ],
          stops: [0.0, 1.0],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.profit1 != 0
                    ? "+ ${NumberFormat("#,###.##").format(widget.profit1)}"
                    : "",
                style: TextStyle(color: const Color(0xff96FFDF), fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.profit2 != 0
                    ? "+ ${NumberFormat("#,###.##").format(widget.profit2)}"
                    : "",
                style: TextStyle(color: const Color(0xff96FFDF), fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.total,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "฿ ${NumberFormat("#,###.##").format(widget.total)}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
