import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../bloc/timeline_bloc.dart';
import '../widgets/appbar.dart';
import 'success_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmPage extends StatelessWidget {
  final TimelineBloc bloc = sl<TimelineBloc>();
  final double? amountHour;
  final int idRequestType;
  final CalculateTimeEntity? result;
  final PayrollSetting payrollData;
  final DateTime start;
  final DateTime end;
  final String requestType;
  final String reasonType;
  final String note;
  final TimeLineEntity data;

  final List<ReasonEntity> reasonAllData;

  ConfirmPage(
      {super.key,
      required this.data,
      required this.start,
      required this.end,
      required this.requestType,
      required this.reasonType,
      required this.note,
      required this.result,
      required this.idRequestType,
      required this.reasonAllData,
      this.amountHour,
      required this.payrollData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).devicePixelRatio * 10,
              horizontal: MediaQuery.of(context).devicePixelRatio * 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.workingday}: ${DateFormat('dd/MM/yyyy').format(data.date!)}",
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.workingtime}: ${data.pattern!.workingTypeName!} "
                          "(${data.pattern!.timeIn!.substring(0, 5)} "
                          "- ${data.pattern!.timeOut!.substring(0, 5)})",
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        "${AppLocalizations.of(context)!.type} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              requestType,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        "${AppLocalizations.of(context)!.startdate} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat("dd/MM/yyyy").format(start),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        "${AppLocalizations.of(context)!.start_time} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat("HH : mm").format(start),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        "${AppLocalizations.of(context)!.enddate}:",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat("dd/MM/yyyy").format(end),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 45,
                      child: Text(
                        "${AppLocalizations.of(context)!.end_time} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat("HH : mm").format(end),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: (idRequestType == 2 || idRequestType == 3) &&
                    result != null,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 40,
                        child: Text(
                          "${AppLocalizations.of(context)!.totalhours} :",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (idRequestType == 2) ...[
                              if ((result?.xWorkingMonthlyHoliday ?? 0) > 0) ...[
                                Text(
                                  "OT x ${payrollData.xWorkingMonthlyHoliday}    ${((result?.xWorkingMonthlyHoliday ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                              if ((result?.xOT ?? 0) > 0) ...[
                                Text(
                                  "OT x ${payrollData.xOt}   ${((result?.xOT ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                              if ((result?.xOTHoliday ?? 0) > 0) ...[
                                Text(
                                  "OT x ${payrollData.xOtHoliday}    ${((result?.xOTHoliday ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ]
                            ] else if (idRequestType == 3) ...[
                              Text(
                                "Compensate     ${((result?.compensateAmountHour ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 35,
                      child: Text(
                        "${AppLocalizations.of(context)!.description} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              reasonType,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 40,
                      child: Text(
                        "${AppLocalizations.of(context)!.otherreason} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              note == "" ? "-" : "$note",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 30,
                    bottom: MediaQuery.of(context).devicePixelRatio * 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: const Color(0xffE793B8)),
                    onPressed: () {
                      ProfileProvider profileData =
                          Provider.of<ProfileProvider>(context, listen: false);
                      bloc.add(SendTimeRequestData(amountHour,
                          result: result,
                          idEmployee: profileData.profileData.idEmployees!,
                          idRequestType: idRequestType,
                          requestReason: reasonType,
                          otherReason: note,
                          start: start,
                          end: end,
                          workEndDate: data.date!,
                          note: note,
                          profileData: profileData.profileData,
                          reasonAllData: reasonAllData));
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SuccessPage(
                                idRequestType: idRequestType,
                                result: result,
                                start: start,
                                end: end,
                                requestType: requestType,
                                reasonType: reasonType,
                                note: note,
                                data: data,
                                bloc: bloc,
                                payrollData: payrollData,
                              )));
                    },
                    child: Text(
                      "${AppLocalizations.of(context)!.confirm}",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
