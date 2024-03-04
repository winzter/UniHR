import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/core/provider/bottom_navbar/language_provider.dart';
import 'package:unihr/src/features/user/timeline/domain/entities/timeline_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveRequestDetail extends StatelessWidget {
  final LeaveEntity leaveData;
  const LeaveRequestDetail({Key? key, required this.leaveData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
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
                      SvgPicture.asset("assets/icons/break.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      '${localizationProvider.locale}' == 'th' ?
                        Text(
                          '${leaveData.name}',
                          style: TextStyle(fontSize: 18),
                        )
                        : Text(
                        '${leaveData.nameEN}',
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
                              Text(
                                "${AppLocalizations.of(context)!.status} : ",
                                style: TextStyle(fontSize: 17),
                              ),
                              Flexible(
                                  child: Text(
                                      "${
                                          leaveData.isActive == 0
                                          ? AppLocalizations.of(context)!
                                              .cancelitem
                                          : leaveData.isApprove == null
                                          ? AppLocalizations.of(context)!
                                          .pendingapproval
                                          : leaveData.isApprove == 1
                                          ? AppLocalizations.of(context)!
                                          .approved
                                          : AppLocalizations.of(context)!
                                          .notapproved}",
                                      style: TextStyle(fontSize: 17))),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${AppLocalizations.of(context)!.type} : ",
                                  style: TextStyle(fontSize: 17)),
                              Flexible(
                                  child:
                                      Text(
                                        '${localizationProvider.locale}' == 'th' ?
                                          '${leaveData.name}'
                                          : '${leaveData.nameEN}',
                                        style: TextStyle(fontSize: 17))
                                      )
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${AppLocalizations.of(context)!.time} : ",
                                  style: TextStyle(fontSize: 17)),
                              Text(
                                  "${DateFormat("HH:mm").format(
                                      leaveData.start!)} - ${DateFormat("HH:mm")
                                      .format(leaveData.end!)}",
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
                                  "${DateFormat("dd/MM/yy").format(
                                      leaveData.start!)} - ${DateFormat(
                                      "dd/MM/yy").format(leaveData.end!)}",
                                  style: TextStyle(fontSize: 17)),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${AppLocalizations.of(context)!
                                  .otherreason} : ",
                                  style: TextStyle(fontSize: 17)),
                              Flexible(
                                  child: Text(
                                      "${(leaveData.description ?? '') == ''
                                          ? '-'
                                          : leaveData.description}",
                                      style: TextStyle(fontSize: 17))),
                            ],
                          ),
                          const SizedBox(height: 3),
                        ],
                      ))
                ],
              ),
            ),
          );
        }
      );
  }
}
