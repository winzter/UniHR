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

class ListItemsChangeTime extends StatefulWidget {
  final int index;
  final bool? isSelectAll;
  final ChangeTimeManager changeTimeData;
  final PayrollSettingEntity payrollSettingData;
  // final String type;
  final WaitingStatusBloc bloc;

  const ListItemsChangeTime({
    super.key,
    required this.index,
    required this.changeTimeData,
    // required this.type,
    required this.payrollSettingData,
    required this.bloc,
    required this.isSelectAll,
  });

  @override
  State<ListItemsChangeTime> createState() => _ListItemsChangeTimeState();
}

class _ListItemsChangeTimeState extends State<ListItemsChangeTime> {
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
                  isThreeLine: true,
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      item.onTap(widget.index);
                    });
                  },
                  title: Text(
                    AppLocalizations.supportedLocales == "th"
                        ? "${widget.changeTimeData.firstnameTh} ${widget.changeTimeData.lastnameTh}"
                        : "${widget.changeTimeData.firstname_EN} ${widget.changeTimeData.lastname_EN}",
                    style: GoogleFonts.kanit(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    AppLocalizations.supportedLocales == "th"
                        ? "${widget.changeTimeData.positionName!}"
                        : "${widget.changeTimeData.positionName_EN ?? widget.changeTimeData.positionName!}",
                    style: GoogleFonts.kanit(
                        color: Color(0xff757575), fontSize: 15),
                  ),
                  trailing: Text(
                    widget.changeTimeData.idHoliday != null
                        ? "วันหยุดนักขัตฤกษ์"
                        : (widget.changeTimeData.isWorkingDay == 0
                            ? "วันหยุด"
                            : "${widget.changeTimeData.shiftGroupName}"),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.kanit(fontSize: 15),
                  ),
                ),
                if (widget.changeTimeData.idHoliday != null) ...[
                  ListTile(
                    title: Divider(),
                    onTap: () {
                      setState(() {
                        isSelected = !isSelected;
                        item.onTap(widget.index);
                      });
                    },
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.publicholiday} : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: Text(
                          "${widget.changeTimeData.holidayName!}",
                          style: GoogleFonts.kanit(fontSize: 15),
                        )),
                      ],
                    ),
                  ),
                ],
                ListTile(
                  title: Divider(),
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      item.onTap(widget.index);
                    });
                  },
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.date +
                            DateFormat(" : d MMM yyyy")
                                .format(widget.changeTimeData.workingDate!),
                        style: GoogleFonts.kanit(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
