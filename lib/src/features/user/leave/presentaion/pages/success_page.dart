import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/components/widgets/loading.dart';
import '../bloc/leave_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessPage extends StatelessWidget {
  final bool isFullDay;
  final LeaveBloc bloc;

  const SuccessPage({super.key, required this.isFullDay, required this.bloc});

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
                '${AppLocalizations.of(context)!.makealeavelist}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xff6FC9E4), Color(0xffE793B8)])),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                          colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.4)
                      ])),
                  child: BlocBuilder<LeaveBloc, LeaveState>(
                      builder: (context, state) {
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
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Loading(
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "กำลังส่งข้อมูล...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )),
                        ],
                      );
                    }
                    else if (state.status == FetchStatus.failed) {
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
                                      Color(0xffE793B8)
                                    ])),
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
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                MediaQuery.of(context).devicePixelRatio *
                                    7),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
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
                                            padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 7),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/cancel.svg",
                                                  width: 80,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "${AppLocalizations.of(context)!.error01} ",
                                                        style: TextStyle(fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("${state.error!.errMsgText!}")
                                                        // "${AppLocalizations.of(context)!.thereisarepeatrequestforleavewithotheritemstoday}")
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else if (state.status == FetchStatus.result) {
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
                                  Color(0xffE793B8)
                                ])),
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
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).devicePixelRatio *
                                        7),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
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
                                            child: SvgPicture.asset(
                                              "assets/icons/success.svg",
                                              width: 100,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${AppLocalizations.of(context)!.leaveTransactionSuccessful}",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.type}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Flexible(
                                                  child: Text(state.leaveType,
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (state.holiday != null) ...[
                                            Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${AppLocalizations.of(context)!.dayoff}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Flexible(
                                                    child: Text(state.holiday!,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.startdate}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Text(
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(
                                                            state.startDay!),
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: !isFullDay,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${AppLocalizations.of(context)!.start_time}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Text(
                                                      DateFormat("HH : mm")
                                                          .format(
                                                              state.startDay!),
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.enddate}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Text(
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(state.endDay!),
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: !isFullDay,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${AppLocalizations.of(context)!.end_time}",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Text(
                                                      DateFormat("HH : mm")
                                                          .format(
                                                              state.endDay!),
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.totalLeaveDays}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Text("${state.uses} วัน",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.currentrightsremaining}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Text(
                                                    state.remainNow > 100
                                                        ? '${AppLocalizations.of(context)!.unlimited}'
                                                        : "${state.remainNow} ${AppLocalizations.of(context)!.day}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.note}",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Text(
                                                    state.note != null
                                                        ? state.note!
                                                        : "-",
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
                ),
              ]),
            ),
            floatingActionButton:
                BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
              if (state.status == FetchStatus.result ||
                  state.status == FetchStatus.failed) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).devicePixelRatio * 5),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          elevation: 5,
                          backgroundColor: const Color(0xffE793B8)),
                      onPressed: () {
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        "${AppLocalizations.of(context)!.confirm}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat),
      ),
    );
  }
}
