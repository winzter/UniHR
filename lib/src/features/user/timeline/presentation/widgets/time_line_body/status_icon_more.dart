import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusIconMore extends StatelessWidget {
  final TimeLineEntity data;
  const StatusIconMore({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          if (data.isLate != null && data.isLate!) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffFFD7DB),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  AppLocalizations.of(context)!.late,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          if (data.isEarlyOut != null && data.isEarlyOut!) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffFFD7DB),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  AppLocalizations.of(context)!.leaveearly,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          if (data.isCompensation != null && data.isCompensation!) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffe8e1f6),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  AppLocalizations.of(context)!.shifttypeholiday,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
          // if (data.holiday != null) ...[
          //   Container(
          //       padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          //       decoration: BoxDecoration(
          //           color: const Color(0xffe8e1f6),
          //           borderRadius: BorderRadius.circular(15)),
          //       child: Text(
          //         AppLocalizations.of(context)!.annualholiday,
          //         softWrap: true,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //             color: Colors.purple, fontWeight: FontWeight.bold),
          //       )),
          //   const SizedBox(
          //     width: 5,
          //     height: 5,
          //   ),
          // ],
          if (data.absent != null && data.absent!) ...[
            Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffFFD7DB),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(AppLocalizations.of(context)!.absent,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))),
            const SizedBox(
              width: 5,
              height: 5,
            ),
          ],
        ],
      ),
    );
  }
}
