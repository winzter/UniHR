import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveHistoryList extends StatelessWidget {
  final List<LeaveHistoryEntity> leaveHistory;
  final LeaveBloc bloc;
  final DateTime dateFrame;
  const LeaveHistoryList(
      {super.key,
      required this.leaveHistory,
      required this.bloc,
      required this.dateFrame});

  Future confirmDelete(
      BuildContext context, LeaveHistoryEntity leaveHistory, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
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
                AppLocalizations.of(context)!.leavetype,
                style: TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
              ),
              Text(
                leaveHistory.name!,
                style: TextStyle(),
              ),
              Text(
                AppLocalizations.of(context)!.startdate,
                style: TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(leaveHistory.start!),
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                AppLocalizations.of(context)!.enddate,
                style: TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(leaveHistory.end!),
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          actions: [
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
                      borderRadius:
                          BorderRadius.circular(10.0), // Adjust the radius here
                    ),
                  )),
              child: Text(AppLocalizations.of(context)!.confirm,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                bloc.add(DeleteLeaveHistoryData(
                    leaveHistory: leaveHistory, index: index));
                // bloc.add(GetLeaveHistoryData(year: dateFrame));
                return Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: leaveHistory.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.hello == "Hello"
                              ? leaveHistory[index].name_EN ??
                                  "${AppLocalizations.of(context)!.notspecified}"
                              : leaveHistory[index].name ?? "ไม่ระบุ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: leaveHistory[index].isApprove != 0 && leaveHistory[index].withdraw != null
                        ? MainAxisAlignment.end
                        :(leaveHistory[index].isApprove == 0?MainAxisAlignment.end:MainAxisAlignment.spaceBetween),
                    children: [
                      if (leaveHistory[index].isApprove != 0 &&
                          leaveHistory[index].withdraw == null) ...[
                        GestureDetector(
                          child: SvgPicture.asset(
                            "assets/icons/bin.svg",
                            width: 15,
                          ),
                          onTap: () => confirmDelete(
                              context, leaveHistory[index], index),
                        ),
                      ],
                      if (leaveHistory[index].withdraw != null &&
                          leaveHistory[index].withdraw?.isApprove != null &&
                          leaveHistory[index].withdraw?.isApprove == 1) ...[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(AppLocalizations.of(context)!.withdraw,
                              style: TextStyle(
                                  color: Color(0xffFF364B),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          decoration: BoxDecoration(
                              color: const Color(0xffB72136).withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      ] else if (leaveHistory[index].withdraw != null &&
                          leaveHistory[index].withdraw?.isApprove == null) ...[
                        // SvgPicture.asset("assets/icons/withdraw_approve.svg"),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(
                              AppLocalizations.of(context)!.withdrawapprove,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 254, 227, 53),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 241, 255, 44)
                                  .withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      ] else if (leaveHistory[index].isApprove == 1) ...[
                        // SvgPicture.asset("assets/icons/pass.svg"),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(AppLocalizations.of(context)!.approved,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 22, 116, 4),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 33, 183, 78)
                                  .withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      ] else if (leaveHistory[index].isApprove == null) ...[
                        // SvgPicture.asset("assets/icons/wait.svg"),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(
                              AppLocalizations.of(context)!.pendingapproval,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 254, 227, 53),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 241, 255, 44)
                                  .withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      ] else if (leaveHistory[index].isApprove == 0) ...[
                        // SvgPicture.asset("assets/icons/notpass.svg"),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(AppLocalizations.of(context)!.notapproved,
                              style: TextStyle(
                                  color: Color(0xffFF364B),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          decoration: BoxDecoration(
                              color: const Color(0xffB72136).withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      ]
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.totalLeaveDays}",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                          "${leaveHistory[index].used!.toStringAsFixed(2)} ${leaveHistory[index].name!.contains("Compensate") ? '${AppLocalizations.of(context)!.hour}' : '${AppLocalizations.of(context)!.day}'}",
                          style: TextStyle(fontSize: 17))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.start,
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(AppLocalizations.of(context)!.end,
                          style: TextStyle(fontSize: 17))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            DateFormat('dd/MM/yyyy').format(
                                leaveHistory[index].start ?? DateTime.now()),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text(
                            DateFormat('dd/MM/yyyy').format(
                                leaveHistory[index].end ?? DateTime.now()),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))
                      ]),
                  const SizedBox(
                    height: 15,
                  ),
                  if (leaveHistory[index].isFullDay != 1) ...[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              DateFormat('HH:mm').format(
                                  leaveHistory[index].start ?? DateTime.now()),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text(
                              DateFormat('HH:mm').format(
                                  leaveHistory[index].end ?? DateTime.now()),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))
                        ]),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                  if (leaveHistory[index].fileUrl != null) ...[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.attachfile,
                              style: TextStyle(fontSize: 17)),
                          IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        width: 300,
                                        height: 300,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    leaveHistory[index]
                                                        .fileUrl),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.attach_file,
                                size: 25,
                              ))
                        ]),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                            "${AppLocalizations.of(context)!.description} : ${leaveHistory[index].description ?? '-'}",
                            style: TextStyle(
                                fontSize: 16, color: const Color(0xff757575))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
