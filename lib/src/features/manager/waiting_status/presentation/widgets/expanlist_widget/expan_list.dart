import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/manager/waiting_status/presentation/widgets/expanlist_widget/list_change_time.dart';
import 'package:unihr/src/features/manager/waiting_status/presentation/widgets/expanlist_widget/list_withdraw_item.dart';
import 'package:unihr/src/features/user/item_status/domain/entities/entities.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/waiting_status_bloc.dart';
import '../../providers/radio_button_provider.dart';
import 'list_item.dart';
import 'list_ot_item.dart';

class ExpansionList extends StatefulWidget {
  final List<LeaveRequestManager> leaveData;
  final List<RequestTimeManager> requestTimeData;
  final List<WithdrawLeaveManager> withdrawData;
  final List<ChangeTimeManager> changeTimeData;
  final PayrollSettingEntity payrollSettingData;
  final List<dynamic> dataRequestTime;
  final List<dynamic> dataRequestOT;
  final WaitingStatusBloc bloc;

  const ExpansionList({
    super.key,
    required this.leaveData,
    required this.requestTimeData,
    required this.withdrawData,
    required this.changeTimeData,
    required this.dataRequestTime,
    required this.dataRequestOT,
    required this.payrollSettingData,
    required this.bloc,
  });

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  @override
  Widget build(BuildContext context) {
    print(widget.withdrawData.length);
    final radioProvider = Provider.of<ManagerRadioButtonProvider>(context);
    return Expanded(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: (() {
              if (radioProvider.type == "ขอลา" && widget.leaveData.isNotEmpty) {
                return widget.leaveData.length;
              } else if (radioProvider.type == "ขอรับรองเวลาทำงาน" &&
                  widget.requestTimeData.isNotEmpty) {
                return widget.dataRequestTime.length;
              } else if (radioProvider.type == "ขอทำงานล่วงเวลา" &&
                  widget.requestTimeData.isNotEmpty) {
                return widget.dataRequestOT.length;
              } else if (radioProvider.type == "ขอเปลี่ยนกะ" &&
                  widget.changeTimeData.isNotEmpty) {
                return widget.changeTimeData.length;
              } else if (radioProvider.type == "ขอถอนลา" &&
                  widget.withdrawData.isNotEmpty) {
                return widget.withdrawData.length;
              } else {
                return 0;
              }
            })(),
            itemBuilder: (context, index) {
              if (radioProvider.type == "ขอลา" && widget.leaveData.isNotEmpty) {
                return ListItems(
                  index: index,
                  dataLeave: widget.leaveData[index],
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
                  isSelectAll: radioProvider.isSelectAll,
                );
              } else if (radioProvider.type == "ขอรับรองเวลาทำงาน" &&
                  widget.requestTimeData.isNotEmpty) {
                return ListItems(
                  index: index,
                  requestTime: widget.dataRequestTime[index],
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
                  isSelectAll: radioProvider.isSelectAll,
                );
              } else if (radioProvider.type == "ขอทำงานล่วงเวลา" &&
                  widget.requestTimeData.isNotEmpty) {
                return ListOTItems(
                  index: index,
                  requestTime: widget.dataRequestOT[index],
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
                  isSelectAll: radioProvider.isSelectAll,
                );
              } else if (radioProvider.type == "ขอเปลี่ยนกะ" &&
                  widget.changeTimeData.isNotEmpty) {
                return ListItemsChangeTime(
                  index: index,
                  changeTimeData: widget.changeTimeData[index],
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
                  isSelectAll: radioProvider.isSelectAll,
                );
              } else if (radioProvider.type == "ขอถอนลา" &&
                  widget.withdrawData.isNotEmpty) {
                return ListWithdrawItems(
                  index: index,
                  withdrawData: widget.withdrawData[index],
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
                  isSelectAll: radioProvider.isSelectAll,
                );
              }
              return Container();
            }));
  }
}
