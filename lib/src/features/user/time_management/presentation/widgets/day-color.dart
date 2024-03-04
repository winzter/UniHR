import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/enitities.dart';
import '../bloc/time_management_bloc.dart';
import 'is_approve.dart';
import 'is_approve_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Color dayColors(TimeScheduleEntity data) {
  switch (DateFormat('EE').format(data.date!)) {
    case "จ." || 'Mon':
      return const Color(0xffFFD953);
    case "อ." || 'Tue':
      return  const Color(0xffFFB8E3);
    case "พ." || 'Wed':
      return const Color(0xff6ADFBB);
    case "พฤ." || 'Thu':
      return const Color(0xffFFA25F);
    case "ศ." || 'Fri':
      return const Color(0xff85CCFF);
    case "ส." || 'Sat':
      return const Color(0xffCE90FF);
    case "อา.":
      return const Color(0xffFF5F5F);
    case "Mon":
      return const Color(0xffFFD953);
    case "Tue":
      return const Color(0xffFFB8E3);
    case "Wed":
      return const Color(0xff6ADFBB);
    case "Thu":
      return const Color(0xffFFA25F);
    case "Fri":
      return const Color(0xff85CCFF);
    case "Sat":
      return const Color(0xffCE90FF);
    case "Sun":
      return const Color(0xffFF5F5F);
    default:
      return const Color(0xffFF5F5F);
  }
}

Widget showDate(TimeScheduleEntity data) {
  String dateTH = DateFormat('EEEE d  MMMM  yyyy').format(data.date!);
  return Text(
    dateTH,
    style: TextStyle(color: Colors.black),
  );
}

PreferredSizeWidget tabData(TimeScheduleEntity data, BuildContext context) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "${AppLocalizations.of(context)!.shiftschedule} : ${data.dataRender!.workingTypeName!}",
          style: TextStyle(fontSize: 17),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.workingtime,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              data.dataRender!.shiftName ?? "",
              style: TextStyle(fontSize: 17),
            )
          ],
        )
      ],
    ),
  );
}

Widget showDetail(
    TimeScheduleEntity data, BuildContext context, Map<int, List<dynamic>> shiftName,
    {List<TimeScheduleEntity>? listOfData,
    int? index,
    TimeManagementBloc? bloc,
    Map<int,String>? holidayData}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 7,
          vertical: MediaQuery.of(context).devicePixelRatio * 3,
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  if (data.requestChange!.length > 0) ...[
                    IsApprove(
                      data: data,
                      index: index,
                      shiftData: shiftName,
                    ),
                    if (data.requestChange!.last.idHoliday != null) ...[
                      ListTile(
                        title: Divider(),
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
                                    "${holidayData![data.requestChange!.last.idHoliday]}")),
                          ],
                        ),
                      ),
                    ],
                    IsApproveDetail(
                      data: data,
                      bloc: bloc!,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
