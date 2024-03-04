import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/core/provider/bottom_navbar/language_provider.dart';
import '../../../../../user/timeline/domain/entities/entities.dart';
import '../../../../../user/timeline/presentation/widgets/time_line_body/widgets.dart';
import '../../../domain/entities/entities.dart';

class DayDetailPage extends StatelessWidget {
  final int index;
  final EmployeesEntity empData;
  final TimeLineEntity data;
  final List<TimeLineEntity> attendanceData;
  final List<String> reasons;
  const DayDetailPage(
      {super.key,
      required this.attendanceData,
      required this.data,
      required this.index,
      required this.empData,
      required this.reasons});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
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
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .devicePixelRatio * 10),
                  child: showDetail(data, context, '${localizationProvider.locale}'),
                )),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: const Color(0xffE793B8),
            //   onPressed: () {
            //     // Navigator.push(
            //     //     context,
            //     //     MaterialPageRoute(
            //     //         builder: (context) => RequestTimeForm(
            //     //           index:index,
            //     //           data: data,
            //     //           attendanceData: attendanceData,
            //     //           reasons: reasons,
            //     //           empData: empData,)));
            //   },
            //   child: const Icon(
            //     Icons.add,
            //     size: 40,
            //     color: Colors.white,
            //   ),
            // ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        }
    );
  }
}
