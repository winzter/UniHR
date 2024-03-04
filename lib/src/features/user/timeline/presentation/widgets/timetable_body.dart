import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../bloc/timeline_bloc.dart';
import '../pages/day_detail_page.dart';
import 'time_line_body/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeTableBody extends StatelessWidget {
  final List<TimeLineEntity> attendanceData;
  final TimelineBloc timelineBloc;
  final List<String> reasons;
  final List<TimeLineEntity> showingData;
  final PayrollSetting payrollData;
  final List<ReasonEntity> reasonAllData;
  final DateTime startMonth;
  const TimeTableBody({
    super.key,
    required this.attendanceData,
    required this.showingData,
    required this.reasons,
    required this.reasonAllData,
    required this.payrollData,
    required this.timelineBloc,
    required this.startMonth,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: showingData.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CardList(
              data: showingData[index],
              attendanceData: attendanceData,
              index: index,
              reasons: reasons,
              reasonAllData: reasonAllData,
              payrollData: payrollData,
              timelineBloc: timelineBloc,
              startMonth: startMonth,
            ),
            if (DateFormat('EE').format(showingData[index].date!) == "อา.")
              const Divider(
                thickness: 10,
                color: Color(0xffEAEDF2),
                height: 35,
              ),
            if (DateFormat('EE').format(showingData[index].date!) == "Sun")
              const Divider(
                thickness: 10,
                color: Color(0xffEAEDF2),
                height: 35,
              ),
          ],
        );
      },
    );
  }
}

class CardList extends StatelessWidget {
  final int index;
  final TimeLineEntity data;
  final List<TimeLineEntity> attendanceData;
  final TimelineBloc timelineBloc;
  final List<String> reasons;
  final PayrollSetting payrollData;
  final List<ReasonEntity> reasonAllData;
  final DateTime startMonth;
  const CardList({
    super.key,
    required this.data,
    required this.attendanceData,
    required this.index,
    required this.reasons,
    required this.reasonAllData,
    required this.payrollData,
    required this.timelineBloc,
    required this.startMonth,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: DayDetailPage(
                    index: index,
                    attendanceData: attendanceData,
                    data: data,
                    reasons: reasons,
                    reasonAllData: reasonAllData,
                    payrollData: payrollData,
                  ))).then((value) {
            if (value != null && value) {
              timelineBloc.add(GetTimeLineData(
                  startDate: DateTime(startMonth.year, startMonth.month, 1),
                  endDate: DateTime(startMonth.year, startMonth.month + 1, 0),
                  idCompany: userData.profileData.idCompany!,
                  currentTime: DateTime.now()));
            }
          });
        },
        child: Container(
          height: data.attendance!.checkIn!.length > 1 ||
                  data.attendance!.checkOut!.length > 1
              ? 250
              : 180,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Row(
            children: [
              Expanded(
                  flex: 20,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: dayColors(data),
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20)),
                        border: Border.all(color: Colors.transparent)),
                    child: Center(
                        child: Text(
                      DateFormat("EE").format(data.date!),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                  )),
              Expanded(
                flex: 85,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 50,
                            child: Center(
                                child: Text(
                              DateFormat("dd/MM/yyyy").format(data.date!),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                          ),
                          if (data.pattern!.isWorkingDay == 0) ...[
                            Expanded(
                              flex: 50,
                              child: Center(
                                  child: Text("${data.pattern!.shiftTypeName}",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ))),
                            ),
                          ]
                          else ...[
                            Expanded(
                              flex: 50,
                              child: data.pattern!.timeIn == null
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .notimetowork,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                          "${data.pattern!.timeIn!.substring(0, 5)} - ${data.pattern!.timeOut!.substring(0, 5)}",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ))),
                            ),
                          ]
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: IsCheckIn(
                              data: data,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: CheckInLocation(
                              data: data,
                            )),
                      ],
                    ),
                    if (data.attendanceDisplay!.length > 1) ...[
                      Row(
                        children: [
                          Expanded(
                              flex: 50,
                              child: IsCheckInRoundTwo(
                                data: data,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 50,
                              child: CheckInLocationTwo(
                                data: data,
                              )),
                        ],
                      ),
                    ],
                    Row(
                      children: [
                        Expanded(
                            child: StatusIcon(
                          data: data,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: StatusIconMore(
                          data: data,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        if (data.holiday != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Container(
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffe8e1f6),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  AppLocalizations.of(context)!.annualholiday,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.purple, fontWeight: FontWeight.bold),
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                            height: 5,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
