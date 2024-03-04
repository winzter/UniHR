import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:quiver/time.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/error_warning.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/leave_authority_list.dart';
import '../widgets/leave_history_list.dart';
import '../../../../../components/widgets/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveHistoryPage extends StatefulWidget {
  const LeaveHistoryPage({
    super.key,
  });

  @override
  State<LeaveHistoryPage> createState() => _LeaveHistoryPageState();
}

class _LeaveHistoryPageState extends State<LeaveHistoryPage> {
  final leaveBloc = sl<LeaveBloc>();
  final DateTime now = DateTime.now();
  List<TempDropDownMenu> labelData = [];
  DateTime? resetDate;
  TempDropDownMenu? selectedPeriod;

  @override
  void initState() {
    super.initState();
    leaveBloc.add(GetLeaveHistoryData(year: selectedPeriod?.start));
    // leaveBloc.add(GetLeaveSettingEvent());
    setState(() {});
  }

  OutlineInputBorder borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  @override
  Widget build(BuildContext context) {
    final allLoading = Provider.of<ProfileProvider>(context);
    return BlocProvider(
      create: (context) => leaveBloc,
      child: RefreshIndicator(
        onRefresh: () async =>
            leaveBloc.add(GetLeaveHistoryData(year: selectedPeriod?.start)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, left: 15, right: 15, bottom: 5),
                  child: DropdownButtonFormField2(
                    value: selectedPeriod,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: borderStyle,
                        errorStyle: TextStyle(fontSize: 14),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        border: borderStyle,
                        enabledBorder: borderStyle),
                    items: labelData.isNotEmpty
                        ? labelData.map<DropdownMenuItem<TempDropDownMenu>>(
                            (TempDropDownMenu value) {
                            return DropdownMenuItem<TempDropDownMenu>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value.label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'kanit',
                                    ),
                                  ),
                                ));
                          }).toList()
                        : [
                            DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: "",
                              enabled: false,
                              child: Text(
                                AppLocalizations.of(context)!.nodata,
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                    hint: Center(
                        child: Text(
                            "${AppLocalizations.of(context)!.choosealeaveframe}")),
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (dynamic value) {
                      if (value != "") {
                        selectedPeriod = value!;
                        leaveBloc.add(GetLeaveHistoryData(year: value.start));
                        setState(() {});
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BlocConsumer<LeaveBloc, LeaveState>(
                    builder: (context, state) {
                      if (state is LeaveInitial) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.loadingData,
                            style: TextStyle(fontSize: 17),
                          ),
                        );
                      }
                      else if (state.status == FetchStatus.fetching || allLoading.isLoading) {
                        return const ShimmerComponent(
                          width: 200,
                          height: 200,
                        );
                      }
                      else if (state.status == FetchStatus.success) {
                        return (state.leaveHistoryData.length > 0 && selectedPeriod != null)
                            ? LeaveHistoryList(
                                leaveHistory: state.leaveHistoryData,
                                bloc: leaveBloc,
                                dateFrame: selectedPeriod!.start,
                              )
                            : Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .noleavehistoryfound,
                                  style: TextStyle(fontSize: 17),
                                ),
                              );
                      }
                      else if (state.status == FetchStatus.failed) {
                        return ErrorWarning(errorMsg: state.error!.errMsgText!,);
                      }
                      else {
                        return Text("${AppLocalizations.of(context)!.loading}");
                      }
                    },
                    listener: (context, state) {
                      if (state.leaveSetting != null && selectedPeriod == null) {
                        labelData.clear();
                        for (var i = -1; i < 1; i++) {
                          resetDate = DateTime(
                            now.year + i,
                            state.leaveSetting!.resetEndOfMonth ?? 0,
                            daysInMonth(now.year + i,
                                state.leaveSetting!.resetEndOfMonth ?? 0),
                          );
                          var startDate =
                              DateTime(now.year + i, resetDate!.month - 11, 1);
                          var endDate = DateTime(
                              now.year + i, resetDate!.month, resetDate!.day);
                          labelData.add(TempDropDownMenu(
                            start: startDate,
                            end: endDate,
                            label:
                                "${DateFormat("dd-MMM-yyyy").format(startDate)} - ${DateFormat("dd-MMM-yyyy").format(endDate)}",
                          ));
                        }
                        selectedPeriod = labelData[1];
                        setState(() {});
                      }
                      if(state.status == FetchStatus.sendSuccess){
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          confirmBtnText: "ปิด",
                          confirmBtnColor: const Color(0xff30B98F),
                          title:
                          "${AppLocalizations.of(context)!.datasavesuccessful}",
                        );
                        leaveBloc.add(GetLeaveHistoryData(year: selectedPeriod?.start));
                      }
                      else if(state.status == FetchStatus.sendFailed){
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            confirmBtnText: "ปิด",
                            confirmBtnColor: const Color(0xffE46A76),
                            title: "เกิดข้อผิดพลาด",
                            text: "ไม่สามารถส่งข้อมูลลบคำขอได้ กรุณาติดต่อแอดมิน"
                        );
                        leaveBloc.add(GetLeaveHistoryData(year: selectedPeriod?.start));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
