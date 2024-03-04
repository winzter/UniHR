import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../domain/entities/timeline_entity.dart';

class OtStatus extends StatelessWidget {
  final TimeLineEntity data;
  const OtStatus({super.key, required this.data});

  List<Widget> otFinding(TimeLineEntity data) {
    List<Widget> ot = [];
    for (var i in data.ot!) {
      if (i.xOt != 0) {
        ot.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(i.isManagerLv1Approve == 1
                  ? "assets/icons/approve.svg"
                  : (i.isManagerLv1Approve == null
                      ? "assets/icons/one.svg"
                      : "assets/icons/notpass.svg")),
              const SizedBox(
                width: 5,
              ),
              Text(
                "OT x 1.5 = ${(i.xOt! / 60).toStringAsFixed(2)} Hr. ",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        );
      }
      if (i.xWorkingDailyHoliday != 0 || i.xWorkingMonthlyHoliday != 0) {
        ot.add(const SizedBox(height: 5));
        ot.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(i.isManagerLv1Approve == 1
                  ? "assets/icons/approve.svg"
                  : (i.isManagerLv1Approve == null
                      ? "assets/icons/one.svg"
                      : "assets/icons/notpass.svg")),
              const SizedBox(
                width: 5,
              ),
              Text(
                "OT x 1 = ${(i.xWorkingDailyHoliday != 0 ? i.xWorkingDailyHoliday! / 60 : i.xWorkingMonthlyHoliday! / 60).toStringAsFixed(2)} Hr. ",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        );
      }
      if (i.xOtHoliday != 0) {
        ot.add(const SizedBox(height: 5));
        ot.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(i.isManagerLv2Approve == 1
                  ? "assets/icons/approve.svg"
                  : (i.isManagerLv2Approve == null
                      ? "assets/icons/two.svg"
                      : "assets/icons/notpass.svg")),
              const SizedBox(
                width: 5,
              ),
              Text(
                "OT x 3 = ${(i.xOtHoliday! / 60).toStringAsFixed(2)} Hr. ",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        );
      }
    }
    return ot;
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "OT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Column(
            children: otFinding(data),
          )
        ]),
      ),
    );
  }
}
