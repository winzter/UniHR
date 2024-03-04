import 'package:flutter/material.dart';
import 'package:unihr/src/features/manager/overview/presentation/pages/overview_main_page.dart';
import 'package:unihr/src/features/manager/waiting_status/presentation/pages/waiting_status.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../employees_list/presentation/pages/employees_list_page.dart';
import 'circle_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuCircle extends StatelessWidget {
  const MenuCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider managerProfileProvider = ProfileProvider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.006,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleIcons(
              ["assets/icons/grey_overview.svg", "assets/icons/overview.svg"],
              AppLocalizations.of(context)!.overview,
              page: OverviewMainPage(),
              isDisable: managerProfileProvider.isLoading,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CircleIcons(
              [
                "assets/icons/grey_profile.svg",
                "assets/icons/user_profile.svg"
              ],
              AppLocalizations.of(context)!.employee,
              page: EmployeesListPage(),
              isDisable: managerProfileProvider.isLoading,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CircleIcons(
              ["assets/icons/grey_travel.svg", "assets/icons/travel.svg"],
              "${AppLocalizations.of(context)!.workRecord}",
              page: null,
              isDisable: true,
              index: 0,
              isLogOut: false,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleIcons(
              [
                "assets/icons/grey_work_time_table.svg",
                "assets/icons/work_time_table.svg"
              ],
              AppLocalizations.of(context)!.timeAttendance,
              page: null,
              isDisable: managerProfileProvider.isLoading,
              index: 2,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CircleIcons(
              [
                "assets/icons/grey_list_status.svg",
                "assets/icons/list_status.svg"
              ],
              "${AppLocalizations.of(context)!.requestlisthistory}",
              page: null,
              isDisable: true,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CircleIcons(
              [
                "assets/icons/grey_list_status.svg",
                "assets/icons/list_status.svg"
              ],
              "${AppLocalizations.of(context)!.logout}",
              page: null,
              isDisable: false,
              index: 0,
              isLogOut: true,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleIcons(
              ["assets/icons/grey_wait_list.svg", "assets/icons/wait_list.svg"],
              AppLocalizations.of(context)!.pendingapproval,
              page: WaitingStatusPage(),
              isDisable: managerProfileProvider.isLoading,
              index: 0,
              isLogOut: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CircleIcons(
              ["assets/icons/grey_leave.svg", "assets/icons/leave.svg"],
              "${AppLocalizations.of(context)!.leaves}",
              page: null,
              isDisable: true,
              index: 0,
              isLogOut: false,
            ),
          ],
        )
      ],
    );
  }
}
