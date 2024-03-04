import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/enitities.dart';
import '../bloc/time_management_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IsApproveDetail extends StatelessWidget {
  final TimeScheduleEntity data;
  final int? index;
  final TimeManagementBloc bloc;

  const IsApproveDetail(
      {super.key, required this.data, this.index, required this.bloc});

  Future confirmCancelTime(
      BuildContext context, TimeScheduleEntity data) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Center(
              child: Column(
            children: [
              const Icon(
                Icons.dangerous_outlined,
                color: Color(0xFFF15E5E),
                size: 60,
              ),
              Text(
                AppLocalizations.of(context)!.areyousure,
                style: TextStyle(color: const Color(0xff75838F)),
              ),
            ],
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.date +
                    DateFormat(" dd MMMM yyyy").format(data.date!),
                style: TextStyle(
                  fontSize: 17,
                  color: const Color(0xFFF15E5E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.cancel,
                      style: TextStyle(color: const Color(0xffA5AFBA))),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFF15E5E)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius here
                        ),
                      )),
                  child: Text(AppLocalizations.of(context)!.confirmdelete,
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    bloc.add(WithdrawTimeRequest(
                        idEmployeeShiftDaily:
                            data.requestChange!.last.idEmployeeShiftDaily!,
                        idEmployees: data.requestChange!.last.idEmployees!));
                    Navigator.of(context).pop(false);
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          endIndent: 25,
          indent: 25,
          thickness: 1,
        ),
        if (index != null) ...[
          ListTile(
            isThreeLine: true,
            title: Text(
              " ",
              style: TextStyle(),
            ),
            trailing: Text(
              data.requestChange![index!].approveDate != null
                  ? DateFormat("dd/MM/yyyy\nHH:mm")
                      .format(data.requestChange![index!].approveDate!)
                  : "",
              style: TextStyle(color: Color(0xff757575)),
              textAlign: TextAlign.end,
            ),
            subtitle: Text(
              AppLocalizations.of(context)!.approvedby == "Approved by"
                  ? "${data.requestChange![index!].firstnameTh ?? ''} ${data.requestChange![index!].lastnameTh ?? ''}\n${data.requestChange![index!].email ?? ''}"
                  : "${data.requestChange![index!].firstnameTh ?? ''} ${data.requestChange![index!].lastnameTh ?? ''}\n${data.requestChange![index!].email ?? ''}",
              style: TextStyle(color: Color(0xff757575)),
              textAlign: TextAlign.start,
            ),
          ),
          if (data.requestChange![index!].approveComment != null)
            ListTile(
              isThreeLine: true,
              title: Text(
                AppLocalizations.of(context)!.description,
                style: TextStyle(),
              ),
              subtitle: Text(
                "${data.requestChange![index!].approveComment}",
                style: TextStyle(color: Color(0xff757575)),
                textAlign: TextAlign.start,
              ),
            ),
        ] else ...[
          Stack(
            children: [
              Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    title: Text(
                      "${AppLocalizations.of(context)!.approvedby}",
                    ),
                    trailing: Text(
                      data.requestChange!.last.approveDate != null
                          ? DateFormat("dd/MM/yyyy\nHH:mm")
                              .format(data.requestChange!.last.approveDate!)
                          : "",
                      style: TextStyle(color: Color(0xff757575)),
                      textAlign: TextAlign.end,
                    ),
                    subtitle: Text(
                      "${data.requestChange!.last.firstnameTh ?? ''} ${data.requestChange!.last.lastnameTh ?? ''}\n${data.requestChange!.last.email ?? ''}",
                      style: TextStyle(color: Color(0xff757575)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  if (data.requestChange!.last.approveComment != null)
                    ListTile(
                      isThreeLine: true,
                      title: Text(
                        "${AppLocalizations.of(context)!.reason}",
                        style: TextStyle(),
                      ),
                      subtitle: Text(
                        "${data.requestChange!.last.approveComment}",
                        style: TextStyle(color: Color(0xff757575)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                ],
              ),
              if (data.requestChange!.last.isApprove == null)
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.015,
                  right: MediaQuery.of(context).size.width * 0.015,
                  child: IconButton(
                      icon: Icon(Icons.delete_outline_rounded),
                      onPressed: () {
                        confirmCancelTime(context, data);
                      }),
                )
            ],
          )
        ]
      ],
    );
  }
}
