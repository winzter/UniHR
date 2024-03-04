import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/payslip/presentation/pages/national_id_auth.dart';
import 'package:unihr/src/features/user/payslip/presentation/pages/payslip_page.dart';
import 'package:unihr/src/features/user/time_management/presentation/pages/time_management_page.dart';
import 'package:unihr/src/features/user/working_record/presentation/pages/work_record_page.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../manager/employees_list/presentation/pages/employees_list_page.dart';
import '../../../../manager/overview/presentation/pages/overview_main_page.dart';
import '../../../../manager/waiting_status/presentation/pages/waiting_status.dart';
import '../../../../manager/working_time/presentation/pages/working_time_normal_page.dart';
import '../../../item_status/presentation/pages/item_status_page.dart';
import '../../../shift_ot/presentation/pages/shift_ot_page.dart';
import '../../../travelling/presentation/pages/travelling_page.dart';
import 'circle_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuCircle extends StatelessWidget {
  const MenuCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userData = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.006,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleIcons(
              [
                "assets/icons/grey_profile.svg",
                "assets/icons/user_profile.svg"
              ],
              AppLocalizations.of(context)!.profile,
              page: null,
              isDisable: userData.isLoading,
              index: 4,
            ),
            CircleIcons(
              [
                "assets/icons/grey_work_time_table.svg",
                "assets/icons/work_time_table.svg"
              ],
              AppLocalizations.of(context)!.timetable,
              page: null,
              isDisable: userData.isLoading,
              index: 1,
            ),
            CircleIcons(
              ["assets/icons/grey_leave.svg", "assets/icons/leave.svg"],
              AppLocalizations.of(context)!.leave,
              page: null,
              isDisable: userData.isLoading,
              index: 3,
            ),
            CircleIcons(
              [
                "assets/icons/grey_list_status.svg",
                "assets/icons/list_status.svg"
              ],
              AppLocalizations.of(context)!.requestList,
              page: userData.isLoading ? null : ItemStatusPage(),
              isDisable: userData.isLoading,
              index: 0,
            ),
            CircleIcons(
              [
                "assets/icons/grey_work_time_manage.svg",
                "assets/icons/work_time_manage.svg"
              ],
              AppLocalizations.of(context)!.timeManagement,
              page: userData.isLoading ||
                      userData.profileData.workingType != "Day"
                  ? null
                  : TimeManagementPage(),
              isDisable: userData.isLoading ||
                  userData.profileData.workingType != "Day",
              index: 0,
            ),
            CircleIconsWIthNull(
              AppLocalizations.of(context)!.workRecord,
              page: WorkRecordPage(),
              isDisable: userData.isLoading,
              index: 0,
              icons: Icons.work_history,
            ),
            CircleIconsWIthNull(
              "My Skill",
              page: null,
              isDisable: true,
              index: 0,
              icons: Icons.menu_book_sharp,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleIcons(
                ["assets/icons/grey_shift_ot.svg", "assets/icons/shift_ot.svg"],
                AppLocalizations.of(context)!.summaryTime,
                page: userData.isLoading ? null : SummaryShiftAndOTPage(),
                isDisable: userData.isLoading,
                index: 0),
            CircleIcons(
                ["assets/icons/grey_payslip.svg", "assets/icons/payslip.svg"],
                AppLocalizations.of(context)!.salarySlip,
                page: userData.isLoading
                    ? null
                    : (userData.isPayslipValidate
                        ? PaySlipPage()
                        : NationalIdAuth()),
                isDisable: userData.isLoading,
                index: 0),
            CircleIcons(
              ["assets/icons/grey_learning.svg", "assets/icons/learning.svg"],
              AppLocalizations.of(context)!.learning,
              page: null,
              isDisable: true,
              index: 0,
            ),
            CircleIcons(
                ["assets/icons/grey_my_paper.svg", "assets/icons/my_paper.svg"],
                AppLocalizations.of(context)!.document,
                page: null,
                isDisable: true,
                index: 0),
            CircleIcons(
                ["assets/icons/grey_travel.svg", "assets/icons/travel.svg"],
                AppLocalizations.of(context)!.travelling,
                page: userData.isLoading ? null : TravellingPage(),
                isDisable: userData.isLoading,
                index: 0),
            // CircleIconsWIthNull(
            //   "ลงเวลา Bluetooth",
            //   page: null,
            //   isDisable: true,
            //   index: 0,
            //   icons: Icons.bluetooth_connected,
            // ),
            CircleIconsWIthNull(
              "Employee\nNetwork",
              // page: userData.isLoading?null:EmployeeNetworkPage(),
              page: null,
              // isDisable: userData.isLoading,
              isDisable: true,
              index: 0,
              icons: Icons.people,
            ),
            CircleIconsWIthNull(
              "Notifications",
              page: null,
              isDisable: true,
              index: 0,
              icons: Icons.notifications,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}

class MenuUserManagerCircle extends StatelessWidget {
  const MenuUserManagerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.006,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleIcons(
              ["assets/icons/grey_overview.svg", "assets/icons/overview.svg"],
              AppLocalizations.of(context)!.overview,
              page: OverviewMainPage(),
              isDisable: false,
              index: 0,
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
              isDisable: false,
              index: 0,
            ),
            CircleIcons(
              [
                "assets/icons/grey_work_time_table.svg",
                "assets/icons/work_time_table.svg"
              ],
              AppLocalizations.of(context)!.timeAttendance,
              page: WorkingTimeNormalPage(),
              isDisable: false,
              index: 0,
            ),
            CircleIcons([
              "assets/icons/grey_wait_list.svg",
              "assets/icons/wait_list.svg"
            ], AppLocalizations.of(context)!.pendingapproval,
                page: WaitingStatusPage(), isDisable: false, index: 0),
          ],
        ),
      ],
    );
  }
}
