import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtRequestDetail extends StatelessWidget {
  final OtEntity e;
  const OtRequestDetail({Key? key, required this.e}) : super(key: key);

  String otApproveStatus(OtEntity data) {
    if (data.isDoubleApproval == 1) {
      if (data.isManagerLv2Approve == 1) {
        return "อนุมัติ";
      } else if (data.isManagerLv2Approve == null) {
        return "รออนุมัติ";
      } else {
        return "ไม่อนุมัติ";
      }
    } else {
      if (data.isManagerLv1Approve == 1) {
        return "อนุมัติ";
      } else if (data.isManagerLv1Approve == null) {
        return "รออนุมัติ";
      } else {
        return "ไม่อนุมัติ";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC4C4C4)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/ot.svg"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                    AppLocalizations.of(context)!.overtimerequest,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            ExpandChild(
                child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                if (e.xOt != 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          e.isManagerLv1Approve == 1
                              ? "assets/icons/approve.svg"
                              : (e.isManagerLv1Approve == null
                                  ? "assets/icons/one.svg"
                                  : "assets/icons/cancel.svg"),
                          width: 25),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "OT x 1.5 = ${(e.xOt! / 60).toStringAsFixed(2)} Hr. ",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
                if (e.xWorkingDailyHoliday != 0 ||
                    e.xWorkingMonthlyHoliday != 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        e.isManagerLv1Approve == 1
                            ? "assets/icons/approve.svg"
                            : (e.isManagerLv1Approve == null
                                ? "assets/icons/one.svg"
                                : "assets/icons/cancel.svg"),
                        width: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "OT x 1 = ${(e.xWorkingDailyHoliday != 0 ? e.xWorkingDailyHoliday! / 60 : e.xWorkingMonthlyHoliday! / 60).toStringAsFixed(2)} Hr. ",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
                if (e.xOtHoliday != 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(e.isManagerLv2Approve == 1
                          ? "assets/icons/approve.svg"
                          : (e.isManagerLv2Approve == null
                              ? "assets/icons/two.svg"
                              : "assets/icons/notpass.svg")),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "OT x 3 = ${(e.xOtHoliday! / 60).toStringAsFixed(2)} Hr. ",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${AppLocalizations.of(context)!.status} : ",
                        style: TextStyle(fontSize: 17)),
                    Text(
                        otApproveStatus(e) == "รออนุมัติ"
                            ? AppLocalizations.of(context)!.pendingapproval
                            : otApproveStatus(e) == "อนุมัติ"
                                ? AppLocalizations.of(context)!.approved
                                : AppLocalizations.of(context)!.notapproved,
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${AppLocalizations.of(context)!.time} : ",
                        style: TextStyle(fontSize: 17)),
                    Text(
                        "${DateFormat("HH:mm").format(e.start!)} - ${DateFormat("HH:mm").format(e.end!)}",
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${AppLocalizations.of(context)!.date} : ",
                        style: TextStyle(fontSize: 17)),
                    Text(
                        "${DateFormat("dd/MM/yy").format(e.start!)} - ${DateFormat("dd/MM/yy").format(e.end!)}",
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppLocalizations.of(context)!.reason} : ",
                        style: TextStyle(fontSize: 17)),
                    Flexible(
                        child: Text("${e.reasonName!}",
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppLocalizations.of(context)!.otherreason} : ",
                        style: TextStyle(fontSize: 17)),
                    Flexible(
                        child: Text(
                            "${e.otherReason == '' ? '-' : e.otherReason}",
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppLocalizations.of(context)!.comment} Lv1 : ",
                        style: TextStyle(fontSize: 17)),
                    Flexible(
                        child: Text(
                            "${e.commentManagerLv1 == '' || e.commentManagerLv1 == null ? '-' : e.commentManagerLv1}",
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppLocalizations.of(context)!.comment}  Lv2 : ",
                        style: TextStyle(fontSize: 17)),
                    Flexible(
                        child: Text(
                            "${e.commentManagerLv2 == '' || e.commentManagerLv2 == null ? '-' : e.commentManagerLv2}",
                            style: TextStyle(fontSize: 17))),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
