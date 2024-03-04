import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/timeline_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final TimelineBloc timelineBloc = sl<TimelineBloc>();
  final now = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    timelineBloc.add(GetTimeLineData(
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
        idCompany: userData.profileData.idCompany!,
        currentTime: DateTime.now()));
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userData = Provider.of<ProfileProvider>(context);
    return BlocProvider(
      create: (context) => timelineBloc,
      child: Scaffold(body: BlocBuilder<TimelineBloc, TimelineState>(
        builder: (context, state) {
          List listOfDayEvents(DateTime dateTime) {
            if (state.status == FetchStatus.success) {
              if (state.events[DateFormat("yyyy-MM-dd").format(dateTime)] !=
                  null) {
                return state.events[DateFormat("yyyy-MM-dd").format(dateTime)]!;
              } else {
                return [];
              }
            }
            return [];
          }

          return Column(
            children: [
              TableCalendar(
                onPageChanged: (DateTime date) {
                  setState(() {
                    _focusedDay = date;
                    _selectedDay = date;
                  });
                  timelineBloc.add(GetTimeLineData(
                      startDate: DateTime(date.year, date.month, 1),
                      endDate: DateTime(date.year, date.month + 1, 0),
                      idCompany: userData.profileData.idCompany!,
                      currentTime: DateTime.now()));
                },
                daysOfWeekHeight: 45,
                rowHeight: 40,
                firstDay: DateTime.utc(2010, 01, 01),
                lastDay: DateTime.utc(2055, 12, 31),
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        fontSize: 25,
                        color: const Color(0xffE793B8),
                        fontWeight: FontWeight.w500),
                    titleCentered: true),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                eventLoader: listOfDayEvents,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events.map((event) {
                          Color markerColor;
                          if (event == 'ot') {
                            markerColor = const Color(0xff6FC9E4);
                          } else if (event == 'request_time') {
                            markerColor = const Color(0xff69EAC6);
                          } else if (event == 'absent') {
                            markerColor = const Color(0xffE793B8);
                          } else if (event == 'leave') {
                            markerColor = const Color(0xffFDC793);
                          } else if (event == "holiday") {
                            markerColor = const Color(0xff5C468A);
                          } else {
                            markerColor = Colors.grey;
                          }
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: markerColor,
                              shape: BoxShape.circle,
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Container();
                  },
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(fontSize: 16),
                  weekendTextStyle: TextStyle(fontSize: 16),
                  outsideDaysVisible: false,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    decoration: const BoxDecoration(color: Color(0xffBFBAFC)),
                    weekdayStyle: TextStyle(fontSize: 16, color: Colors.white),
                    weekendStyle: TextStyle(fontSize: 16, color: Colors.white)),
                onDaySelected: _onDaySelected,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffEAEDF2),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ValueListenableBuilder<List>(
                      valueListenable: ValueNotifier<List<String>>([
                        AppLocalizations.of(context)!.annualholiday,
                        AppLocalizations.of(context)!.overtime,
                        AppLocalizations.of(context)!.workingtimerequest,
                        AppLocalizations.of(context)!.leaverequest,
                        AppLocalizations.of(context)!.absent,
                      ]),
                      builder: (context, value, _) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 30),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(10)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          decoration: BoxDecoration(
                                              color: value[index] ==
                                                      AppLocalizations.of(context)!
                                                          .overtime
                                                  ? const Color(0xff6FC9E4)
                                                  : (value[index] ==
                                                          AppLocalizations.of(context)!
                                                              .leaverequest
                                                      ? const Color(0xffFDC793)
                                                      : (value[index] ==
                                                              AppLocalizations.of(context)!
                                                                  .workingtimerequest
                                                          ? const Color(
                                                              0xff69EAC6)
                                                          : (value[index] ==
                                                                  AppLocalizations.of(context)!
                                                                      .absent
                                                              ? const Color(
                                                                  0xffE793B8)
                                                              : const Color(
                                                                  0xff5C468A)))),
                                              borderRadius: const BorderRadius.horizontal(
                                                  left: Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.transparent)),
                                        )),
                                    Expanded(
                                      flex: 50,
                                      child: Center(
                                          child: Text(
                                        '${value[index]}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
