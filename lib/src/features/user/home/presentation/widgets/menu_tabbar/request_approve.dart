import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/leave_provider.dart';
import 'approve_listtile.dart';

class DateTimeWorkingApprove extends StatefulWidget {
  const DateTimeWorkingApprove({super.key});

  @override
  State<DateTimeWorkingApprove> createState() => _DateTimeWorkingApproveState();
}

class _DateTimeWorkingApproveState extends State<DateTimeWorkingApprove> {
  // late WaitingProvider waitingProvider;

  @override
  void initState() {
    super.initState();
    // waitingProvider = WaitingProvider.of(context,listen: false);
    // waitingProvider.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    // final data = context.watch<WaitingProvider>();
    final data = Provider.of<WaitingProvider>(context,listen:true);
    if (data.leaveApprove.isNotEmpty || data.requestTimeApprove.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (data.requestTimeApprove.length + data.leaveApprove.length) < 2?
        (data.requestTimeApprove.length + data.leaveApprove.length):2,
        itemBuilder: (context, index) {
          if (index < data.requestTimeApprove.length) {
            return ApproveListTile(requestTime: data.requestTimeApprove[index], dataLeave: null,);
          } else {
            return ApproveListTile(
                dataLeave: data.leaveApprove[(index - data.requestTimeApprove.length).abs()], requestTime: null,);
          }
        },
      );
    } else {
      return Center(
          child: Text(
            "ไม่พบรายการอนุมัติ",
            style: TextStyle(fontSize: 17),
          ));
    }
  }
}