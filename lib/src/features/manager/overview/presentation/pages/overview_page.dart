import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihr/src/features/manager/overview/presentation/bloc/overview_bloc.dart';
import '../../../../../../injection_container.dart';
import '../widgets/overview_menu/overview_widgets.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
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
            context, "${AppLocalizations.of(context)!.overview}"),
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
                            title: "มุมมองภาพรวม",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EmployeesNum(bloc: overviewBloc),
                                OtMoreThan36(bloc: overviewBloc)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return SexBox(
                                        sex:
                                            "${AppLocalizations.of(context)!.male}",
                                        svgPath:
                                            "assets/icons/overview_manager/male.svg",
                                        num: state.overviewData?.employeeInfo!
                                                .maleTotal ??
                                            0,
                                        color: Color(0xff85CCFF));
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return SexBox(
                                        sex:
                                            "${AppLocalizations.of(context)!.female}",
                                        svgPath:
                                            "assets/icons/overview_manager/female.svg",
                                        num: state.overviewData?.employeeInfo!
                                                .femaleTotal ??
                                            0,
                                        color: Color(0xffFFB8E3));
                                  },
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ExpenseBox(
                                title:
                                    '${AppLocalizations.of(context)!.pdaywages}',
                                value: state.overviewData?.salaryTotal ?? 0,
                                svgPath:
                                    "assets/icons/overview_manager/money.svg",
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ChartExpense(
                                  overviewData: state.overviewData,
                                  date: state.date);
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ExpenseBox(
                                title:
                                    '${AppLocalizations.of(context)!.oTTotal}',
                                value: state.overviewData != null
                                    ? state.overviewData!.otTotal!.the2!
                                            .payTotal! +
                                        state.overviewData!.otTotal!.the15!
                                            .payTotal! +
                                        state.overviewData!.otTotal!.the3!
                                            .payTotal!
                                    : 0,
                                svgPath:
                                    "assets/icons/overview_manager/ot_expense.svg",
                              );
                            },
                          ),

                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ChartOt(
                                overviewData: state.overviewData,
                                date: state.date,
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return OtChart(
                                overviewData: state.overviewData,
                                date: state.date,
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return Top5Absence(
                                overviewData: state.overviewData,
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return LeaveOverviewEachMonth(
                                  date: state.date,
                                  overviewData: state.overviewData);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return MeanBox(
                                        title:
                                            "${AppLocalizations.of(context)!.averageAge}",
                                        age:
                                            "${state.overviewData?.employeeInfo!.averageAge ?? 0}");
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                BlocBuilder<OverviewBloc, OverviewState>(
                                  builder: (context, state) {
                                    return MeanBox(
                                        title:
                                            "${AppLocalizations.of(context)!.averageWork}",
                                        age:
                                            "${state.overviewData?.employeeInfo!.averageWorkExperience ?? 0}");
                                  },
                                ),
                              ],
                            ),
                          ),
                          // TODO: Leave Emp & New Emp
                          OverviewTabBar(),
                          // TODO: Turn Over
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                TurnOverBox(title: "Turnover Rate", rate: 0),
                                const SizedBox(
                                  width: 15,
                                ),
                                TurnOverBox(title: "Turnover Year", rate: 0)
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
