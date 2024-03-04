import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../components/widgets/tabbar_menu.dart';
import '../../../../../core/error/token_expires.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'leave_authorities_page.dart';
import 'leave_history_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  Future<bool> onBackPress() async {
    final NavIndex navigationProvider =
        Provider.of<NavIndex>(context, listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: TabBarMenu(
        childrenWidget: [LeaveAuthorityPage(), LeaveHistoryPage()],
        svgPaths: [
          "assets/icons/request_leave.svg",
          "assets/icons/history.svg"
        ],
        title: [
          AppLocalizations.of(context)!.leaverights,
          AppLocalizations.of(context)!.leaverecord
        ],
        width: 20,
      ),
    );
  }
}
