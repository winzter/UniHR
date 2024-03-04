import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:unihr/src/features/user/item_status/domain/entities/entities.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/waiting_status_bloc.dart';
import '../../providers/radio_button_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListOTItems extends StatefulWidget {
  final int index;
  final bool? isSelectAll;
  final LeaveRequestManager? dataLeave;
  final RequestTimeManager? requestTime;
  final PayrollSettingEntity payrollSettingData;
  // final String type;
  final WaitingStatusBloc bloc;

  const ListOTItems(
      {super.key,
      required this.index,
      this.dataLeave,
      this.requestTime,
      // required this.type,
      required this.payrollSettingData,
      required this.bloc,
      required this.isSelectAll});

  @override
  State<ListOTItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListOTItems> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ManagerRadioButtonProvider>(context);
    item.selectedFlag.contains(widget.index)
        ? isSelected = true
        : isSelected = false;
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
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
          backgroundBuilder: (context, direction, progress) {
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
          key: UniqueKey(),
          child: Container(
            decoration: BoxDecoration(
                color: isSelected ? Color(0xffE8FFF8) : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      item.onTap(widget.index);
                    });
                  },
                  title: Text(
                    widget.dataLeave == null
                        ? "${AppLocalizations.of(context)!.hello == "Hello" ? widget.requestTime!.firstnameEn : widget.requestTime!.firstnameTh} ${AppLocalizations.of(context)!.hello == "Hello" ? widget.requestTime!.lastnameEn : widget.requestTime!.lastnameTh}"
                        : "${AppLocalizations.of(context)!.hello == "Hello" ? widget.dataLeave!.firstnameTh : widget.dataLeave!.firstnameTh} ${AppLocalizations.of(context)!.hello == "Hello" ? widget.dataLeave!.lastnameTh : widget.dataLeave!.lastnameTh}",
                    style: GoogleFonts.kanit(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: () {
                    if (widget.dataLeave != null) {
                      return Text(
                        "${widget.dataLeave!.positionName!}",
                        style: GoogleFonts.kanit(
                            color: Color(0xff757575), fontSize: 15),
                      );
                    } else {
                      return Text("${widget.requestTime!.positionName!}",
                          style: GoogleFonts.kanit(
                              color: Color(0xff757575), fontSize: 15));
                    }
                  }(),
                  trailing: Text(
                    widget.dataLeave != null
                        ? "${widget.dataLeave!.name!}\n"
                        : "${widget.requestTime!.name!}\n",
                    style: GoogleFonts.kanit(fontSize: 15),
                  ),
                ),
                ListTile(
                  title: Divider(),
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      item.onTap(widget.index);
                    });
                  },
                  subtitle: () {
                    if (widget.dataLeave != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.dataLeave!.start!.hour ==
                                  widget.dataLeave!.end!.hour &&
                              widget.dataLeave!.start!.minute ==
                                  widget.dataLeave!.end!.minute) ...[
                            Text(
                              AppLocalizations.of(context)!.start +
                                  DateFormat(" d/MM/yyyy\n")
                                      .format(widget.dataLeave!.start!) +
                                  AppLocalizations.of(context)!.fullday,
                              style: GoogleFonts.kanit(fontSize: 15),
                            ),
                            Text(
                              AppLocalizations.of(context)!.end +
                                  DateFormat(" d/MM/yyyy\n")
                                      .format(widget.dataLeave!.end!) +
                                  AppLocalizations.of(context)!.fullday,
                              style: GoogleFonts.kanit(fontSize: 15),
                            )
                          ] else ...[
                            Text(
                              AppLocalizations.of(context)!.start +
                                  DateFormat(" d/MM/yyyy\nHH:mm")
                                      .format(widget.dataLeave!.start!),
                              style: GoogleFonts.kanit(fontSize: 15),
                            ),
                            Text(
                              AppLocalizations.of(context)!.end +
                                  DateFormat(" d/MM/yyyy\nHH:mm")
                                      .format(widget.dataLeave!.end!),
                              style: GoogleFonts.kanit(fontSize: 15),
                            )
                          ]
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.requestTime!.start!.hour ==
                                  widget.requestTime!.end!.hour &&
                              widget.requestTime!.start!.minute ==
                                  widget.requestTime!.end!.minute) ...[
                            Text(
                              AppLocalizations.of(context)!.start +
                                  DateFormat(" d/MM/yyyy\n")
                                      .format(widget.requestTime!.start!) +
                                  AppLocalizations.of(context)!.fullday,
                              style: GoogleFonts.kanit(fontSize: 15),
                            ),
                            Text(
                              AppLocalizations.of(context)!.end +
                                  DateFormat(" d/MM/yyyy\n")
                                      .format(widget.requestTime!.end!) +
                                  AppLocalizations.of(context)!.fullday,
                              style: GoogleFonts.kanit(fontSize: 15),
                            )
                          ] else ...[
                            Text(
                              AppLocalizations.of(context)!.start +
                                  DateFormat(" d/MM/yyyy\nHH:mm")
                                      .format(widget.requestTime!.start!),
                              style: GoogleFonts.kanit(fontSize: 15),
                            ),
                            Text(
                              AppLocalizations.of(context)!.end +
                                  DateFormat(" d/MM/yyyy\nHH:mm")
                                      .format(widget.requestTime!.end!),
                              style: GoogleFonts.kanit(fontSize: 15),
                            )
                          ]
                        ],
                      );
                    }
                  }(),
                ),
                ExpandChild(
                    indicatorCollapsedHint: "",
                    indicatorExpandedHint: "",
                    indicatorPadding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.dataLeave == null &&
                                    (widget.requestTime!.xOt != 0 ||
                                        widget.requestTime!
                                                .xWorkingDailyHoliday !=
                                            0 ||
                                        widget.requestTime!.xOtHoliday != 0 ||
                                        widget.requestTime!
                                                .xWorkingMonthlyHoliday !=
                                            0)) ...[
                                  Text(
                                      "${AppLocalizations.of(context)!.overtimehours}",
                                      style: GoogleFonts.kanit(fontSize: 15)),
                                  if (widget.requestTime!.xOt != 0)
                                    Text(
                                        "OT x 1 = ${(widget.requestTime!.xOt! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                        style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            color: const Color(0xff757575))),
                                  if (widget
                                          .requestTime!.xWorkingDailyHoliday !=
                                      0)
                                    Text(
                                        "OT x 1.5 = ${(widget.requestTime!.xWorkingDailyHoliday! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                        style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            color: const Color(0xff757575))),
                                  if (widget.requestTime!
                                          .xWorkingMonthlyHoliday !=
                                      0)
                                    Text(
                                        "OT x 1.5 = ${(widget.requestTime!.xWorkingMonthlyHoliday! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                        style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            color: const Color(0xff757575))),
                                  if (widget.requestTime!.xOtHoliday != 0)
                                    Text(
                                        "OT x 3 = ${(widget.requestTime!.xOtHoliday! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                        style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            color: const Color(0xff757575))),
                                  const Divider(),
                                ]
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.dataLeave == null) ...[
                                  Text("${widget.requestTime!.reasonName}",
                                      style: GoogleFonts.kanit(fontSize: 15)),
                                  Text(
                                      "${AppLocalizations.of(context)!.otherreason} : ${widget.requestTime!.otherReason == "" ? "-" : widget.requestTime!.otherReason}",
                                      style: GoogleFonts.kanit(
                                          fontSize: 15,
                                          color: const Color(0xff757575)))
                                ] else ...[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${AppLocalizations.of(context)!.reason}",
                                            style: GoogleFonts.kanit(
                                                fontSize: 15)),
                                      ]),
                                  Text(
                                      "${widget.dataLeave!.description == null || widget.dataLeave!.description == "" ? "-" : widget.dataLeave!.description}",
                                      style: GoogleFonts.kanit(
                                          fontSize: 15,
                                          color: const Color(0xff757575))),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
