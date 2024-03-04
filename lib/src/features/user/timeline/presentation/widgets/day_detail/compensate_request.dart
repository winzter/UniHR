import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestTimeCompensate extends StatelessWidget {
  final RequestCompensate e;
  const RequestTimeCompensate({super.key, required this.e});

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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/compensate_icon.svg"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  e.name!,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${AppLocalizations.of(context)!.status} : ",
                        style: TextStyle(fontSize: 17)),
                    Text(
                        "${e.isManagerLv1Approve == 1 ? "${AppLocalizations.of(context)!.approved}" : (e.isManagerLv1Approve == 0 ? "${AppLocalizations.of(context)!.notapproved}" : "${AppLocalizations.of(context)!.pendingapproval}")}",
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
              ],
            ))
          ],
        ),
      ),
    );
  }
}
