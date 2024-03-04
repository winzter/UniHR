import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../bloc/overview_bloc.dart';
import '../widgets/widgets.dart';
import '../widgets/workingt_time_menu/working_time_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkingTimePage extends StatefulWidget {
  const WorkingTimePage({super.key});

  @override
  State<WorkingTimePage> createState() => _WorkingTimePageState();
}

class _WorkingTimePageState extends State<WorkingTimePage> {
  final OverviewBloc overviewBloc = sl<OverviewBloc>();
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    overviewBloc.add(GetDepartmentData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => overviewBloc,
      child: Scaffold(
        appBar: appBarOverview(
            context, "${AppLocalizations.of(context)!.attendanceOverview}"),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xffF9A47A),
                  Color(0xffE793B8),
                  Color(0xff6FC9E4),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DepartmentSelect(
                      bloc: overviewBloc,
                      isExpanded: isExpanded,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          MonthYearPicker(
                            bloc: overviewBloc,
                            title: "ภาพรวมเวลาทำงาน",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EmployeesNum(bloc: overviewBloc),
                                NumOfLeave(bloc: overviewBloc)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return LeaveAndAbsenceBox(
                                        title:
                                            "${AppLocalizations.of(context)!.absent}",
                                        rate: state
                                                .workingTimeData
                                                ?.workingTimeEmployeeInfo!
                                                .absentTotal ??
                                            0,
                                        color: Color(0xffFF364B),
                                        svgPath:
                                            "assets/icons/overview_manager/absence.svg");
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return LeaveAndAbsenceBox(
                                        title:
                                            "${AppLocalizations.of(context)!.late}",
                                        rate: state
                                                .workingTimeData
                                                ?.workingTimeEmployeeInfo!
                                                .lateTotal ??
                                            0,
                                        color: Color(0xffF9A67B),
                                        svgPath:
                                            "assets/icons/overview_manager/late.svg");
                                  },
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ChartOt(
                                  overtimeData: state.overtimeData,
                                  date: state.date);
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return OtChart(
                                overtimeData: state.overtimeData,
                                date: state.date,
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return Top5Late(
                                workingTimeData: state.workingTimeData,
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return Top5Absence(
                                workingTimeData: state.workingTimeData,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: isExpanded ? Color(0xffE46A76) : Color(0xff30B98F),
            child: Icon(
              isExpanded ? Icons.search_off : Icons.search,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
