import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:unihr/src/features/manager/overview/presentation/widgets/overview_menu/leave_history_app_bar.dart';
import '../../domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthLeaveList extends StatelessWidget {
  final DateTime? date;
  final OverviewEntity? overviewData;

  const MonthLeaveList({super.key, this.date, this.overviewData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context,
          "${AppLocalizations.of(context)!.leavelist}${date != null ? AppLocalizations.of(context)!.month + DateFormat("MMMM").format(date!) : ''}"),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).devicePixelRatio * 6,
            horizontal: MediaQuery.of(context).devicePixelRatio * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (overviewData != null &&
                overviewData!.workingTimeEmployeeInfo!.leave!.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      overviewData!.workingTimeEmployeeInfo!.leave!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).devicePixelRatio * 3),
                      child: SwipeableTile.card(
                        horizontalPadding: 4,
                        verticalPadding: 0,
                        color: Colors.white,
                        shadow: BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                        swipeThreshold: 0.7,
                        direction: SwipeDirection.none,
                        onSwiped: (_) {},
                        key: UniqueKey(),
                        backgroundBuilder: (BuildContext context,
                            SwipeDirection direction,
                            AnimationController progress) {
                          return AnimatedBuilder(
                            animation: progress,
                            builder: (context, child) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                color: const Color(0xFFed7474),
                              );
                            },
                          );
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  AppLocalizations.supportedLocales == "th"
                                      ? "${overviewData!.workingTimeEmployeeInfo!.leave![index].firstnameTh ?? 'ไม่ระบุ'} ${overviewData!.workingTimeEmployeeInfo!.leave![index].lastnameTh ?? 'ไม่ระบุ'}"
                                      : "${overviewData!.workingTimeEmployeeInfo!.leave![index].firstnameEn ?? 'ไม่ระบุ'} ${overviewData!.workingTimeEmployeeInfo!.leave![index].lastnameEn ?? 'ไม่ระบุ'}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  AppLocalizations.supportedLocales == "th"
                                      ? "${overviewData!.workingTimeEmployeeInfo!.leave![index].name ?? 'ไม่ระบุ'}"
                                      : "${overviewData!.workingTimeEmployeeInfo!.leave![index].nameEn ?? 'ไม่ระบุ'}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ListTile(
                                title: Divider(
                                  thickness: 1,
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.start +
                                          DateFormat(
                                                  " dd/MM/yyyy\n${overviewData!.workingTimeEmployeeInfo!.leave![index].isFullDay == 1 ? '${AppLocalizations.of(context)!.fullday}' : 'HH:mm'}")
                                              .format(overviewData!
                                                  .workingTimeEmployeeInfo!
                                                  .leave![index]
                                                  .start!),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.end +
                                          DateFormat(
                                                  " dd/MM/yyyy\n${overviewData!.workingTimeEmployeeInfo!.leave![index].isFullDay == 1 ? '${AppLocalizations.of(context)!.fullday}' : 'HH:mm'}")
                                              .format(overviewData!
                                                  .workingTimeEmployeeInfo!
                                                  .leave![index]
                                                  .end!),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Divider(
                                  thickness: 1,
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      "${AppLocalizations.of(context)!.reason}: ${overviewData!.workingTimeEmployeeInfo!.leave![index].description}",
                                      textAlign: TextAlign.start,
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ] else ...[
              Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.thereisnoleavelist}${date != null ? AppLocalizations.of(context)!.month + DateFormat("MMMM").format(date!) : ''}",
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ]
          ],
        ),
      ),
    );
  }
}
