import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusListIcon extends StatelessWidget {
  const StatusListIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD9D9D9)),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.variousstatusformats,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusIcon(
                    title: "${AppLocalizations.of(context)!.approved}",
                    path: "assets/icons/approve.svg"),
                StatusIcon(
                    title: AppLocalizations.of(context)!.notapproved ==
                            "not approved"
                        ? "not \napproved"
                        : AppLocalizations.of(context)!.notapproved,
                    path: "assets/icons/cancel.svg"),
                StatusIcon(
                    title: AppLocalizations.of(context)!.pendingapproval ==
                            "pend approval"
                        ? "pend \napproval"
                        : AppLocalizations.of(context)!.pendingapproval,
                    path: "assets/icons/question.svg"),
                StatusIcon(
                    title: "${AppLocalizations.of(context)!.waitforthe1st}",
                    path: "assets/icons/one.svg"),
                StatusIcon(
                    title: AppLocalizations.of(context)!.cancelitem ==
                            "ยกเลิกรายการ"
                        ? AppLocalizations.of(context)!.cancelitem
                        : "cancel \nitem",
                    path: "assets/icons/grey_cancle.svg"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusIcon extends StatelessWidget {
  final String title;
  final String path;
  const StatusIcon({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          path,
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
