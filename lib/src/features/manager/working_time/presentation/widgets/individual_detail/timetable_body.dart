import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../user/timeline/domain/entities/entities.dart';
import '../../../../../user/timeline/presentation/widgets/time_line_body/widgets.dart';
import '../../../domain/entities/entities.dart';
import 'day_detail_page.dart';

class TimeTableBody extends StatelessWidget {
  final List<TimeLineEntity> attendanceData;
  final int? idEmp;
  final List<EmployeesEntity> empData;
  final List<String> reasons;
  final List<TimeLineEntity> showingData;
  const TimeTableBody(
      {super.key,
      required this.attendanceData,
      required this.empData,
      required this.showingData,
      required this.reasons,
      required this.idEmp});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: showingData.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CardList(
              data: showingData[index],
              attendanceData: attendanceData,
              index: index,
              reasons: reasons,
              eachEmpData:
                  empData.firstWhere((element) => element.idEmployees == idEmp),
            ),
            if (DateFormat('EE').format(showingData[index].date!) == "อา.")
              const Divider(
                thickness: 10,
                color: Color(0xffEAEDF2),
                height: 35,
              ),
            if (DateFormat('EE').format(showingData[index].date!) == "Sun ")
              const Divider(
                thickness: 10,
                color: Color(0xffEAEDF2),
                height: 35,
              )
          ],
        );
      },
    );
  }
}

class CardList extends StatelessWidget {
  final int index;
  final EmployeesEntity eachEmpData;
  final TimeLineEntity data;
  final List<TimeLineEntity> attendanceData;
  final List<String> reasons;
  const CardList(
      {super.key,
      required this.data,
      required this.attendanceData,
      required this.index,
      required this.eachEmpData,
      required this.reasons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DayDetailPage(
                        index: index,
                        attendanceData: attendanceData,
                        data: data,
                        reasons: reasons,
                        empData: eachEmpData,
                      )));
        },
        child: Container(
          height: data.attendanceDisplay!.isNotEmpty &&
                  data.attendanceDisplay!.length > 1
              ? 230
              : 160,
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
                      style: GoogleFonts.kanit(
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
                              style: GoogleFonts.kanit(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                          ),
                          if (data.pattern!.isWorkingDay == 0) ...[
                            Expanded(
                              flex: 50,
                              child: Center(
                                  child: Text("${data.pattern!.shiftTypeName}",
                                      style: GoogleFonts.kanit(
                                        fontSize: 16,
                                      ))),
                            ),
                          ] else ...[
                            Expanded(
                              flex: 50,
                              child: data.pattern!.timeIn == null
                                  ? Text(
                                      "ไม่มีเวลาทำงาน",
                                      style: GoogleFonts.kanit(
                                        fontSize: 16,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                          "${data.pattern!.timeIn!.substring(0, 5)} - ${data.pattern!.timeOut!.substring(0, 5)}",
                                          style: GoogleFonts.kanit(
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
                    if (data.attendanceDisplay!.isNotEmpty &&
                        data.attendanceDisplay!.length > 1) ...[
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
                            flex: 25,
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
