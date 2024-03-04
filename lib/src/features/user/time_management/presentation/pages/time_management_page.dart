import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:unihr/injection_container.dart';
import 'package:unihr/src/components/widgets/shimmer.dart';
import 'package:unihr/src/features/user/time_management/presentation/bloc/time_management_bloc.dart';
import '../../../../../components/widgets/error_warning.dart';
import '../widgets/widgets.dart';

class TimeManagementPage extends StatefulWidget {
  const TimeManagementPage({super.key});

  @override
  State<TimeManagementPage> createState() => _TimeManagementPageState();
}

class _TimeManagementPageState extends State<TimeManagementPage> {
  final TimeManagementBloc timeManagementBloc = sl<TimeManagementBloc>();

  final dateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    // timeManagementBloc.add(TimeManagementLoadShiftData());
    timeManagementBloc.add(TimeManagementLoadScheduleData(
        startDate: DateFormat('yyyy-MM-dd')
            .format(DateTime(dateNow.year, dateNow.month + 2, 0)),
        date: DateTime(dateNow.year, dateNow.month + 2, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: BlocProvider(
          create: (context) => timeManagementBloc,
          child: Column(
            children: [
              MonthRangeButton(
                bloc: timeManagementBloc,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<TimeManagementBloc, TimeManagementState>(
                    builder: (context, state) {
                  if (state.status == FetchStatus.fetching) {
                    return ShimmerComponent(width: 200, height: 150);
                  } else if (state.status == FetchStatus.failed) {
                    return ErrorWarning(
                      errorMsg: state.error!.errMsgText ?? "",
                    );
                  } else if (state.status == FetchStatus.success) {
                    return TimeScheduleBody(
                        timeScheduleData: state.timeScheduleData,
                        bloc: timeManagementBloc,
                        checkHoliday: state.holidayCheck,
                        shiftName: state.shiftName,
                        // holidays: state.holidayData,
                        holidayData: state.holidayData,
                        holidayDataEn: state.holidayDataEn);
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
            ],
          ),
        ));
  }
}
