import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/components/widgets/shimmer.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/error_warning.dart';
import '../../../home/presentation/provider/leave_provider.dart';
import '../bloc/item_status_bloc.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemStatusPage extends StatefulWidget {
  const ItemStatusPage({super.key});

  @override
  State<ItemStatusPage> createState() => _ItemStatusPageState();
}

class _ItemStatusPageState extends State<ItemStatusPage> {
  final itemStatusBloc = sl<ItemStatusBloc>();

  @override
  Widget build(BuildContext context) {
    final numNotApprove = Provider.of<WaitingProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context, "สถานะรายการ"),
      body: BlocProvider(
        create: (_) => itemStatusBloc,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Column(
            children: [
              RadioButtonMenu(itemStatusBloc: itemStatusBloc),
              const StatusListIcon(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.pendingapproval} ${numNotApprove.numRequestIsNotApprove()} ${AppLocalizations.of(context)!.list}",
                    style: TextStyle(color: const Color(0xff757575)),
                  )
                ],
              ),
              BlocConsumer<ItemStatusBloc, ItemStatusState>(
                  listener: (context, state) {
                if (state is ItemStatusSendRequestSuccess) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    confirmBtnText: "${AppLocalizations.of(context)!.close}",
                    confirmBtnColor: const Color(0xff6ae4a3),
                    title:
                        "${AppLocalizations.of(context)!.datasavesuccessful}",
                  );
                } else if (state is ItemStatusSendRequestFailed) {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      confirmBtnText: "${AppLocalizations.of(context)!.close}",
                      confirmBtnColor: const Color(0xffE46A76),
                      title: "${AppLocalizations.of(context)!.anerroroccurred}",
                      text: "ไม่สามารถส่งข้อมูลลบคำขอได้ กรุณาติดต่อแอดมิน");
                }
              }, builder: (context, state) {
                if (state is ItemStatusInitial) {
                  return Text(
                    "${AppLocalizations.of(context)!.nodata}",
                    style: TextStyle(),
                  );
                } else if (state is ItemStatusLoading) {
                  return Expanded(
                      child: ShimmerComponent(
                          width: MediaQuery.of(context).size.width,
                          height: 100));
                } else if (state is ItemStatusLoaded) {
                  return ExpansionList(
                    leaveData: state.leaveData ?? [],
                    requestTimeData: state.requestTimeData ?? [],
                    withdrawData: state.withdrawData ?? [],
                    allData: state.allData ?? [],
                    payrollSettingData: state.payrollSettingData,
                    dataRequestTime: state.dataRequestTime ?? [],
                    dataRequestOT: state.dataRequestOT ?? [],
                    dataRequestCompensate: state.dataRequestCompensate ?? [],
                    bloc: itemStatusBloc,
                  );
                } else if (state is ItemStatusSendRequestSuccess) {
                  return ExpansionList(
                    leaveData: state.leaveData ?? [],
                    requestTimeData: state.requestTimeData ?? [],
                    withdrawData: state.withdrawData ?? [],
                    allData: state.allData ?? [],
                    payrollSettingData: state.payrollSettingData,
                    dataRequestTime: state.dataRequestTime ?? [],
                    dataRequestOT: state.dataRequestOT ?? [],
                    dataRequestCompensate: state.dataRequestCompensate ?? [],
                    bloc: itemStatusBloc,
                  );
                } else if (state is ItemStatusStateFailure) {
                  return ErrorWarning(
                    errorMsg: state.error.errMsgText ?? "",
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
