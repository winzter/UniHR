import 'package:badges/badges.dart' as badges;
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import '../../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/item_status_bloc.dart';
import '../../providers/radio_button_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListItems extends StatefulWidget {
  final int index;
  final LeaveEntity? dataLeave;
  final RequestTimeEntity? requestTime;
  final List<WithdrawEntity> withdrawData;
  final PayrollSettingEntity? payrollSettingData;
  final String type;
  final ItemStatusBloc bloc;

  const ListItems(
      {super.key,
      required this.index,
      this.dataLeave,
      this.requestTime,
      required this.withdrawData,
      required this.type,
      required this.payrollSettingData,
      required this.bloc});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  SwipeDirection direction() {
    if (widget.dataLeave == null) {
      if (widget.requestTime!.isWithdraw == 1 ||
          widget.requestTime!.isManagerLv1Approve == 0 ||
          widget.requestTime!.isManagerLv2Approve == 0) {
        return SwipeDirection.none;
      } else {
        return SwipeDirection.endToStart;
      }
    } else {
      if (widget.dataLeave!.isWithdraw == 1 ||
          widget.dataLeave!.isApprove == 0) {
        return SwipeDirection.none;
      } else {
        return SwipeDirection.endToStart;
      }
    }
  }

  Future<bool?> confirmDeleteDialog() async {
    return await showDialog(
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
                '${AppLocalizations.of(context)!.areyousure}?',
                style: TextStyle(color: const Color(0xff75838F)),
              ),
            ],
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${AppLocalizations.of(context)!.type}",
                style: TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
              ),
              if (widget.dataLeave == null) ...[
                Flexible(
                    child: Text(
                  widget.requestTime!.name!,
                  style: TextStyle(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(
                  height: 5,
                )
              ] else ...[
                Text(
                  widget.dataLeave!.name!,
                  style: TextStyle(),
                ),
              ],
              if (widget.dataLeave == null) ...[
                Text(
                  "${AppLocalizations.of(context)!.startdate}",
                  style:
                      TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.requestTime!.start!),
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${AppLocalizations.of(context)!.enddate}",
                  style:
                      TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.requestTime!.end!),
                  style: TextStyle(fontSize: 17),
                ),
              ] else ...[
                Text(
                  "${AppLocalizations.of(context)!.startdate}",
                  style:
                      TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.dataLeave!.start!),
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${AppLocalizations.of(context)!.enddate}",
                  style:
                      TextStyle(fontSize: 14, color: const Color(0xffAFB9C2)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.dataLeave!.end!),
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: Text('${AppLocalizations.of(context)!.cancel}',
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
              child: Text('${AppLocalizations.of(context)!.confirm}',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
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
    final profileProvider = Provider.of<ProfileProvider>(context);
    final item = Provider.of<RadioButtonProvider>(context);
    WithdrawEntity? data;
    if (widget.withdrawData.isNotEmpty &&
            widget.dataLeave != null &&
            widget.type == "all" ||
        widget.type == "ขอลา") {
      for (var dataWithdraw in widget.withdrawData) {
        if (dataWithdraw.idLeave == widget.dataLeave!.idLeave!) {
          data = dataWithdraw;
        }
      }
    }
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
          direction: direction(),
          onSwiped: (_) {
            if (ModalRoute.of(context)?.isCurrent == true) {
              if (widget.dataLeave != null) {
                widget.bloc.add(DeleteItemData(
                    index: widget.index,
                    type: widget.type,
                    leaveData: widget.dataLeave));
              } else {
                widget.bloc.add(DeleteItemData(
                    index: widget.index,
                    type: widget.type,
                    requestTime: widget.requestTime));
              }
              // QuickAlert.show(
              //   context: context,
              //   type: QuickAlertType.success,
              //   title: "${AppLocalizations.of(context)!.datasavesuccessful}",
              // );
            }
          },
          confirmSwipe: (_) => confirmDeleteDialog(),
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
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              children: [
                ListTile(
                  leading: () {
                    if (widget.dataLeave != null) {
                      return badges.Badge(
                          position: badges.BadgePosition.topEnd(),
                          stackFit: StackFit.loose,
                          showBadge: () {
                            if (widget.dataLeave!.isApprove == 1 &&
                                widget.dataLeave!.isWithdraw == 1) {
                              return true;
                            }
                            return false;
                          }(),
                          ignorePointer: false,
                          onTap: () {},
                          badgeContent: const Text(""),
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            badgeColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SvgPicture.asset(
                            widget.dataLeave!.isApprove == 1 &&
                                    widget.dataLeave!.isWithdraw == null
                                ? "assets/icons/approve.svg"
                                : (widget.dataLeave!.isApprove == 0 &&
                                        widget.dataLeave!.isWithdraw == null
                                    ? "assets/icons/cancel.svg"
                                    : (widget.dataLeave!.isApprove == null &&
                                            widget.dataLeave!.isWithdraw == null
                                        ? "assets/icons/question.svg"
                                        : (widget.dataLeave!.isApprove == 1 &&
                                                data != null &&
                                                data.isApprove == 1)
                                            ? "assets/icons/grey_cancle.svg"
                                            : ((widget.dataLeave!.isApprove ==
                                                        1 &&
                                                    data != null &&
                                                    data.isApprove == null
                                                ? "assets/icons/approve.svg"
                                                : "assets/icons/grey_cancle.svg")))),
                            width: 30,
                          ));
                    } else if (widget.requestTime != null) {
                      if (widget.requestTime!.isDoubleApproval == 0) {
                        return SvgPicture.asset(
                          widget.requestTime!.isManagerLv1Approve == 1 &&
                                  widget.requestTime!.isWithdraw == null
                              ? "assets/icons/approve.svg"
                              : (widget.requestTime!.isManagerLv1Approve == 0 &&
                                      widget.requestTime!.isWithdraw == null
                                  ? "assets/icons/cancel.svg"
                                  : (widget.requestTime!.isManagerLv1Approve ==
                                              null &&
                                          widget.requestTime!.isWithdraw == null
                                      ? "assets/icons/question.svg"
                                      : "assets/icons/grey_cancle.svg")),
                          width: 30,
                        );
                      } else {
                        return SvgPicture.asset(
                          widget.requestTime!.isManagerLv1Approve == 1 &&
                                  widget.requestTime!.isManagerLv2Approve ==
                                      1 &&
                                  widget.requestTime!.isWithdraw == null
                              ? "assets/icons/approve.svg"
                              : (widget.requestTime!.isManagerLv1Approve == 0 ||
                                      widget.requestTime!.isManagerLv2Approve ==
                                              0 &&
                                          widget.requestTime!.isWithdraw == null
                                  ? "assets/icons/cancel.svg"
                                  : (widget.requestTime!
                                                  .isManagerLv1Approve ==
                                              null &&
                                          widget.requestTime!.isWithdraw == null
                                      ? "assets/icons/one.svg"
                                      : (widget.requestTime!
                                                      .isManagerLv1Approve ==
                                                  1 &&
                                              widget.requestTime!
                                                      .isManagerLv2Approve ==
                                                  null &&
                                              widget.requestTime!.isWithdraw ==
                                                  null
                                          ? "assets/icons/two.svg"
                                          : "assets/icons/grey_cancle.svg"))),
                          width: 30,
                        );
                      }
                    }
                  }(),
                  title: Text(
                    widget.dataLeave == null
                        ? widget.requestTime!.name == "OvertimeRequest"
                            ? AppLocalizations.of(context)!.overtimerequest
                            : widget.requestTime!.name == "WorkingTimeRequest"
                                ? AppLocalizations.of(context)!
                                    .workingtimerequest
                                : widget.requestTime!.name!
                        : AppLocalizations.of(context)!.hello == "สวัสดี"
                            ? widget.dataLeave!.name!
                            : widget.dataLeave!.name_EN == null
                                ? widget.dataLeave!.name!
                                : widget.dataLeave!.name_EN!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: () {
                    if (widget.dataLeave != null) {
                      return const Text("");
                    } else {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.payrollSettingData != null) ...[
                              if (widget.requestTime!.xOt != 0) ...[
                                Text(
                                    "OT x ${widget.payrollSettingData!.xOt} = ${(widget.requestTime!.xOt! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                    style: TextStyle(fontSize: 14)),
                              ],
                              if (profileProvider.profileData.idPaymentType ==
                                      2 ||
                                  profileProvider.profileData.idPaymentType ==
                                      4) ...[
                                if (widget
                                        .requestTime!.xWorkingMonthlyHoliday !=
                                    0) ...[
                                  Text(
                                      "OT x ${widget.payrollSettingData!.xWorkingMonthlyHoliday} = ${(widget.requestTime!.xWorkingMonthlyHoliday! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ] else ...[
                                if (widget.requestTime!.xWorkingDailyHoliday !=
                                    0) ...[
                                  Text(
                                      "OT x ${widget.payrollSettingData!.xWorkingDailyHoliday} = ${(widget.requestTime!.xOt! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ],
                              if (widget.requestTime!.xOtHoliday != 0) ...[
                                Text(
                                    "OT x ${widget.payrollSettingData!.xOtHoliday} = ${(widget.requestTime!.xOtHoliday! / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                    style: TextStyle(fontSize: 14)),
                              ]
                            ]
                          ]);
                    }
                  }(),
                  trailing: Text(
                    "${DateFormat('dd/MM/yyyy').format(widget.dataLeave == null ? widget.requestTime!.start! : widget.dataLeave!.start!)}"
                    "\n${item.isFullDay(widget.dataLeave == null ? widget.requestTime!.start! : widget.dataLeave!.start!, widget.dataLeave == null ? widget.requestTime!.end! : widget.dataLeave!.end!, context)}",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                ExpandChild(
                    indicatorCollapsedHint: "",
                    indicatorExpandedHint: "",
                    indicatorPadding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: const Color(0xffc4c4c4),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.dataLeave == null) ...[
                                  Text(
                                      AppLocalizations.supportedLocales == "th"
                                          ? "${widget.requestTime!.reasonName}"
                                          : "${widget.requestTime!.reasonName_EN}",
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      "${AppLocalizations.of(context)!.otherreason} : ${widget.requestTime!.otherReason == "" ? "-" : widget.requestTime!.otherReason}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color(0xff757575)))
                                ] else ...[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${AppLocalizations.of(context)!.reason}",
                                            style: TextStyle(fontSize: 14)),
                                      ]),
                                  Text(
                                      "${widget.dataLeave!.description == null || widget.dataLeave!.description == "" ? "-" : widget.dataLeave!.description}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color(0xff757575))),
                                  const SizedBox(height: 10),
                                  Text(
                                      "${AppLocalizations.of(context)!.start} - ${AppLocalizations.of(context)!.enddate}",
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      "${DateFormat('dd/MM/yyyy').format(widget.dataLeave!.start!)} "
                                      "- ${DateFormat('dd/MM/yyyy').format(widget.dataLeave!.end!)}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color(0xff757575))),
                                ]
                              ],
                            ),
                            const Divider(
                              color: const Color(0xffc4c4c4),
                            ),
                            Column(
                              children: [
                                if (widget.dataLeave != null) ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.approvedby}",
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                        widget.dataLeave!.approveDate == null
                                            ? "-"
                                            : "${DateFormat('dd/MM/yyyy').format(widget.dataLeave!.approveDate!)}"
                                                "\n${DateFormat('HH:mm').format(widget.dataLeave!.approveDate!)}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: const Color(0xff757575)),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!.hello ==
                                                  "Hello"
                                              ? "${widget.dataLeave!.managerFirstnameEn ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.dataLeave!.managerLastnameEn ?? '${AppLocalizations.of(context)!.notspecified}'}"
                                              : "${widget.dataLeave!.managerFirstnameTh ?? 'ไม่ระบุชื่อ'} ${widget.dataLeave!.managerLastnameTh ?? 'ไม่ระบุนามสกุล'}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${widget.dataLeave!.managerEmail ?? 'ไม่ระบุ'}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: const Color(0xff757575)))
                                    ],
                                  ),
                                  if (widget.dataLeave!.isApprove == 0) ...[
                                    Row(
                                      children: [
                                        Text(
                                            "${AppLocalizations.of(context)!.reasonforrejection}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.red)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            widget.dataLeave!.commentManager ==
                                                        null ||
                                                    widget.dataLeave!
                                                            .commentManager ==
                                                        ""
                                                ? "-"
                                                : widget
                                                    .dataLeave!.commentManager,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  ]
                                ] else ...[
                                  if (widget.requestTime!.isDoubleApproval! ==
                                      0) ...[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${AppLocalizations.of(context)!.approvedby}",
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!.hello ==
                                                "Hello"
                                                ? "${widget.requestTime!.managerLv1FirstnameEn ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.requestTime!.managerLv1LastnameEn ?? '${AppLocalizations.of(context)!.notspecified}'}"
                                                : "${widget.requestTime!.managerLv1FirstnameTh ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.requestTime!.managerLv1LastnameTh ?? '${AppLocalizations.of(context)!.notspecified}'}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${widget.requestTime!.managerLv1Email ?? '${AppLocalizations.of(context)!.notspecified}'}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: const Color(0xff757575)))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (widget
                                            .requestTime!.isManagerLv1Approve ==
                                        0) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${AppLocalizations.of(context)!.reasonforrejection}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!
                                                              .commentManagerLv1 ==
                                                          null ||
                                                      widget.requestTime!
                                                              .commentManagerLv1 ==
                                                          ""
                                                  ? "-"
                                                  : widget.requestTime!
                                                      .commentManagerLv1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff757575)))
                                        ],
                                      ),
                                    ] else ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${AppLocalizations.of(context)!.approveddate}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!
                                                          .managerLv1ApproveDate ==
                                                      null
                                                  ? "-"
                                                  : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate))}"
                                                      "\n${DateFormat('HH:mm').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate))}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff757575)))
                                        ],
                                      ),
                                    ]
                                  ] else ...[
                                    if (widget.requestTime!
                                                .isManagerLv1Approve ==
                                            0 ||
                                        widget.requestTime!
                                                .isManagerLv2Approve ==
                                            0) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${AppLocalizations.of(context)!.reasonforrejection}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ManagerLV 1 :",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!
                                                              .commentManagerLv1 ==
                                                          null ||
                                                      widget.requestTime!
                                                              .commentManagerLv1 ==
                                                          ""
                                                  ? "-"
                                                  : widget.requestTime!
                                                      .commentManagerLv1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff757575)))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ManagerLV 2 :",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              widget.requestTime!
                                                              .commentManagerLv2 ==
                                                          null ||
                                                      widget.requestTime!
                                                              .commentManagerLv2 ==
                                                          ""
                                                  ? "-"
                                                  : widget.requestTime!
                                                      .commentManagerLv2,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff757575)))
                                        ],
                                      ),
                                    ] else ...[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${AppLocalizations.of(context)!.approvedby}",
                                              style: TextStyle(fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Manager Lv 1",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          Text(
                                            widget.requestTime!
                                                        .managerLv1ApproveDate ==
                                                    null
                                                ? "-"
                                                : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate!))}"
                                                    "\n${DateFormat('HH:mm').format(DateTime.parse(widget.requestTime!.managerLv1ApproveDate!))}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: const Color(0xff757575)),
                                            textAlign: TextAlign.end,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!.hello ==
                                                  "Hello"
                                                  ? "${widget.requestTime!.managerLv1FirstnameEn ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.requestTime!.managerLv1LastnameEn ?? '${AppLocalizations.of(context)!.notspecified}'}"
                                                  : "${widget.requestTime!.managerLv1FirstnameTh ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.requestTime!.managerLv1LastnameTh ?? '${AppLocalizations.of(context)!.notspecified}'}",

                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${widget.requestTime!.managerLv1Email ?? '${AppLocalizations.of(context)!.notspecified}'}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff757575)))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Manager Lv 2",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          Text(
                                            widget.requestTime!
                                                        .managerLv2ApproveDate ==
                                                    null
                                                ? "-"
                                                : "${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.requestTime!.managerLv2ApproveDate!))}"
                                                    "\n${DateFormat('HH:mm').format(DateTime.parse(widget.requestTime!.managerLv2ApproveDate!))}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: const Color(0xff757575)),
                                            textAlign: TextAlign.end,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!.hello ==
                                                  "Hello"
                                                  ? "${widget.requestTime!.managerLv2FirstnameEn ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.requestTime!.managerLv2LastnameEn ?? '${AppLocalizations.of(context)!.notspecified}'}"
                                                  : "${widget.requestTime!.managerLv2FirstnameTh ?? '${AppLocalizations.of(context)!.notspecified}'} ${widget.requestTime!.managerLv2LastnameTh ?? '${AppLocalizations.of(context)!.notspecified}'}"
                                              ,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${widget.requestTime!.managerLv2Email ?? '${AppLocalizations.of(context)!.notspecified}'}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff757575)))
                                        ],
                                      ),
                                    ]
                                  ]
                                ]
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
