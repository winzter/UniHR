import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quiver/time.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/widgets.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/leave_authority_list.dart';
import 'leave_form_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveAuthorityPage extends StatefulWidget {
  const LeaveAuthorityPage({super.key});

  @override
  State<LeaveAuthorityPage> createState() => _LeaveAuthorityPageState();
}

class _LeaveAuthorityPageState extends State<LeaveAuthorityPage>
    with AutomaticKeepAliveClientMixin {
  final LeaveBloc leaveAuthBloc = sl<LeaveBloc>();
  final DateTime now = DateTime.now();
  List<TempDropDownMenu> labelData = [];
  DateTime? resetDate;
  TempDropDownMenu? selectedPeriod;

  @override
  void initState() {
    super.initState();
    leaveAuthBloc.add(GetAllLeaveData());
    // leaveAuthBloc.add(GetLeaveSettingEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final allLoading = Provider.of<ProfileProvider>(context);
    return BlocProvider(
      create: (context) => leaveAuthBloc,
      child: RefreshIndicator(
        onRefresh: () async {
          leaveAuthBloc.add(GetAllLeaveData());
          // leaveAuthBloc.add(GetLeaveSettingEvent());
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 5, right: 5, bottom: 60),
              child:
                  BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
                if (state is LeaveInitial) {
                  return Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.loadingData}",
                      style: TextStyle(fontSize: 17),
                    ),
                  );
                } else if (state.status == FetchStatus.fetching ||
                    allLoading.isLoading) {
                  return const ShimmerComponent(
                    width: 200,
                    height: 100,
                  );
                }
                else if (state.status == FetchStatus.success) {
                  return LeaveAuthorityList(
                    leaveAuthority: state.leaveAvailableData,
                    leaveData: state.leaveKeyData,
                    leaveSettingData: state.leaveSetting!,
                    bloc: leaveAuthBloc,
                  );
                } else if (state.status == FetchStatus.failed) {
                  return ErrorWarning(errorMsg: state.error?.errMsgText??"",);
                } else {
                  return Text(
                      "${AppLocalizations.of(context)!.thereisnoinformationonleaverights}");
                }
              }),
            ),
            BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                if (state.status == FetchStatus.success) {
                  return Positioned(
                      bottom: 85,
                      right: 15,
                      child: FloatingActionButton(
                        heroTag: "formbtn",
                        elevation: 5,
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      child: LeaveFormPage(
                                        data: state.leaveAvailableData,
                                        historyData: state.leaveHistoryData,
                                        managerData: state.managerData,
                                        holidayLeave: state.holidayLeave,
                                        startPeriodDate: state.startPeriodDate!,
                                        endPeriodDate: state.endPeriodDate!,
                                        bloc: leaveAuthBloc,
                                      ),
                                      type: PageTransitionType.leftToRight))
                              .then((value) {
                            if (value != null && value) {
                              resetDate = DateTime(
                                now.year,
                                state.leaveSetting!.resetEndOfMonth ?? 0,
                                daysInMonth(now.year,
                                    state.leaveSetting!.resetEndOfMonth ?? 0),
                              );
                              for (var i = -1; i < 1; i++) {
                                resetDate = DateTime(
                                  now.year + i,
                                  state.leaveSetting!.resetEndOfMonth ?? 0,
                                  daysInMonth(now.year + i,
                                      state.leaveSetting!.resetEndOfMonth ?? 0),
                                );
                                var startDate = DateTime(
                                    now.year + i, resetDate!.month - 11, 1);
                                var endDate = DateTime(now.year + i,
                                    resetDate!.month, resetDate!.day);
                                labelData.add(TempDropDownMenu(
                                  start: startDate,
                                  end: endDate,
                                  label:
                                      "${DateFormat("dd-MMM-yyyy").format(startDate)} - ${DateFormat("dd-MMM-yyyy").format(endDate)}",
                                ));
                              }
                              selectedPeriod = labelData[1];
                              leaveAuthBloc.add(GetLeaveAvailableEvent(
                                  start: labelData[1].start,
                                  end: labelData[1].end));
                              leaveAuthBloc.add(GetAllLeaveData());
                            }
                          });
                        },
                        backgroundColor: const Color(0xffE793B8),
                        child: Icon(
                          state.leaveAvailableData.isEmpty
                              ? Icons.refresh
                              : Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ));
                }
                return const SizedBox();
              },
            )
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
