import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/features/user/timeline/presentation/widgets/day_status.dart';
import '../../../domain/entities/timeline_entity.dart';
import '../status_icon_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Color dayColors(
  TimeLineEntity data,
) {
  switch (DateFormat('EE').format(data.date!)) {
    case "จ.":
      return const Color(0xffFFD953);
    case "อ.":
      return const Color(0xffFFB8E3);
    case "พ.":
      return const Color(0xff6ADFBB);
    case "พฤ.":
      return const Color(0xffFFA25F);
    case "ศ.":
      return const Color(0xff85CCFF);
    case "ส.":
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
    default:
      return const Color(0xffFF5F5F);
  }
}

PreferredSizeWidget tabData(TimeLineEntity data, BuildContext context) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "${AppLocalizations.of(context)!.shiftschedule} : ${data.pattern!.workingTypeName}",
          style: TextStyle(fontSize: 17),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.shifttype,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 5,
            ),
            if (data.pattern!.isWorkingDay == 0) ...[
              Text(
                data.pattern!.shiftTypeName ?? "",
                style: TextStyle(fontSize: 17),
              )
            ] else if (data.holiday != null) ...[
              Text(
                AppLocalizations.of(context)!.annualholiday,
                style: TextStyle(fontSize: 17),
              )
            ] else ...[
              Text(
                "${data.pattern!.timeIn!.substring(0, 5)} - ${data.pattern!.timeOut!.substring(0, 5)}",
                style: TextStyle(fontSize: 17),
              )
            ]
          ],
        )
      ],
    ),
  );
}

Widget showDate(TimeLineEntity data) {
  String dateTH = DateFormat('EEEE d  MMMM  yyyy').format(data.date!);
  return Text(
    dateTH,
    style: TextStyle(color: Colors.black),
  );
}

Widget reuseContainer(String title, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).devicePixelRatio * 7,
      vertical: MediaQuery.of(context).devicePixelRatio * 3,
    ),
    child: Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "-",
                style: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget showDetail(TimeLineEntity data, BuildContext context, String lang) {
  bool isCheckIn = data.attendanceDisplay != null &&
      data.attendanceDisplay!.isNotEmpty &&
      data.attendanceDisplay!.length > 1 &&
      data.attendanceDisplay!.last.checkIn != null;
  bool isCheckOut = data.attendanceDisplay != null &&
      data.attendanceDisplay!.isNotEmpty &&
      data.attendanceDisplay!.length > 1 &&
      data.attendanceDisplay!.last.checkOut != null;

  bool isLeave = false;
  if (data.leave!.isNotEmpty) {
    for (var i in data.leave!) {
      if (i.isApprove == 1) {
        isLeave = true;
        break;
      }
    }
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 7,
          vertical: MediaQuery.of(context).devicePixelRatio * 3,
        ),
        child: Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.showcheckin_out,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (isLeave) ...[
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/break.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        lang == 'th' ?
                          Text(
                            '${data.leave![0].name}',
                            style: TextStyle(fontSize: 17),
                          )
                          :Text(
                          '${data.leave![0].nameEN}',
                            style: TextStyle(fontSize: 17),
                          ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    )
                  ]
                  else if (data.absent == true) ...[
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/cancel.svg",
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.absent,
                        style: TextStyle(fontSize: 17),
                      )
                    ])
                  ]
                  else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        data.attendanceDisplay!.isNotEmpty &&
                                data.attendanceDisplay![0].checkIn != null
                            ? Text(
                                "${AppLocalizations.of(context)!.timein} ${data.attendanceDisplay![0].checkIn!.attendanceTextTime}",
                                style: TextStyle(fontSize: 18),
                              )
                            : Text(
                                "${AppLocalizations.of(context)!.timein} -",
                                style: TextStyle(fontSize: 18),
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        data.attendanceDisplay!.isNotEmpty &&
                                data.attendanceDisplay![0].checkOut != null
                            ? Text(
                                "${AppLocalizations.of(context)!.timeout} ${data.attendanceDisplay![0].checkOut!.attendanceTextTime}",
                                style: TextStyle(fontSize: 18),
                              )
                            : Text(
                                "${AppLocalizations.of(context)!.timeout} -",
                                style: TextStyle(fontSize: 18),
                              )
                      ],
                    ),
                  ]
                ],
              ),
              if ((isCheckIn || isCheckOut) &&
                  data.leave!.isEmpty &&
                  !data.absent!) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isCheckIn
                        ? Text(
                            "${AppLocalizations.of(context)!.timein} ${data.attendanceDisplay!.last.checkIn!.attendanceTextTime}",
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "${AppLocalizations.of(context)!.timein} -",
                            style: TextStyle(fontSize: 18),
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    isCheckOut
                        ? Text(
                            "${AppLocalizations.of(context)!.timeout} ${data.attendanceDisplay!.last.checkOut!.attendanceTextTime}",
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "${AppLocalizations.of(context)!.timeout} -",
                            style: TextStyle(fontSize: 18),
                          ),
                  ],
                )
              ]
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 7,
          vertical: MediaQuery.of(context).devicePixelRatio * 3,
        ),
        child: Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.status,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              StatusIconText(
                data: data,
              )
            ],
          ),
        ),
      ),
      data.isLate!
          ? DayStatus(
              title: AppLocalizations.of(context)!.late,
              fontColor: Colors.red,
              bgColor: const Color(0xffFFD7DB))
          : reuseContainer(AppLocalizations.of(context)!.late, context),
      data.isEarlyOut!
          ? DayStatus(
              title: AppLocalizations.of(context)!.leaveEarly,
              fontColor: Colors.red,
              bgColor: const Color(0xffFFD7DB))
          : reuseContainer(AppLocalizations.of(context)!.leaveEarly, context),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
      )
    ],
  );
}
