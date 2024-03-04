import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../item_status/domain/entities/entities.dart';

class ApproveListTile extends StatelessWidget {
  final LeaveEntity? dataLeave;
  final RequestTimeEntity? requestTime;
  const ApproveListTile({super.key, required this.dataLeave, required this.requestTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).devicePixelRatio * 2,
          horizontal: MediaQuery.of(context).devicePixelRatio * 4),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: const Color(0xffc4c4c4)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                if (dataLeave != null) ...[
                  SvgPicture.asset(
                    "assets/icons/approve.svg",
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              dataLeave!.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              DateFormat("dd/MM/yyyy")
                                  .format(
                                  dataLeave!.start!),
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              dataLeave!.isFullDay == 1
                                  ? "เต็มวัน"
                                  : "${DateFormat("HH:mm").format(dataLeave!.start!)} "
                                  "- ${DateFormat("HH:mm").format(dataLeave!.end!)}",
                              style: TextStyle(),
                            ),
                            Text(
                              "${dataLeave!.used} วัน",
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ] else ...[
                  SvgPicture.asset(
                    "assets/icons/approve.svg",
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              requestTime!.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              DateFormat("dd/MM/yyyy")
                                  .format(
                                  requestTime!.start!),
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${DateFormat("HH:mm").format(requestTime!.start!)} "
                                  "- ${DateFormat("HH:mm").format(requestTime!.end!)}",
                              style: TextStyle(),
                            ),
                            Text(
                              requestTime!.idRequestType == 1
                                  ? "-"
                                  : "รวม ${((requestTime!.xOt! +
                                  requestTime!.xOtHoliday! +
                                  requestTime!.xWorkingMonthlyHoliday! +
                                  requestTime!.xWorkingDailyHoliday!) / 60).toStringAsFixed(2)} ชม.",
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]
              ],
            ),
          )),
    );
  }
}
