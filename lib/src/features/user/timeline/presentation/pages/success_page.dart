import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../components/widgets/loading.dart';
import '../../domain/entities/entities.dart';
import '../bloc/timeline_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessPage extends StatelessWidget {
  final int idRequestType;
  final CalculateTimeEntity? result;
  final PayrollSetting payrollData;
  final DateTime start;
  final DateTime end;
  final String requestType;
  final String reasonType;
  final String note;
  final TimeLineEntity data;
  final TimelineBloc bloc;
  const SuccessPage(
      {super.key,
      required this.idRequestType,
      required this.result,
      required this.start,
      required this.end,
      required this.requestType,
      required this.reasonType,
      required this.note,
      required this.data,
      required this.bloc,
      required this.payrollData});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => bloc,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                          Color(0xff6FC9E4),
                          Color(0xffE793B8),
                        ])),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0.3)
                        ])),
                  ),
                ],
              ),
              centerTitle: true,
              title: Text(
                '${AppLocalizations.of(context)!.request_list}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: BlocBuilder<TimelineBloc, TimelineState>(
              builder: (BuildContext context, state) {
                if (state.status == FetchStatus.fetching) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                              Color(0xff6FC9E4),
                              Color(0xffE793B8),
                            ])),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.4)
                            ])),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Loading(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.sendingdata}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ],
                  );
                }
                else if (state.status == FetchStatus.failed) {
                  return Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [Color(0xff6FC9E4), Color(0xffE793B8)])),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.4)
                                ])),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).devicePixelRatio * 7),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).devicePixelRatio * 10,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context).devicePixelRatio * 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.transparent),
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).devicePixelRatio * 5),
                                              child:SvgPicture.asset(
                                                "assets/icons/cancel.svg",
                                                width: 80,
                                              )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio * 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text("ทำรายการไม่สำเร็จ",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context).devicePixelRatio * 15,
                                                bottom: MediaQuery.of(context).devicePixelRatio * 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.error01} ${state.error?.errMsgText??''}",
                                                        textAlign:
                                                        TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context).devicePixelRatio * 10,
                                      ),
                                      child: SizedBox(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              backgroundColor:
                                              const Color(0xffE793B8)),
                                          onPressed: () {
                                            int count = 0;
                                            Navigator.of(context).popUntil((_) => count++ >= 4);
                                          },
                                          child: Text(
                                            "${AppLocalizations.of(context)!.successfully}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]);
                }
                else if (state.status == FetchStatus.success) {
                  return Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [Color(0xff6FC9E4), Color(0xffE793B8)])),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.4)
                          ])),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).devicePixelRatio *
                                          7),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          10,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                              10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .devicePixelRatio *
                                                    5),
                                            child:
                                                state.duplicateErr?.errorCode !=
                                                        null
                                                    ? SvgPicture.asset(
                                                        "assets/icons/cancel.svg",
                                                        width: 80,
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/icons/success.svg",
                                                        width: 100,
                                                      ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .devicePixelRatio *
                                                    5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.duplicateErr
                                                              ?.errorCode ==
                                                          null
                                                      ? "ทำรายการคำขอสำเร็จ"
                                                      : "ทำรายการไม่สำเร็จ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (state.duplicateErr?.errorCode ==
                                              null) ...[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    flex: 30,
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.type}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  Expanded(
                                                    flex: 60,
                                                    child: Text(requestType,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 70,
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.startdate}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  Expanded(
                                                    flex: 40,
                                                    child: Text(
                                                        DateFormat("dd/MM/yyyy")
                                                            .format(start),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 70,
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.start_time}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  Expanded(
                                                    flex: 30,
                                                    child: Text(
                                                        DateFormat("HH : mm")
                                                            .format(start),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 70,
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.enddate}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  Expanded(
                                                    flex: 40,
                                                    child: Text(
                                                        DateFormat("dd/MM/yyyy")
                                                            .format(end),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 70,
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.end_time}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  Expanded(
                                                    flex: 30,
                                                    child: Text(
                                                        DateFormat("HH : mm")
                                                            .format(end),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: (idRequestType == 2 ||
                                                      idRequestType == 3) &&
                                                  result != null,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .devicePixelRatio *
                                                        5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 45,
                                                      child: Text(
                                                        "${AppLocalizations.of(context)!.totalhours} :",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 70,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          if (idRequestType ==
                                                              2) ...[
                                                            if ((result?.xWorkingMonthlyHoliday ??
                                                                    0) >
                                                                0) ...[
                                                              Text(
                                                                "OT x ${payrollData.xWorkingMonthlyHoliday}    ${((result?.xWorkingMonthlyHoliday ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                            if ((result?.xOT ??
                                                                    0) >
                                                                0) ...[
                                                              Text(
                                                                "OT x ${payrollData.xOt}   ${((result?.xOT ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                            if ((result?.xOTHoliday ??
                                                                    0) >
                                                                0) ...[
                                                              Text(
                                                                "OT x ${payrollData.xOtHoliday}    ${((result?.xOTHoliday ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ]
                                                          ] else if (idRequestType ==
                                                              3) ...[
                                                            Text(
                                                              "Compensate     ${((result?.compensateAmountHour ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 35,
                                                    child: Text(
                                                      "${AppLocalizations.of(context)!.description} :",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 70,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            reasonType,
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                                  top: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      5,
                                                  bottom: MediaQuery.of(context)
                                                          .devicePixelRatio *
                                                      10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 50,
                                                    child: Text(
                                                      "${AppLocalizations.of(context)!.otherreason} :",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            note == ""
                                                                ? "-"
                                                                : note,
                                                            textAlign:
                                                                TextAlign.end,
                                                            softWrap: true,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ] else ...[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .devicePixelRatio *
                                                    15,
                                                bottom: MediaQuery.of(context)
                                                        .devicePixelRatio *
                                                    15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "มีรายการคำขอซ้ำกับรายการที่มีอยู่",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            ),
                                          ]
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          10,
                                    ),
                                    child: SizedBox(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 5,
                                            backgroundColor:
                                                const Color(0xffE793B8)),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                          Navigator.of(context).pop(true);
                                          Navigator.of(context).pop(true);
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text(
                                          "${AppLocalizations.of(context)!.successfully}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]);
                }
                else {
                  return Container();
                }
              },
            )),
      ),
    );
  }
}
