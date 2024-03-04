import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../bloc/overview_bloc.dart';
import '../widgets/overtime_menu/overtime_widgets.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OvertimePage extends StatefulWidget {
  const OvertimePage({super.key});

  @override
  State<OvertimePage> createState() => _OvertimePageState();
}

class _OvertimePageState extends State<OvertimePage> {
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
            context, "${AppLocalizations.of(context)!.overtimedashboard}"),
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
                            title: "ข้อมูลค่าล่วงเวลา",
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
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ExpenseBox(
                                title:
                                    '${AppLocalizations.of(context)!.overtime}',
                                value: state.overtimeData != null
                                    ? (state.overtimeData!.otTotal!.the15!.hourTotal! +
                                        state.overtimeData!.otTotal!.the2!
                                            .hourTotal! +
                                        state.overtimeData!.otTotal!.the3!
                                            .hourTotal!)
                                    : 0,
                                svgPath:
                                    "assets/icons/overview_manager/overtime_clock.svg",
                                isExpense: false,
                              );
                            },
                          ),
                          BlocBuilder<OverviewBloc, OverviewState>(
                            builder: (context, state) {
                              return ExpenseBox(
                                title:
                                    '${AppLocalizations.of(context)!.oTTotal}',
                                value: state.overtimeData != null
                                    ? (state.overtimeData!.otTotal!.the15!.payTotal! +
                                        state.overtimeData!.otTotal!.the2!
                                            .payTotal! +
                                        state.overtimeData!.otTotal!.the3!
                                            .payTotal!)
                                    : 0,
                                svgPath:
                                    "assets/icons/overview_manager/pink_ot_expense.svg",
                                isExpense: true,
                              );
                            },
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
                              return Top5Overtime36(
                                overtimeData: state.overtimeData,
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
