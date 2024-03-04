import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:badges/badges.dart' as badges;
import '../../../domain/entities/entities.dart';
import '../../providers/radio_button_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListWithdrawItems extends StatefulWidget {
  final int index;
  final WithdrawEntity withdrawData;
  final List<LeaveEntity> leaveData;
  const ListWithdrawItems(
      {super.key,
      required this.index,
      required this.withdrawData,
      required this.leaveData});

  @override
  State<ListWithdrawItems> createState() => _ListWithdrawItemsState();
}

class _ListWithdrawItemsState extends State<ListWithdrawItems> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<RadioButtonProvider>(context, listen: false);
    LeaveEntity data = widget.leaveData.firstWhere(
        (element) => element.idLeave == widget.withdrawData.idLeave);
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
          key: UniqueKey(),
          backgroundBuilder: (BuildContext context, SwipeDirection direction,
              AnimationController progress) {
            return const Icon(null);
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    data.name ?? "-",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  leading: SvgPicture.asset(
                    widget.withdrawData.isApprove == 1
                        ? "assets/icons/approve.svg"
                        : (widget.withdrawData.isApprove == 0
                            ? "assets/icons/grey_cancle.svg"
                            : "assets/icons/question.svg"),
                    width: 30,
                  ),
                  subtitle: Row(
                    children: [
                      badges.Badge(
                        position: badges.BadgePosition.topEnd(),
                        stackFit: StackFit.loose,
                        showBadge: true,
                        ignorePointer: false,
                        onTap: () {},
                        badgeContent: Text(
                          "${AppLocalizations.of(context)!.withdraw}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.square,
                          badgeColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    "${DateFormat('dd/MM/yyyy').format(data.start!)}"
                    "\n${item.isFullDay(data.start!, data.end!, context)}",
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
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.withdrawalapprovaldate}",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red)),
                                      Text(
                                        widget.withdrawData.approveDate == null
                                            ? "-"
                                            : "${DateFormat('dd/MM/yyyy').format(widget.withdrawData.approveDate!)}"
                                                "\n${DateFormat('HH:mm').format(widget.withdrawData.approveDate!)}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.red),
                                        textAlign: TextAlign.end,
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.reason}",
                                          style: TextStyle(fontSize: 14)),
                                    ]),
                                Text(
                                    "${data.description == "" ? "-" : data.description}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: const Color(0xff757575))),
                                const SizedBox(height: 10),
                                Text(
                                    "${AppLocalizations.of(context)!.start} - ${AppLocalizations.of(context)!.enddate}",
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    "${DateFormat('dd/MM/yyyy').format(data.start!)} "
                                    "- ${DateFormat('dd/MM/yyyy').format(data.end!)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: const Color(0xff757575))),
                              ],
                            ),
                            const Divider(),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.approvedby}",
                                        style: TextStyle(fontSize: 14)),
                                    Text(
                                      data.approveDate == null
                                          ? "-"
                                          : "${DateFormat('dd/MM/yyyy').format(data.approveDate!)}"
                                              "\n${DateFormat('HH:mm').format(data.approveDate!)}",
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
                                        "${data.managerFirstnameTh} ${data.managerLastnameTh}",
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
                                    Text("${data.managerEmail}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: const Color(0xff757575)))
                                  ],
                                ),
                                if (data.isApprove == 0) ...[
                                  Row(
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.reasonforrejection}",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          data.commentManager == null &&
                                                  data.commentManager == ""
                                              ? "-"
                                              : data.commentManager,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
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
