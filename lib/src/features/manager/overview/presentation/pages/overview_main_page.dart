import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewMainPage extends StatelessWidget {
  OverviewMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOverview(context, AppLocalizations.of(context)!.overview),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                MenuCard(
                  svgPath: 'assets/icons/overview_manager/income_expense.svg',
                  title: AppLocalizations.of(context)!.incomeandexpenses,
                  page: ExpensePage(),
                ),
                MenuCard(
                  svgPath: 'assets/icons/overview_manager/overview.svg',
                  title: AppLocalizations.of(context)!.overview,
                  page: OverviewPage(),
                ),
                MenuCard(
                  svgPath: 'assets/icons/overview_manager/overview_ot.svg',
                  title: AppLocalizations.of(context)!.overtimedashboard,
                  page: OvertimePage(),
                ),
                MenuCard(
                  svgPath:
                      'assets/icons/overview_manager/overview_working_time.svg',
                  title: AppLocalizations.of(context)!.attendanceOverview,
                  page: WorkingTimePage(),
                ),
                MenuCard(
                  svgPath: 'assets/icons/overview_manager/overview_expense.svg',
                  title: AppLocalizations.of(context)!.costOverview,
                  page: CostPage(),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
