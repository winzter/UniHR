import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/payslip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayslipDetail extends StatefulWidget {
  final PayslipEntity data;
  const PayslipDetail({super.key, required this.data});

  @override
  State<PayslipDetail> createState() => _PayslipDetailState();
}

class _PayslipDetailState extends State<PayslipDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${AppLocalizations.of(context)!.netpay}       ",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "฿ ${NumberFormat("#,###.##").format(widget.data.totalEarnings! - widget.data.totalDeductions!)}",
              style: TextStyle(color: Colors.white, fontSize: 27),
            )
          ],
        ),
        const SizedBox(
          height: 15,
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
                      "${AppLocalizations.of(context)!.totalIncome}",
                      style: TextStyle(
                          color: const Color(0xff94AFB6), fontSize: 15),
                    ),
                    Text(
                      "฿${NumberFormat("#,###.##").format(widget.data.totalEarnings!)}",
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
                    Text("${AppLocalizations.of(context)!.totalDeduction}",
                        style: TextStyle(
                            color: const Color(0xff94AFB6), fontSize: 15)),
                    Text(
                        "฿${NumberFormat("#,###.##").format(widget.data.totalDeductions)}",
                        style: TextStyle(color: Colors.white, fontSize: 18))
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
