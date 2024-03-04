import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:quiver/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';
import 'leave_auth_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveAuthorityList extends StatefulWidget {
  final List<LeaveAvailableEntity> leaveAuthority;
  final LeaveSettingEntity leaveSettingData;
  final LeaveBloc bloc;
  final Map<String, List<double>> leaveData;

  const LeaveAuthorityList({
    super.key,
    required this.leaveAuthority,
    required this.leaveData,
    required this.leaveSettingData,
    required this.bloc,
  });

  @override
  State<LeaveAuthorityList> createState() => _LeaveAuthorityListState();
}

class _LeaveAuthorityListState extends State<LeaveAuthorityList> {
  final DateTime now = DateTime.now();
  List<TempDropDownMenu> labelData = [];
  DateTime? resetDate;
  TempDropDownMenu? selectedPeriod;

  @override
  void initState() {
    super.initState();
    resetDate = DateTime(
      now.year,
      widget.leaveSettingData.resetEndOfMonth ?? 0,
      daysInMonth(now.year, widget.leaveSettingData.resetEndOfMonth ?? 0),
    );
    for (var i = -1; i < 1; i++) {
      resetDate = DateTime(
        now.year + i,
        widget.leaveSettingData.resetEndOfMonth ?? 0,
        daysInMonth(now.year + i, widget.leaveSettingData.resetEndOfMonth ?? 0),
      );
      var startDate = DateTime(now.year + i, resetDate!.month - 11, 1);
      var endDate = DateTime(now.year + i, resetDate!.month, resetDate!.day);
      labelData.add(TempDropDownMenu(
        start: startDate,
        end: endDate,
        label:
            "${DateFormat("dd-MMM-yyyy").format(startDate)} - ${DateFormat("dd-MMM-yyyy").format(endDate)}",
      ));
    }
    selectedPeriod = labelData[1];
    setState(() {});
    widget.bloc.add(GetLeaveAvailableEvent(
        start: labelData[1].start, end: labelData[1].end));
  }

  OutlineInputBorder borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  @override
  Widget build(BuildContext context) {
    return widget.leaveAuthority.length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 15, right: 15, bottom: 5),
                child: DropdownButtonFormField2(
                  value: selectedPeriod,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: borderStyle,
                      errorStyle: TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      border: borderStyle,
                      enabledBorder: borderStyle),
                  items: labelData.map<DropdownMenuItem<TempDropDownMenu>>(
                      (TempDropDownMenu value) {
                    return DropdownMenuItem<TempDropDownMenu>(
                        value: value,
                        child: Center(
                          child: Text(
                            value.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19,
                              fontFamily: 'kanit',
                            ),
                          ),
                        ));
                  }).toList(),
                  isExpanded: true,
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (TempDropDownMenu? value) {
                    selectedPeriod = value!;
                    widget.bloc.add(GetLeaveAvailableEvent(
                      start: value.start,
                      end: value.end,
                    ));
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, left: 5, right: 5, bottom: 0),
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: widget.leaveAuthority.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
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
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                            .hello ==
                                                        "Hello"
                                                    ? widget
                                                            .leaveAuthority[
                                                                index]
                                                            .name_EN ??
                                                        "Leave is not scheduled."
                                                    : widget
                                                            .leaveAuthority[
                                                                index]
                                                            .name ??
                                                        "ไม่กำหนดการลา",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${AppLocalizations.of(context)!.leaverights} :  ${widget.leaveAuthority[index].leaveValue != null ? '${widget.leaveAuthority[index].leaveValue?.toStringAsFixed(2)} ' : '${AppLocalizations.of(context)!.unlimited}'}"
                                                "${widget.leaveAuthority[index].isLeaveCompensate == 1 ? '${AppLocalizations.of(context)!.hour}' : '${AppLocalizations.of(context)!.day}'}",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff757575)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        if (widget.leaveAuthority[index]
                                                    .idLeaveType ==
                                                1 &&
                                            widget.leaveAuthority[index]
                                                    .carryValue !=
                                                null) ...[
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  "${AppLocalizations.of(context)!.remaining} : ${widget.leaveAuthority[index].leaveRemain == null ? "${AppLocalizations.of(context)!.unlimited}" : widget.leaveAuthority[index].leaveRemain! >= widget.leaveAuthority[index].carryValue! ? widget.leaveAuthority[index].leaveUsed!.toStringAsFixed(2) : widget.leaveAuthority[index].leaveValue!.toStringAsFixed(2)} ${AppLocalizations.of(context)!.day}",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff757575)),
                                                ))
                                              ]),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                        ] else ...[
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  "${AppLocalizations.of(context)!.remaining} :  ${widget.leaveAuthority[index].leaveRemain == null ? "${AppLocalizations.of(context)!.unlimited}" : "${widget.leaveAuthority[index].leaveRemain!.toStringAsFixed(2)} "}"
                                                  "${widget.leaveAuthority[index].isLeaveCompensate == 1 ? '${AppLocalizations.of(context)!.hour}' : '${AppLocalizations.of(context)!.day}'}",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff757575)),
                                                ))
                                              ]),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        if (widget.leaveAuthority[index]
                                                    .carryValue !=
                                                0 &&
                                            widget.leaveAuthority[index]
                                                    .carryValue !=
                                                null)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.accumulatedrights} :  ${widget.leaveAuthority[index].carryValue?.toStringAsFixed(2) ?? '${AppLocalizations.of(context)!.unlimited}'} ${AppLocalizations.of(context)!.day}",
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff757575)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        if (widget.leaveAuthority[index]
                                                    .carryValue !=
                                                0 &&
                                            widget.leaveAuthority[index]
                                                    .carryValue !=
                                                null)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 20,
                                              ),
                                              Text(
                                                "${AppLocalizations.of(context)!.remaining} :  ${widget.leaveAuthority[index].leaveRemain == null ? "${AppLocalizations.of(context)!.unlimited}" : widget.leaveAuthority[index].leaveRemain! < 0 ? "0.00" : widget.leaveAuthority[index].carryRemain!.toStringAsFixed(2)} ${AppLocalizations.of(context)!.day}",
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xff757575)),
                                              )
                                            ],
                                          ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  LeaveChart(
                                    leaveData: [widget.leaveAuthority[index]],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          )
        : Center(
            child: Text(
              "${AppLocalizations.of(context)!.thereisnoinformationonleaverights}",
              style: TextStyle(fontSize: 17),
            ),
          );
  }
}

class TempDropDownMenu {
  final DateTime start;
  final DateTime end;
  final String label;

  TempDropDownMenu({
    required this.start,
    required this.end,
    required this.label,
  });
}
