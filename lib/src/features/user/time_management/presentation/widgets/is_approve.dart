import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intl/intl.dart';
import '../../domain/entities/enitities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IsApprove extends StatelessWidget {
  final TimeScheduleEntity data;
  final Map<int, List<dynamic>> shiftData;
  final int? index;

  const IsApprove(
      {super.key, required this.data, this.index, required this.shiftData});

  @override
  Widget build(BuildContext context) {
    return index != null
        ? ListTile(
            leading: SvgPicture.asset(
              data.requestChange![index!].isApprove == 1
                  ? "assets/icons/approve.svg"
                  : (data.requestChange![index!].isApprove == 0
                      ? "assets/icons/cancel.svg"
                      : "assets/icons/question.svg"),
              width: 25,
            ),
            minLeadingWidth: 10,
            title:Text(
              data.requestChange![index!].isWorkingDay == 0
                  ? (data.requestChange![index!].idHoliday != null
                      ? AppLocalizations.of(context)!.publicholiday
                      : AppLocalizations.of(context)!.dayoff)
                  // : "${shiftData[data.requestChange![index!].idShiftGroup]}",
                  : "${shiftData[data.requestChange![index!].idShiftType]![0]}",
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              "${AppLocalizations.of(context)!.create} ${DateFormat("dd/MM/yyyy\nHH:mm").format(data.requestChange![index!].createDate!)}",
              style: TextStyle(fontSize: 14, color: Color(0xff757575)),
              textAlign: TextAlign.end,
            ),
            subtitle: Text(
              "${data.requestChange![index!].isApprove == 1 ? "(${AppLocalizations.of(context)!.approved})" : (data.requestChange![index!].isApprove == 0 ? "(${AppLocalizations.of(context)!.notapproved})" : "(${AppLocalizations.of(context)!.pendingapproval})")}",
              style: TextStyle(color: Color(0xff757575)),
              textAlign: TextAlign.start,
            ),
          )
        : Stack(
            children: [
              ListTile(
                leading: badges.Badge(
                  showBadge: data.requestChange!.length > 1,
                  position: badges.BadgePosition.topEnd(
                      top: MediaQuery.of(context).size.height * -0.015),
                  badgeContent: Text(
                    '${data.requestChange!.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: SvgPicture.asset(
                    data.requestChange!.last.isApprove == 1
                        ? "assets/icons/approve.svg"
                        : (data.requestChange!.last.isApprove == 0
                            ? "assets/icons/cancel.svg"
                            : "assets/icons/question.svg"),
                    width: 25,
                  ),
                ),
                minLeadingWidth: 10,
                title: Text(
                  data.requestChange!.last.isWorkingDay == 0
                      ? (data.requestChange!.last.idHoliday != null
                          ? AppLocalizations.of(context)!.publicholiday
                          : AppLocalizations.of(context)!.dayoff)
                      : "${shiftData[data.requestChange!.first.idShiftType]![0]}",
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
                ),
                trailing: Text(
                  "${AppLocalizations.of(context)!.create} ${DateFormat("dd/MM/yyyy\nHH:mm").format(data.requestChange!.last.createDate!)}",
                  style: TextStyle(fontSize: 14, color: Color(0xff757575)),
                  textAlign: TextAlign.end,
                ),
                subtitle: Text(
                  "${data.requestChange!.last.isApprove == 1 ? "(${AppLocalizations.of(context)!.approved})" : (data.requestChange!.last.isApprove == 0 ? "(${AppLocalizations.of(context)!.notapproved})" : "(${AppLocalizations.of(context)!.pendingapproval})")}",
                  style: TextStyle(color: Color(0xff757575), fontSize: 12),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          );
  }
}
