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

class ListWithdrawItems extends StatefulWidget {
  final int index;
  final bool? isSelectAll;
  final WithdrawLeaveManager? withdrawData;
  final PayrollSettingEntity payrollSettingData;
  // final String type;
  final WaitingStatusBloc bloc;

  const ListWithdrawItems(
      {super.key,
      required this.index,
      required this.withdrawData,
      required this.payrollSettingData,
      required this.bloc,
      required this.isSelectAll});

  @override
  State<ListWithdrawItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListWithdrawItems> {
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
                    "${AppLocalizations.of(context)!.hello == "Hello" ? widget.withdrawData!.firstnameEn : widget.withdrawData!.firstnameTh} ${AppLocalizations.of(context)!.hello == "Hello" ? widget.withdrawData!.lastnameEn : widget.withdrawData!.lastnameTh}",
                    style: GoogleFonts.kanit(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: () {
                    {
                      Text(
                        "${widget.withdrawData!.positionName!}",
                        style: GoogleFonts.kanit(
                            color: Color(0xff757575), fontSize: 15),
                      );
                    }
                  }(),
                  trailing: Text(
                    AppLocalizations.supportedLocales == "th"
                        ? "${widget.withdrawData!.name!}\n"
                        : "${widget.withdrawData!.name_EN ?? widget.withdrawData!.name!}\n",
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
                    if (widget.withdrawData != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.withdrawData!.start!.hour ==
                                  widget.withdrawData!.end!.hour &&
                              widget.withdrawData!.start!.minute ==
                                  widget.withdrawData!.end!.minute) ...[
                            Text(
                              AppLocalizations.of(context)!.start +
                                  DateFormat(" d/MM/yyyy\n")
                                      .format(widget.withdrawData!.start!) +
                                  AppLocalizations.of(context)!.fullday,
                              style: GoogleFonts.kanit(fontSize: 15),
                            ),
                            Text(
                              AppLocalizations.of(context)!.end +
                                  DateFormat(" d/MM/yyyy\n")
                                      .format(widget.withdrawData!.end!) +
                                  AppLocalizations.of(context)!.fullday,
                              style: GoogleFonts.kanit(fontSize: 15),
                            )
                          ] else ...[
                            Text(
                              AppLocalizations.of(context)!.start +
                                  DateFormat(" d/MM/yyyy\nHH:mm")
                                      .format(widget.withdrawData!.start!),
                              style: GoogleFonts.kanit(fontSize: 15),
                            ),
                            Text(
                              AppLocalizations.of(context)!.end +
                                  DateFormat(" d/MM/yyyy\nHH:mm")
                                      .format(widget.withdrawData!.end!),
                              style: GoogleFonts.kanit(fontSize: 15),
                            )
                          ]
                        ],
                      );
                    }
                  }(),
                ),
              ],
            ),
          ),
        ));
  }
}
