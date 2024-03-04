import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../provider/leave_provider.dart';
import 'waiting_listtile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateTimeWorkingWaiting extends StatefulWidget {
  const DateTimeWorkingWaiting({super.key});

  @override
  State<DateTimeWorkingWaiting> createState() => _DateTimeWorkingWaitingState();
}

class _DateTimeWorkingWaitingState extends State<DateTimeWorkingWaiting> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<WaitingProvider>(context, listen: true);
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    if (profile.isLoading) {
      return Center(
          child: Text(
        AppLocalizations.of(context)!.loading,
        style: TextStyle(fontSize: 17),
      ));
    } else if (data.leaveNotApprove.isNotEmpty || data.requestTimeNotApprove.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (data.requestTimeNotApprove.length + data.leaveNotApprove.length) < 2
            ? (data.requestTimeNotApprove.length + data.leaveNotApprove.length)
            : 2,
        itemBuilder: (context, index) {
          print((data.requestTime.length).abs());
          if (index < data.requestTimeNotApprove.length) {
            return WaitingLisTile(
              requestTime: data.requestTimeNotApprove[index],
              dataLeave: null,
            );
          } else {
            return WaitingLisTile(
              dataLeave: data.leaveHistory[index],
              requestTime: null,
            );
          }
        },
      );
    } else {
      return Center(
          child: Text(
        AppLocalizations.of(context)!.noitemswaitingforapprovalfound,
        style: TextStyle(fontSize: 17),
      ));
    }
  }
}
