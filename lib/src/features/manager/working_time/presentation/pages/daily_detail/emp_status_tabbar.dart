import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/components/widgets/error_warning.dart';
import 'package:unihr/src/features/manager/working_time/presentation/bloc/daily_detail_bloc/working_time_bloc.dart';
import '../../../../../../../injection_container.dart';
import '../../../domain/entities/entities.dart';
import '../../widgets/daily_detail/widgets_daily_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeStatusTabBar extends StatefulWidget {
  const EmployeeStatusTabBar({super.key});

  @override
  State<EmployeeStatusTabBar> createState() => _EmployeeStatusTabBarState();
}

class _EmployeeStatusTabBarState extends State<EmployeeStatusTabBar>
    with SingleTickerProviderStateMixin {
  List<EmployeesEntity> empData = [];
  final WorkingTimeBloc workingTimeBloc = sl<WorkingTimeBloc>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    workingTimeBloc.add(GetWorkingTimeData(
        start: DateFormat('yyyy-MM-dd').format(DateTime.now())));
  }

  void updateEmpData(List<EmployeesEntity> newData) {
    setState(() {
      empData = newData;
    });
  }

  Widget tabs(int index, String title, Color color) {
    return Tab(
      child: Container(
        width: 120,
        // height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: _tabController.index == index ? color : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => workingTimeBloc,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        setState(() {
                          _tabController.index = index;
                        });
                      },
                      padding: EdgeInsets.all(0),
                      labelPadding: EdgeInsets.all(0),
                      indicator: const BoxDecoration(),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xff757575),
                      tabs: [
                        tabs(0, "${AppLocalizations.of(context)!.clockin}",
                            Color(0xff30B98F)),
                        tabs(1, "${AppLocalizations.of(context)!.clockout}",
                            Color(0xffE46A76)),
                        tabs(2, "${AppLocalizations.of(context)!.leave}",
                            Color(0xffFFCA11)),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024,
            ),
            SearchForm(
              bloc: workingTimeBloc,
              empData: empData,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024,
            ),
            Expanded(
              child: BlocBuilder<WorkingTimeBloc, WorkingTimeState>(
                builder: (context, state) {
                  if (state is WorkingTimeInitial) {
                    return Text("กำลังโหลดข้อมูล");
                  } else if (state is WorkingTimeLoading) {
                    return ShimmerDaily(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height);
                  }
                  else if (state is WorkingTimeLoaded) {
                    empData = state.empData;
                    return Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              CheckIn(
                                empAttendance: state.empAttendanceCheckIn,
                                isCheckIn: true,
                              ),
                              CheckIn(
                                empAttendance: state.empAttendanceCheckOut,
                                isCheckIn: false,
                              ),
                              Leave(empLeave: state.empLeave),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  else if (state is WorkingTimeFailure) {
                    return ErrorWarning(errorMsg: state.error.errMsgText!);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
