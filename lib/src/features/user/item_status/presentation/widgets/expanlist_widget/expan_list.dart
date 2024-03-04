import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/item_status_bloc.dart';
import '../../providers/radio_button_provider.dart';
import 'list_item.dart';
import 'list_withdraw.dart';

class ExpansionList extends StatefulWidget {
  final List<LeaveEntity> leaveData;
  final List<RequestTimeEntity> requestTimeData;
  final List<WithdrawEntity> withdrawData;
  final PayrollSettingEntity? payrollSettingData;
  final List<dynamic> dataRequestTime;
  final List<dynamic> dataRequestCompensate;
  final List<dynamic> dataRequestOT;
  final List<dynamic> allData;
  final ItemStatusBloc bloc;

  const ExpansionList({super.key,
    required this.leaveData,
    required this.requestTimeData,
    required this.allData,
    required this.withdrawData,
    required this.payrollSettingData,
    required this.dataRequestTime,
    required this.dataRequestCompensate,
    required this.dataRequestOT,
    required this.bloc,});

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioButtonProvider>(context);
    return Expanded(
      child:  ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (() {
            if (radioProvider.type == "all" && widget.allData.isNotEmpty) {
              return widget.allData.length + widget.withdrawData.length;
            }
            else if (radioProvider.type == "ขอลา" && widget.leaveData.isNotEmpty) {
              return widget.leaveData.length;
            }
            else if (radioProvider.type == "ขอรับรองเวลาทำงาน" && widget.dataRequestTime.isNotEmpty) {
              return widget.dataRequestTime.length;
            }
            else if (radioProvider.type == "ขอทำงานล่วงเวลา" && widget.dataRequestOT.isNotEmpty) {
              return widget.dataRequestOT.length;
            }
            else if(radioProvider.type == "ขอทำชั่วโมงCompensate" && widget.dataRequestCompensate.isNotEmpty){
              return widget.dataRequestCompensate.length;
            }
            else {
              return 0;
            }
          })(),
          itemBuilder: (context, index) {
            if (radioProvider.type == "all") {
              try {
                if (index < widget.requestTimeData.length) {
                  return ListItems(
                      index:index,
                      requestTime: widget.requestTimeData[index],
                      withdrawData: widget.withdrawData,
                      type:radioProvider.type,
                      bloc: widget.bloc,
                    payrollSettingData: widget.payrollSettingData,);
                } else if (index >= widget.requestTimeData.length
                    && (index - widget.requestTimeData.length).abs() < widget.leaveData.length) {
                  return ListItems(index:index,
                      dataLeave: widget.leaveData[(index - widget.requestTimeData.length).abs()],
                      withdrawData: widget.withdrawData,
                      type:radioProvider.type,
                      payrollSettingData: widget.payrollSettingData,
                      bloc: widget.bloc,
                  );
                } else {
                  return ListWithdrawItems(
                    index:index,
                    withdrawData:widget.withdrawData[
                    (index - widget.requestTimeData.length).abs() -
                        widget.leaveData.length], leaveData: widget.leaveData,);
                }
              } catch (e) {
                log("List Status type = all Error : $e");
              }
            }
            else if (radioProvider.type == "ขอลา") {
              return ListItems(
                  index: index,
                  dataLeave: widget.leaveData[index],
                  withdrawData: widget.withdrawData,
                  type:radioProvider.type,
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
              );
            }
            else if (radioProvider.type == "ขอรับรองเวลาทำงาน") {
              return ListItems(index: index,
                  requestTime: widget.dataRequestTime[index],
                  withdrawData: widget.withdrawData,
                  type:radioProvider.type,
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
              );
            }
            else if(radioProvider.type == "ขอทำงานล่วงเวลา"){
              return ListItems(index: index,
                  requestTime: widget.dataRequestOT[index],
                  withdrawData: widget.withdrawData,
                  type:radioProvider.type,
                  payrollSettingData: widget.payrollSettingData,
                  bloc: widget.bloc,
              );
            }
            else if(radioProvider.type == "ขอทำชั่วโมงCompensate"){
              return ListItems(index: index,
                requestTime: widget.dataRequestCompensate[index],
                withdrawData: widget.withdrawData,
                type:radioProvider.type,
                payrollSettingData: widget.payrollSettingData,
                bloc: widget.bloc,
              );
            }
            return Container(); // เหลือรอเปลี่ยนกะ
          })
    );
  }
}
