import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/widgets/widgets.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/timeline_bloc.dart';
import '../widgets/timetable_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage>
    with AutomaticKeepAliveClientMixin {
  final TimelineBloc timelineBloc = sl<TimelineBloc>();
  final now = DateTime.now();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  DateTime? startMonth;

  @override
  void initState() {
    super.initState();
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    startMonth = DateTime.now();
    monthController.text = DateFormat("MMMM").format(now);
    yearController.text = DateFormat("yyyy").format(now);
    timelineBloc.add(GetTimeLineData(
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
        idCompany: userData.profileData.idCompany!,
        currentTime: DateTime.now()));
  }

  void monthPicker(int idCompany) {
    showMonthPicker(
      context: context,
      initialDate: startMonth,
      headerColor: const Color(0xffE793B8),
      headerTextColor: Colors.white,
      selectedMonthTextColor: Colors.white,
      selectedMonthBackgroundColor: const Color(0xffE793B8),
      unselectedMonthTextColor: Colors.black,
      roundedCornersRadius: 20,
      backgroundColor: Colors.white,
      confirmWidget: Text(
        "OK",
        style: TextStyle(color: const Color(0xffE793B8)),
      ),
      cancelWidget: Text(
        "CANCEL",
        style: TextStyle(color: const Color(0xffE793B8)),
      ),
    ).then((date) {
      if (date != null) {
        setState(() {
          startMonth = date;
          monthController.text = DateFormat("MMMM").format(date);
          yearController.text = DateFormat("yyyy").format(date);
          timelineBloc.add(GetTimeLineData(
              startDate: DateTime(date.year, date.month, 1),
              endDate: DateTime(date.year, date.month + 1, 0),
              idCompany: idCompany,
              currentTime: DateTime.now()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final allLoading = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 90,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.month,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      controller: monthController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.year,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      controller: yearController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  monthPicker(allLoading.profileData.idCompany!);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: const Color(0xffE793B8),
                      border: Border.all(color: Colors.transparent),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(17))),
                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          monthController.text = DateFormat("MMMM").format(startMonth!);
          yearController.text = DateFormat("yyyy").format(startMonth!);
          timelineBloc.add(GetTimeLineData(
              startDate: DateTime(startMonth!.year, startMonth!.month, 1),
              endDate: DateTime(startMonth!.year, startMonth!.month + 1, 0),
              idCompany: allLoading.profileData.idCompany!,
              currentTime: DateTime.now()));
        },
        child: BlocProvider(
          create: (context) => timelineBloc,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 5),
            child: BlocBuilder<TimelineBloc, TimelineState>(
              builder: (context, state) {
                if (state.status == FetchStatus.init) {
                  return Center(
                      child: Text(
                    "กำลังโหลดข้อมูล...",
                  ));
                } else if (state.status == FetchStatus.fetching || allLoading.isLoading) {
                  return ShimmerComponent(
                      width: MediaQuery.of(context).size.width, height: 100);
                } else if (state.status == FetchStatus.success) {
                  return TimeTableBody(
                    attendanceData: state.attendanceData,
                    showingData: state.showingData,
                    reasons: state.reasons,
                    reasonAllData: state.reasonAllData,
                    payrollData: state.payrollData!,
                    timelineBloc: timelineBloc,
                    startMonth: startMonth ?? DateTime.now(),
                  );
                } else if (state.status == FetchStatus.failed) {
                  return ErrorWarning(errorMsg: state.error!.errMsgText!,);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    monthController.dispose();
    yearController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
