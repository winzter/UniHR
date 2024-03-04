import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/shift_ot_entitiy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardDayData extends StatefulWidget {
  final ShiftAndOtEntity data;
  final int index;
  const CardDayData({super.key, required this.data, required this.index});

  @override
  State<CardDayData> createState() => _CardDayDataState();
}

class _CardDayDataState extends State<CardDayData> {
  Widget listTile(String title, String amount, Color color,
      [String detail = "0.00", bool isLoss = false]) {
    return detail != "0.00"
        ? ListTile(
            title: Text(
              title,
              style: TextStyle(color: const Color(0xff3D6670), fontSize: 18),
            ),
            trailing: title == "ขาดงาน"
                ? Text("${detail.toString()} วัน",
                    style: TextStyle(color: color, fontSize: 18))
                : Text(
                    NumberFormat("#,###.##").format(double.parse(amount)),
                    style: TextStyle(color: color, fontSize: 18),
                  ),
            subtitle: Text(
              (title != "ขาดงาน" && title != "มาสาย/กลับก่อน")
                  ? "$detail hr."
                  : "${DateFormat("dd MMM yyyy").format(widget.data.dock!.start!)} - ${DateFormat("dd MMM yyyy").format(widget.data.dock!.end!)}",
              style: TextStyle(color: const Color(0xffC4C4C4), fontSize: 18),
            ),
          )
        : ListTile(
            title: Text(
              title,
              style: TextStyle(color: const Color(0xff3D6670), fontSize: 18),
            ),
            trailing: title == "ขาดงาน"
                ? Text("$detail วัน",
                    style: TextStyle(color: color, fontSize: 18))
                : Text(
                    isLoss
                        ? "-${NumberFormat("#,###.##").format(double.parse(amount))}"
                        : NumberFormat("#,###.##").format(double.parse(amount)),
                    style: TextStyle(color: color, fontSize: 18),
                  ),
            subtitle: Text(
              (title != "ขาดงาน" && title != "มาสาย/กลับก่อน")
                  ? "$detail hr."
                  : "${DateFormat("dd MMM yyyy").format(widget.data.dock!.start!)} - ${DateFormat("dd MMM yyyy").format(widget.data.dock!.end!)}",
              style: TextStyle(color: const Color(0xffC4C4C4), fontSize: 18),
            ),
          );
  }

  Widget profitBox() {
    double sum = 0;
    if (widget.data.dataTable![widget.index].otOneAmount != null &&
        widget.data.dataTable![widget.index].otOneFiveAmount != null &&
        widget.data.dataTable![widget.index].otTwoAmount != null &&
        widget.data.dataTable![widget.index].otThreeAmount != null) {
      sum = (widget.data.dataTable![widget.index].otOneAmount! +
          widget.data.dataTable![widget.index].otOneFiveAmount! +
          widget.data.dataTable![widget.index].otTwoAmount! +
          widget.data.dataTable![widget.index].otThreeAmount! +
          widget.data.dataTable![widget.index].shiftPayTotal! -
          widget.data.dock!.lateEarly!.amount! -
          widget.data.dock!.absent!.amount!);
    }

    Color color;
    String text;
    if (sum < 0) {
      color = Colors.redAccent;
      text = "-฿${sum.toStringAsFixed(2)}";
    } else if (sum == 0) {
      color = const Color(0xff41BE06);
      text = "฿${sum.toStringAsFixed(2)}";
    } else {
      color = const Color(0xff41BE06);
      text = "+฿${sum.toStringAsFixed(2)}";
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  bool contains(String text) {
    return text.contains("OFF");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xff5C468A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (contains(widget
                      .data.dataTable![widget.index].dataRender!.shiftTypeName!
                      .toString())) ...[
                    Text(
                      "${widget.data.dataTable![widget.index].date!.substring(0, 12)} (หยุด)",
                      style: TextStyle(color: Colors.white, fontSize: 15.5),
                    ),
                  ] else ...[
                    Text(
                      "${widget.data.dataTable![widget.index].date!.substring(0, 10)} "
                      "(${widget.data.dataTable![widget.index].dataRender!.timeIn!.substring(0, 5)} "
                      "- ${widget.data.dataTable![widget.index].dataRender!.timeOut!.substring(0, 5)})",
                      style: TextStyle(color: Colors.white, fontSize: 15.5),
                    ),
                  ],
                  profitBox()
                ],
              ),
            ),
            listTile(
                "OT 1",
                "${widget.data.dataTable![widget.index].otOneAmount ?? 0}",
                const Color(0xff30B98F),
                (widget.data.dataTable![widget.index].otOneHours ?? 0)
                    .toStringAsFixed(2)),
            listTile(
                "OT 1.5",
                "${widget.data.dataTable![widget.index].otOneFiveAmount ?? 0}",
                const Color(0xff30B98F),
                (widget.data.dataTable![widget.index].otOneFiveHours ?? 0)
                    .toStringAsFixed(2)),
            listTile(
                "OT 2",
                "${widget.data.dataTable![widget.index].otTwoAmount ?? 0}",
                const Color(0xff30B98F),
                (widget.data.dataTable![widget.index].otTwoHours ?? 0)
                    .toStringAsFixed(2)),
            listTile(
                "OT 3",
                "${widget.data.dataTable![widget.index].otThreeAmount ?? 0}",
                const Color(0xff30B98F),
                (widget.data.dataTable![widget.index].otThreeHours ?? 0)
                    .toStringAsFixed(2)),
            listTile(
                "${AppLocalizations.of(context)!.shiftpaymorning}",
                "${widget.data.dataTable![widget.index].shiftPayMorning ?? 0}",
                const Color(0xff30B98F)),
            listTile(
                "${AppLocalizations.of(context)!.shiftpayafternoon}",
                "${widget.data.dataTable![widget.index].shiftPayAfternoon ?? 0}",
                const Color(0xff30B98F)),
            listTile(
                "${AppLocalizations.of(context)!.shiftpaynight}",
                "${widget.data.dataTable![widget.index].shiftPayNight ?? 0}",
                const Color(0xff30B98F)),
          ],
        ),
      ),
    );
  }
}
