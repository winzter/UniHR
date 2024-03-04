import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/time_management/domain/entities/enitities.dart';
import '../bloc/time_management_bloc.dart';
import '../widgets/day-color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DayDetailPage extends StatelessWidget {
  final TimeScheduleEntity data;
  final List<TimeScheduleEntity> timeScheduleData;
  final Map<int, List<dynamic>> shiftName;
  final TimeManagementBloc bloc;
  // final List<HolidayEntity> holidayData;
  final Map<int, String> holidayData;
  const DayDetailPage({
    super.key,
    required this.timeScheduleData,
    required this.data,
    required this.shiftName,
    required this.bloc,
    required this.holidayData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(1)
                ])),
          ),
          backgroundColor: dayColors(data),
          leading: IconButton(
            color: const Color(0xff757575),
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: showDate(data),
          bottom: tabData(data, context)),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              data.requestChange!.length > 0
                  ? AppLocalizations.of(context)!.listofshiftsrequests
                  : "",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            data.requestChange!.length > 0
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.requestChange!.length,
                      itemBuilder: (context, index) {
                        return showDetail(data, context, shiftName,
                            index: index, bloc: bloc, holidayData: holidayData);
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.thereisnoshitlist}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
