import 'package:day/day.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../../injection_container.dart';
import '../../domain/entities/entities.dart';
import '../bloc/timeline_bloc.dart';
import '../widgets/appbar.dart';
import '../widgets/ot_hours_show.dart';
import '../widgets/request_time_form/header_detail.dart';
import 'confirm_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestTimeForm extends StatefulWidget {
  final int index;
  final TimeLineEntity data;
  final List<TimeLineEntity> attendanceData;
  final List<String> reasons;
  final PayrollSetting payrollData;

  final List<ReasonEntity> reasonAllData;

  const RequestTimeForm({
    super.key,
    required this.index,
    required this.data,
    required this.attendanceData,
    required this.reasons,
    required this.reasonAllData,
    required this.payrollData,
  });

  @override
  State<RequestTimeForm> createState() => _RequestTimeFormState();
}

class _RequestTimeFormState extends State<RequestTimeForm> {
  final TimelineBloc timelineBloc = sl<TimelineBloc>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<String> hours =
      List.generate(24, (index) => index.toString().padLeft(2, '0'));

  List<String> minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  // * input for make time request.
  String? requestType;
  String? reasonType;
  List<String?> startTime = [null, null];
  List<String?> endTime = [null, null];
  DateTime? startDate;
  DateTime? endDate;
  String note = "";
  bool? isOT;
  bool isFirstCheck = false;
  CalculateTimeEntity? calculateTimeValue;
  OutlineInputBorder borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffC4C4C4)),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: widget.data.date!,
      firstDate: widget.data.date!,
      lastDate: widget.attendanceData[widget.index + 2].date!,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
              accentColor: Colors.purple,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() {
        if (isStartDate) {
          startDate = date;
          startDateController.text = DateFormat('dd/MM/yyyy').format(date);
        } else {
          endDate = date;
          endDateController.text = DateFormat('dd/MM/yyyy').format(date);
        }
        if ((startDate != null &&
                endDate != null &&
                endTime[0] != null &&
                endTime[1] != null &&
                startTime[0] != null &&
                startTime[1] != null) &&
            requestType == AppLocalizations.of(context)!.overtimerequest) {
          DateTime startRequestDate = DateTime(
              startDate!.year,
              startDate!.month,
              startDate!.day,
              int.parse(startTime[0]!),
              int.parse(startTime[1]!));
          DateTime endRequestDate = DateTime(endDate!.year, endDate!.month,
              endDate!.day, int.parse(endTime[0]!), int.parse(endTime[1]!));
          calculateTimeValue = calculateOT(startRequestDate, endRequestDate,
              widget.attendanceData, 2, startDate!);
        }
      });
    }
  }

  bool checkOverlapWorkingTime(List<TimeLineEntity> data, DateTime startDate,
      DateTime endDate, List<String?> timeStart, List<String?> timeEnd) {
    Day startTimeDate = Day.fromDateTime(DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      int.parse(timeStart[0]!),
      int.parse(timeStart[1]!),
    ));
    Day endTimeDate = Day.fromDateTime(DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      int.parse(timeEnd[0]!),
      int.parse(timeEnd[1]!),
    ));
    int indexStart = data.indexWhere((element) => element.date == startDate);
    int indexEnd = data.indexWhere((element) => element.date == endDate);

    Day preStart = Day.fromDateTime(DateTime(
      data[indexStart - 1].date!.year,
      data[indexStart - 1].date!.month,
      data[indexStart - 1].date!.day,
      int.parse(data[indexStart - 1].pattern!.timeIn!.substring(0, 2)),
      int.parse(data[indexStart - 1].pattern!.timeIn!.substring(3, 5)),
    ));
    Day preEnd =
        preStart.add(data[indexStart - 1].pattern!.workingHours!, "minute")!;

    int curIsWorking = (data[indexStart].pattern!.isWorkingDay == 1 &&
            data[indexStart].holiday == null &&
            !data[indexStart].isCompensation!)
        ? 1
        : 0;
    Day curStart = Day.fromDateTime(DateTime(
      data[indexStart].date!.year,
      data[indexStart].date!.month,
      data[indexStart].date!.day,
      int.parse(data[indexStart].pattern!.timeIn!.substring(0, 2)),
      int.parse(data[indexStart].pattern!.timeIn!.substring(3, 5)),
    ));
    Day curEnd =
        curStart.add(data[indexStart].pattern!.workingHours!, "minute")!;

    int nextIsWorking =
        (data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd]
                        .pattern!
                        .isWorkingDay ==
                    1 &&
                data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd]
                        .holiday ==
                    null &&
                !data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd]
                    .isCompensation!)
            ? 1
            : 0;
    Day nextStart = Day.fromDateTime(DateTime(
      data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd].date!.year,
      data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd].date!.month,
      data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd].date!.day,
      int.parse(data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd]
          .pattern!
          .timeIn!
          .substring(0, 2)),
      int.parse(data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd]
          .pattern!
          .timeIn!
          .substring(3, 5)),
    ));
    Day nextEnd = nextStart.add(
        data[endDate.day == startDate.day ? indexEnd + 1 : indexEnd]
            .pattern!
            .workingHours!,
        "minute")!;

    if (startDate == endDate) {
      if (curIsWorking == 1) {
        if (((startTimeDate.isAfter(curStart) &&
                    startTimeDate.isBefore(curEnd)) ||
                startTimeDate == curStart) ||
            ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) ||
                endTimeDate == curEnd ||
                endTimeDate.isAfter(nextStart))) {
          return true;
        }
        return false;
      }
      return false;
    } else if (startDate.isBefore(endDate)) {
      if (curIsWorking == 0 && nextIsWorking == 0) {
        return false;
      } else if (curIsWorking == 0 && nextIsWorking == 1) {
        if (endTimeDate.isAfter(nextStart)) {
          return true;
        }
        return false;
      } else if (curIsWorking == 1 && nextIsWorking == 0) {
        if (((startTimeDate.isAfter(curStart) &&
                    startTimeDate.isBefore(curEnd)) ||
                startTimeDate == curStart) ||
            ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) ||
                endTimeDate == curEnd)) {
          return true;
        }
        return false;
      } else {
        if (((startTimeDate.isAfter(curStart) &&
                    startTimeDate.isBefore(curEnd)) ||
                startTimeDate == curStart) ||
            ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) ||
                endTimeDate == curEnd)) {
          return true;
        } else if ((((startTimeDate.isAfter(nextStart) &&
                    startTimeDate.isBefore(nextEnd)) ||
                startTimeDate == nextStart ||
                startTimeDate.isBefore(preEnd)) ||
            ((endTimeDate.isBefore(curEnd) && endTimeDate.isAfter(curStart)) ||
                endTimeDate == nextEnd))) {
          return true;
        }
      }
      return false;
    }
    return true;
  }

  List<DropdownMenuItem<String>> reasons(List<ReasonEntity> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    List<ReasonEntity> requestTime = [];
    List<ReasonEntity> requestOt = [];
    if (items.isNotEmpty) {
      if (items.last.idRequestType == null) {
        items.sort((a, b) => a.isPayShift!.compareTo(b.isPayShift!));
        for (var i in items) {
          menuItems.addAll(
            [
              DropdownMenuItem<String>(
                value: i.idRequestReason!.toString(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    AppLocalizations.of(context)!.hello == "Hello"
                        ? i.name_EN == null
                            ? i.name!
                            : i.name_EN!
                        : i.name!,
                    style: const TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        menuItems.insert(
          0,
          DropdownMenuItem<String>(
            alignment: AlignmentDirectional.center,
            enabled: false,
            child: Text(AppLocalizations.of(context)!.noShiftValue,
                style: TextStyle(
                    fontFamily: 'kanit', color: Colors.grey, fontSize: 16)),
          ),
        );
        menuItems.insert(
          items.lastIndexWhere((element) => element.isPayShift == 0) + 2,
          DropdownMenuItem<String>(
            alignment: AlignmentDirectional.center,
            enabled: false,
            child: Text(
              AppLocalizations.of(context)!.shiftValueExists,
              style: TextStyle(
                  fontFamily: 'kanit', color: Colors.grey, fontSize: 16),
            ),
          ),
        );
      } else {
        for (var i in items) {
          if (i.idRequestType == 1) {
            requestTime.add(i);
          } else {
            requestOt.add(i);
          }
        }
        if (requestType == AppLocalizations.of(context)!.workingtimerequest) {
          for (var i in requestTime) {
            menuItems.addAll(
              [
                if (i.idRequestType == 1) ...[
                  DropdownMenuItem<String>(
                    value: i.idRequestReason!.toString(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        AppLocalizations.of(context)!.hello == "Hello"
                            ? i.name_EN == null
                                ? i.name!
                                : i.name_EN!
                            : i.name!,
                        style: const TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            );
          }
        } else {
          for (var i in requestOt) {
            menuItems.addAll(
              [
                if (i.idRequestType == 2) ...[
                  DropdownMenuItem<String>(
                    value: i.idRequestReason!.toString(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        AppLocalizations.of(context)!.hello == "Hello"
                            ? i.name_EN == null
                                ? i.name!
                                : i.name_EN!
                            : i.name!,
                        style: const TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            );
          }
          menuItems.insert(
            0,
            DropdownMenuItem<String>(
              alignment: AlignmentDirectional.center,
              enabled: false,
              child: Text(AppLocalizations.of(context)!.noShiftValue,
                  style: TextStyle(
                      fontFamily: 'kanit', color: Colors.grey, fontSize: 16)),
            ),
          );
          menuItems.insert(
            requestOt.lastIndexWhere((element) => element.isPayShift == 0),
            DropdownMenuItem<String>(
              alignment: AlignmentDirectional.center,
              enabled: false,
              child: Text(
                AppLocalizations.of(context)!.shiftValueExists,
                style: TextStyle(
                    fontFamily: 'kanit', color: Colors.grey, fontSize: 16),
              ),
            ),
          );
        }
      }
    }

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> requestTypes = [
      AppLocalizations.of(context)!.workingtimerequest,
      AppLocalizations.of(context)!.overtimerequest,
      AppLocalizations.of(context)!.compensaterequest,
    ];
    isFirstCheck = widget.data.attendance!.checkOut!.length >= 1 &&
        widget.data.attendance!.checkOut?[0] != null &&
        widget.data.attendance!.checkIn!.length >= 1 &&
        widget.data.attendance!.checkIn?[0] != null;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  HeaderDetail(
                    workDate: widget.data.date!,
                    workTime:
                        "${AppLocalizations.of(context)!.timeAttendance}: ${widget.data.pattern!.workingTypeName!} "
                        "(${widget.data.pattern!.timeIn!.substring(0, 5)} "
                        "- ${widget.data.pattern!.timeOut!.substring(0, 5)})",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.type,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                enabledBorder: borderStyle,
                                focusedBorder: borderStyle,
                                errorStyle: TextStyle(
                                    fontFamily: 'kanit', fontSize: 15),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .selecttypeofrequest;
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              hint: Text(
                                AppLocalizations.of(context)!
                                    .selecttypeofrequest,
                                style: TextStyle(
                                    fontFamily: 'kanit',
                                    fontSize: 18,
                                    color: Colors.grey),
                              ),
                              isExpanded: true,
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              items: requestTypes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontFamily: 'kanit', fontSize: 18),
                                    ));
                              }).toList(),
                              onChanged: (String? value) {
                                DateTime start;
                                DateTime end;
                                requestType = value!;
                                reasonType = null;
                                setState(() {
                                  if (value ==
                                          AppLocalizations.of(context)!
                                              .overtimerequest ||
                                      value ==
                                          AppLocalizations.of(context)!
                                              .compensaterequest) {
                                    if (isFirstCheck &&
                                        widget.data.pattern!.isWorkingDay ==
                                            1) {
                                      start = widget.data.attendance!
                                          .checkIn![0]!.attendanceDateTime!;
                                      end = widget.data.attendance!
                                          .checkOut![0]!.attendanceDateTime!;
                                      startDateController.text =
                                          DateFormat("dd/MM/yyyy").format(widget
                                              .data
                                              .attendance!
                                              .checkIn![0]!
                                              .attendanceDateTime!);
                                      endDateController.text =
                                          DateFormat("dd/MM/yyyy").format(widget
                                              .data
                                              .attendance!
                                              .checkOut![0]!
                                              .attendanceDateTime!);
                                      startDate = DateTime(
                                          start.year, start.month, start.day);
                                      endDate = DateTime(
                                          end.year, end.month, end.day);
                                      startTime.insert(
                                          0,
                                          widget.data.pattern!.timeOut!
                                              .substring(0, 2));
                                      startTime.insert(
                                          1,
                                          widget.data.pattern!.timeOut!
                                              .substring(3, 5));
                                      endTime.insert(
                                          0,
                                          widget.data.attendance!.checkOut![0]!
                                              .attendanceTextTime!
                                              .substring(0, 2));
                                      endTime.insert(
                                          1,
                                          widget.data.attendance!.checkOut![0]!
                                              .attendanceTextTime!
                                              .substring(3));
                                    } else if (widget
                                                .data.pattern!.isWorkingDay ==
                                            0 ||
                                        widget.data.holiday != null) {
                                      start = widget.data.date!;
                                      startDateController.text =
                                          DateFormat("dd/MM/yyyy")
                                              .format(start);
                                      endDateController.text =
                                          DateFormat("dd/MM/yyyy")
                                              .format(start);
                                      startDate = DateTime(
                                          start.year, start.month, start.day);
                                      endDate = DateTime(
                                          start.year, start.month, start.day);
                                      startTime[0] = widget
                                          .data.pattern!.timeIn!
                                          .substring(0, 2);
                                      startTime[1] = widget
                                          .data.pattern!.timeIn!
                                          .substring(3, 5);
                                      endTime[0] = widget.data.pattern!.timeOut!
                                          .substring(0, 2);
                                      endTime[1] = widget.data.pattern!.timeOut!
                                          .substring(3, 5);
                                    } else {
                                      start = widget.data.date!;
                                      startDateController.text =
                                          DateFormat("dd/MM/yyyy")
                                              .format(start);
                                      endDateController.text =
                                          DateFormat("dd/MM/yyyy")
                                              .format(start);
                                      startDate = DateTime(
                                          start.year, start.month, start.day);
                                      endDate = DateTime(
                                          start.year, start.month, start.day);
                                      startTime[0] = widget
                                          .data.pattern!.timeOut!
                                          .substring(0, 2);
                                      startTime[1] = widget
                                          .data.pattern!.timeOut!
                                          .substring(3, 5);
                                    }
                                    if (startDate != null &&
                                        endDate != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null) {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                  } else {
                                    calculateTimeValue = null;
                                    startDateController.text = "";
                                    endDateController.text = "";
                                    startDate = null;
                                    startTime[0] = null;
                                    startTime[1] = null;
                                    endDate = null;
                                    endTime[0] = null;
                                    endTime[1] = null;
                                  }
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.startdate,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          // height: 35,
                          // width: 250,
                          child: TextFormField(
                            onTap: () => pickDate(context, true),
                            controller: startDateController,
                            readOnly: true,
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.selectdate;
                              } else if (endDate != null) {
                                if (endDate!.isBefore(startDate!)) {
                                  return AppLocalizations.of(context)!
                                      .invaliddateandtimeinput;
                                }
                              } else if (requestType ==
                                      AppLocalizations.of(context)!
                                          .overtimerequest &&
                                  startDate != null &&
                                  endDate != null) {
                                if (checkOverlapWorkingTime(
                                    widget.attendanceData,
                                    startDate!,
                                    endDate!,
                                    startTime,
                                    endTime)) {
                                  return AppLocalizations.of(context)!
                                      .unabletomaketransaction;
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: borderStyle,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: const Icon(Icons.calendar_month),
                                hintText: "DD/MM/YY",
                                hintStyle: TextStyle(fontSize: 18),
                                border: borderStyle,
                                errorStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.start_time,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField2(
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: InputDecoration(
                                    focusedBorder: borderStyle,
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    enabledBorder: borderStyle,
                                    border: borderStyle,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .selecthours;
                                    } else if (startDate != null &&
                                        endDate != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null) if (DateTime(
                                            endDate!.year,
                                            endDate!.month,
                                            endDate!.day,
                                            int.parse(endTime[0]!),
                                            int.parse(endTime[1]!))
                                        .isBefore(DateTime(
                                            startDate!.year,
                                            startDate!.month,
                                            startDate!.day,
                                            int.parse(startTime[0]!),
                                            int.parse(startTime[1]!)))) {
                                      return AppLocalizations.of(context)!
                                          .invaliddateandtimeinput;
                                    }
                                    // else if(requestType == "ขอทำงานล่วงเวลา"
                                    //     && startDate != null && endDate != null && startTime[0]!=null && startTime[1]!=null){
                                    //   if(checkOverlapWorkingTime(widget.attendanceData,startDate!,endDate!,startTime,endTime)){
                                    //     return "ไม่สามารถทำรายการในเวลาทำงานปกติได้";
                                    //   }
                                    // }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: Text(
                                    AppLocalizations.of(context)!.hour,
                                    style: TextStyle(
                                        fontFamily: 'kanit',
                                        fontSize: 18,
                                        color: Colors.grey),
                                  ),
                                  value: startTime[0],
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: hours.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontFamily: 'kanit',
                                              fontSize: 18),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    startTime[0] = value!;
                                    // startTime.insert(0, value!);
                                    if ((startDate != null &&
                                            endDate != null &&
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null) &&
                                        (requestType ==
                                                AppLocalizations.of(context)!
                                                    .overtimerequest ||
                                            requestType ==
                                                AppLocalizations.of(context)!
                                                    .compensaterequest)) {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState(() {});
                                  }),
                            ),
                            Text(
                              "  ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: DropdownButtonFormField2(
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: InputDecoration(
                                    enabledBorder: borderStyle,
                                    focusedBorder: borderStyle,
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    border: borderStyle,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .selectminutes;
                                    } else if (startDate != null &&
                                        endDate != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null) {
                                      if (DateTime(
                                              endDate!.year,
                                              endDate!.month,
                                              endDate!.day,
                                              int.parse(endTime[0]!),
                                              int.parse(endTime[1]!))
                                          .isBefore(DateTime(
                                              startDate!.year,
                                              startDate!.month,
                                              startDate!.day,
                                              int.parse(startTime[0]!),
                                              int.parse(startTime[1]!)))) {
                                        return AppLocalizations.of(context)!
                                            .invaliddateandtimeinput;
                                      }
                                    } else if ((requestType ==
                                                AppLocalizations.of(context)!
                                                    .overtimerequest ||
                                            requestType ==
                                                AppLocalizations.of(context)!
                                                    .compensaterequest) &&
                                        startDate != null &&
                                        endDate != null &&
                                        startTime[0] != null &&
                                        startTime[1] != null &&
                                        endTime[0] != null &&
                                        endTime[1] != null) {
                                      if (checkOverlapWorkingTime(
                                          widget.attendanceData,
                                          startDate!,
                                          endDate!,
                                          startTime,
                                          endTime)) {
                                        return AppLocalizations.of(context)!
                                            .unabletomaketransaction;
                                      }
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: Text(
                                    AppLocalizations.of(context)!.minute,
                                    style: TextStyle(
                                        fontFamily: 'kanit',
                                        fontSize: 18,
                                        color: Colors.grey),
                                  ),
                                  isExpanded: true,
                                  value: startTime[1],
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: minutes.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontFamily: 'kanit',
                                              fontSize: 18),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    startTime[1] = value!;
                                    // startTime.insert(1, value!);
                                    if ((startDate != null &&
                                            endDate != null &&
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null) &&
                                        requestType ==
                                            AppLocalizations.of(context)!
                                                .overtimerequest) {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState(() {});
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.enddate,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: TextFormField(
                            onTap: () => pickDate(context, false),
                            controller: endDateController,
                            readOnly: true,
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.selectdate;
                              } else if (startDate != null && endDate != null) {
                                if (endDate!.isBefore(startDate!)) {
                                  return AppLocalizations.of(context)!
                                      .invaliddateandtimeinput;
                                }
                              } else if (requestType ==
                                      AppLocalizations.of(context)!
                                          .overtimerequest &&
                                  startDate != null &&
                                  endDate != null &&
                                  startTime[0] != null &&
                                  startTime[1] != null) {
                                if (checkOverlapWorkingTime(
                                    widget.attendanceData,
                                    startDate!,
                                    endDate!,
                                    startTime,
                                    endTime)) {
                                  return AppLocalizations.of(context)!
                                      .unabletomaketransaction;
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: const Icon(Icons.calendar_month),
                                hintText: "DD/MM/YY",
                                hintStyle: TextStyle(fontSize: 18),
                                enabledBorder: borderStyle,
                                border: borderStyle,
                                errorStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.end_time,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField2(
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: InputDecoration(
                                    enabledBorder: borderStyle,
                                    focusedBorder: borderStyle,
                                    errorStyle: TextStyle(fontSize: 14),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    border: borderStyle,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .selecthours;
                                    } else if (startDate != null
                                        && endDate != null
                                        && startTime[0] != null
                                        && startTime[1] != null
                                        && endTime[0] != null
                                        && endTime[1] != null) {
                                      if (DateTime(
                                              endDate!.year,
                                              endDate!.month,
                                              endDate!.day,
                                              int.parse(endTime[0]!),
                                              int.parse(endTime[1]!))
                                          .isBefore(DateTime(
                                              startDate!.year,
                                              startDate!.month,
                                              startDate!.day,
                                              int.parse(startTime[0]!),
                                              int.parse(startTime[1]!)))) {
                                        return AppLocalizations.of(context)!
                                            .invaliddateandtimeinput;
                                      }
                                    } else if ((requestType ==
                                                AppLocalizations.of(context)!
                                                    .overtimerequest ||
                                            requestType ==
                                                AppLocalizations.of(context)!
                                                    .compensaterequest)
                                    && (startDate != null &&
                                            endDate != null &&
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null) &&
                                        checkOverlapWorkingTime(
                                            widget.attendanceData,
                                            startDate!,
                                            endDate!,
                                            startTime,
                                            endTime)) {
                                      return AppLocalizations.of(context)!
                                          .unabletomaketransaction;
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: Text(
                                    AppLocalizations.of(context)!.hour,
                                    style: TextStyle(
                                        fontFamily: 'kanit',
                                        fontSize: 18,
                                        color: Colors.grey),
                                  ),
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  value: endTime[0],
                                  items: hours.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontFamily: 'kanit',
                                              fontSize: 18),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    endTime[0] = value!;
                                    if ((startDate != null &&
                                            endDate != null &&
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null) &&
                                        (requestType ==
                                                AppLocalizations.of(context)!
                                                    .overtimerequest ||
                                            requestType ==
                                                AppLocalizations.of(context)!
                                                    .compensaterequest)) {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState(() {});
                                  }),
                            ),
                            Text(
                              "  ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              // height: 35,
                              // width: 120,
                              child: DropdownButtonFormField2(
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(Icons.access_time_outlined)),
                                  decoration: InputDecoration(
                                      focusedBorder: borderStyle,
                                      errorStyle: TextStyle(fontSize: 14),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5),
                                      border: borderStyle,
                                      enabledBorder: borderStyle),
                                  value: endTime[1],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .selectminutes;
                                    } else if (startDate != null &&
                                        endDate != null && (
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null)) {
                                      if (DateTime(
                                              endDate!.year,
                                              endDate!.month,
                                              endDate!.day,
                                              int.parse(endTime[0]!),
                                              int.parse(endTime[1]!))
                                          .isBefore(DateTime(
                                              startDate!.year,
                                              startDate!.month,
                                              startDate!.day,
                                              int.parse(startTime[0]!),
                                              int.parse(startTime[1]!)))) {
                                        return AppLocalizations.of(context)!
                                            .invaliddateandtimeinput;
                                      }
                                    } else if (requestType ==
                                            AppLocalizations.of(context)!
                                                .overtimerequest &&
                                        (startDate != null &&
                                            endDate != null &&
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null) &&
                                        checkOverlapWorkingTime(
                                            widget.attendanceData,
                                            startDate!,
                                            endDate!,
                                            startTime,
                                            endTime)) {
                                      return AppLocalizations.of(context)!
                                          .unabletomaketransaction;
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  hint: Text(
                                    AppLocalizations.of(context)!.minute,
                                    style: TextStyle(
                                        fontFamily: 'kanit',
                                        fontSize: 18,
                                        color: Colors.grey),
                                  ),
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  items: minutes.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontFamily: 'kanit',
                                              fontSize: 18),
                                        ));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    endTime[1] = value!;
                                    // endTime.insert(1, value!);
                                    if ((startDate != null &&
                                            endDate != null &&
                                            endTime[0] != null &&
                                            endTime[1] != null &&
                                            startTime[0] != null &&
                                            startTime[1] != null) &&
                                        (requestType ==
                                                AppLocalizations.of(context)!
                                                    .overtimerequest ||
                                            requestType ==
                                                AppLocalizations.of(context)!
                                                    .compensaterequest)) {
                                      DateTime startRequestDate = DateTime(
                                          startDate!.year,
                                          startDate!.month,
                                          startDate!.day,
                                          int.parse(startTime[0]!),
                                          int.parse(startTime[1]!));
                                      DateTime endRequestDate = DateTime(
                                          endDate!.year,
                                          endDate!.month,
                                          endDate!.day,
                                          int.parse(endTime[0]!),
                                          int.parse(endTime[1]!));
                                      calculateTimeValue = calculateOT(
                                          startRequestDate,
                                          endRequestDate,
                                          widget.attendanceData,
                                          2,
                                          startDate!);
                                    }
                                    setState(() {});
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.reason,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          // width: 250,
                          child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                  focusedBorder: borderStyle,
                                  errorStyle: TextStyle(fontSize: 14),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  border: borderStyle,
                                  enabledBorder: borderStyle),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .choosereason;
                                }
                                // else if(state.leaveHistoryData.any((element) =>
                                // DateFormat("dd-MM").format(element.start!) == DateFormat("dd-MM").format(startDate??DateTime.now()),)){
                                //   return "มีวันลาอยู่แล้ว";
                                // }
                                return null;
                              },
                              value: reasonType,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              hint: Text(
                                AppLocalizations.of(context)!.choosereason,
                                style: TextStyle(
                                    fontFamily: 'kanit',
                                    fontSize: 18,
                                    color: Colors.grey),
                              ),
                              isExpanded: true,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              items: reasons(widget.reasonAllData),
                              onChanged: (String? value) {
                                reasonType = value!;
                                setState(() {});
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.otherreason,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          // height: 35,
                          // width: 250,
                          child: TextFormField(
                            maxLines: 5,
                            onChanged: (String text) {
                              note = text;
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: AppLocalizations.of(context)!.note,
                                hintStyle: TextStyle(fontSize: 18),
                                border: borderStyle,
                                enabledBorder: borderStyle,
                                focusedBorder: borderStyle,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (calculateTimeValue != null &&
                      (requestType == AppLocalizations.of(context)!.overtimerequest
                          || requestType == AppLocalizations.of(context)!.compensaterequest) &&
                      calculateTimeValue!.isInTimeFrame) ...[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalhours,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          if (requestType ==
                              AppLocalizations.of(context)!
                                  .compensaterequest) ...[
                            OTHoursShow(
                              title: 'Compensate',
                              otValue:
                                  "${((calculateTimeValue!.compensateAmountHour ?? 0) / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                            ),
                          ] else ...[
                            if (calculateTimeValue!.xOT != 0)
                              OTHoursShow(
                                title: 'OT x ${widget.payrollData.xOt}',
                                otValue:
                                    "${(calculateTimeValue!.xOT / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                              ),
                            if (calculateTimeValue!.xWorkingMonthlyHoliday != 0)
                              OTHoursShow(
                                title:
                                    'OT x ${widget.payrollData.xWorkingMonthlyHoliday}',
                                otValue:
                                    "${(calculateTimeValue!.xWorkingMonthlyHoliday / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                              ),
                            if (calculateTimeValue!.xWorkingDailyHoliday != 0)
                              OTHoursShow(
                                title:
                                    'OT x ${widget.payrollData.xWorkingDailyHoliday}',
                                otValue:
                                    "${(calculateTimeValue!.xWorkingDailyHoliday / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                              ),
                            if (calculateTimeValue!.xOTHoliday != 0)
                              OTHoursShow(
                                title: 'OT x ${widget.payrollData.xOtHoliday}',
                                otValue:
                                    "${(calculateTimeValue!.xOTHoliday / 60).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hr}",
                              ),
                          ]
                        ],
                      ),
                    )
                  ],
                  if (calculateTimeValue != null &&
                      (requestType == AppLocalizations.of(context)!.overtimerequest
                          || requestType == AppLocalizations.of(context)!.compensaterequest)
                      && calculateTimeValue!.isInTimeFrame == false) ...[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            requestType ==
                                    AppLocalizations.of(context)!
                                        .overtimerequest
                                ? AppLocalizations.of(context)!
                                    .youcannotrequesttoworkovertimebeyondthetime
                                : AppLocalizations.of(context)!
                                    .unabletorequestcompensatoryhoursexceeding,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10,
                        bottom: MediaQuery.of(context).devicePixelRatio * 10),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: const Color(0xffE793B8)),
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              ((calculateTimeValue != null &&
                                      calculateTimeValue!.isInTimeFrame) ||
                                  requestType ==
                                      AppLocalizations.of(context)!
                                          .workingtimerequest)) {
                            DateTime startRequestDate = DateTime(
                                startDate!.year,
                                startDate!.month,
                                startDate!.day,
                                int.parse(startTime[0]!),
                                int.parse(startTime[1]!));
                            DateTime endRequestDate = DateTime(
                                endDate!.year,
                                endDate!.month,
                                endDate!.day,
                                int.parse(endTime[0]!),
                                int.parse(endTime[1]!));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: ConfirmPage(
                                      amountHour: (endRequestDate
                                              .difference(startRequestDate)
                                              .inMinutes)
                                          .toDouble(),
                                      data: widget.data,
                                      start: startRequestDate,
                                      end: endRequestDate,
                                      requestType: requestType!,
                                      reasonType: widget.reasonAllData
                                              .firstWhere((element) =>
                                                  element.idRequestReason ==
                                                  int.parse(reasonType!))
                                              .name ??
                                          "",
                                      note: note,
                                      result: calculateTimeValue,
                                      idRequestType: requestType ==
                                              AppLocalizations.of(context)!
                                                  .overtimerequest
                                          ? 2
                                          : (requestType ==
                                                  AppLocalizations.of(context)!
                                                      .compensaterequest
                                              ? 3
                                              : 1),
                                      reasonAllData: widget.reasonAllData,
                                      payrollData: widget.payrollData,
                                    )));
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.savedata,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  CalculateTimeEntity calculateOT(DateTime start, DateTime end,
      List<TimeLineEntity> attendanceData, int idPaymentType, DateTime now) {
    Day startTime = Day.fromDateTime(start);
    Day endTime = Day.fromDateTime(end);
    int index = attendanceData.indexWhere((element) => element.date == now);
    int isFinger = attendanceData[index].employee!.isFinger ?? 0;
    bool isInTimeFrame = false;

    int preIsWorking = (attendanceData[index].pattern!.isWorkingDay == 1 &&
            attendanceData[index].holiday == null &&
            !attendanceData[index].isCompensation!)
        ? 1
        : 0;
    Day preStart = Day.fromDateTime(DateTime(
      attendanceData[index - 1].date!.year,
      attendanceData[index - 1].date!.month,
      attendanceData[index - 1].date!.day,
      int.parse(attendanceData[index - 1].pattern!.timeIn!.substring(0, 2)),
      int.parse(attendanceData[index - 1].pattern!.timeIn!.substring(3, 5)),
    ));
    Day preEnd = preStart.add(
        attendanceData[index - 1].pattern!.workingHours!, "minute")!;
    int prePeriod = attendanceData[index - 1].pattern!.period!;

    int curIsWorking = (attendanceData[index].pattern!.isWorkingDay == 1 &&
            attendanceData[index].holiday == null &&
            !attendanceData[index].isCompensation!)
        ? 1
        : 0;
    Day curStart = Day.fromDateTime(DateTime(
      attendanceData[index].date!.year,
      attendanceData[index].date!.month,
      attendanceData[index].date!.day,
      int.parse(attendanceData[index].pattern!.timeIn!.substring(0, 2)),
      int.parse(attendanceData[index].pattern!.timeIn!.substring(3, 5)),
    ));
    Day curEnd =
        curStart.add(attendanceData[index].pattern!.workingHours!, "minute")!;
    int curPeriod = attendanceData[index].pattern!.period!;

    int nextIsWorking = (attendanceData[index + 1].pattern!.isWorkingDay == 1 &&
            attendanceData[index + 1].holiday == null &&
            !attendanceData[index + 1].isCompensation!)
        ? 1
        : 0;
    Day nextStart = Day.fromDateTime(DateTime(
      attendanceData[index + 1].date!.year,
      attendanceData[index + 1].date!.month,
      attendanceData[index + 1].date!.day,
      int.parse(attendanceData[index + 1].pattern!.timeIn!.substring(0, 2)),
      int.parse(attendanceData[index + 1].pattern!.timeIn!.substring(3, 5)),
    ));
    Day nextEnd = nextStart.add(
        attendanceData[index + 1].pattern!.workingHours!, "minute")!;
    int nextPeriod = attendanceData[index + 1].pattern!.period!;

    Day startBreakHourDate = Day.fromDateTime(DateTime(
      start.year,
      start.month,
      start.day,
      12,
      0,
    ));
    Day endBreakHourDate = Day.fromDateTime(DateTime(
      start.year,
      start.month,
      start.day,
      13,
      0,
    ));

    Day workStartDate = Day.fromDateTime(DateTime(
      attendanceData[index].date!.year,
      attendanceData[index].date!.month,
      attendanceData[index].date!.day,
      int.parse(attendanceData[index].pattern!.timeIn!.substring(0, 2)),
      int.parse(attendanceData[index].pattern!.timeIn!.substring(3, 5)),
    ));
    Day workEndDate = workStartDate.add(
        attendanceData[index].pattern!.workingHours!, "minute")!;

    double xOT = 0;
    double xOTHoliday = 0;
    double xWorkingDailyHoliday = 0;
    double xWorkingMonthlyHoliday = 0;
    double compensateAmountHour = 0;
    int overlapWorking = 0;

    List<RequestTimeCheck?> cal = [];
    if (isFinger == 1) {
      if (requestType == AppLocalizations.of(context)!.overtimerequest ||
          (requestType == AppLocalizations.of(context)!.compensaterequest &&
              curIsWorking == 1)) {
        Day startTemp = startTime;
        Day endTemp = endTime;
        for (var i = 0; i < 2; i++) {
          if (cal.isEmpty) {
            cal.add(RequestTimeCheck(
                checkIn: null, checkOut: null, type: 'IN/OUT'));
          }
          for (var j = 0;
              j <
                  (i == 0
                      ? widget.data.attendance!.checkIn!.length
                      : widget.data.attendance!.checkOut!.length);
              j++) {
            cal.add(null);
            if (cal[j] == null) {
              cal[j] = RequestTimeCheck(
                  checkIn: null, checkOut: null, type: 'IN/OUT');
            }
            if (i == 0 &&
                widget.data.attendance!.checkIn![j] != null &&
                widget.data.attendance!.checkIn![j]!.isCheckIn == 1) {
              cal[j]!.checkIn = Day.fromString(widget
                  .data.attendance!.checkIn![j]!.attendanceDateTime!
                  .toString()
                  .substring(0, 19));
            } else if (i != 0 &&
                widget.data.attendance!.checkOut![j] != null &&
                widget.data.attendance!.checkOut![j]!.isCheckIn == 0) {
              cal[j]!.checkOut = Day.fromString(widget
                  .data.attendance!.checkOut![j]!.attendanceDateTime!
                  .toString()
                  .substring(0, 19));
            }
          }
        }
        if (widget.data.requestTime!.isNotEmpty) {
          for (var i in widget.data.requestTime!) {
            if ((i.isDoubleApproval == 1 &&
                    i.isManagerLv1Approve != 0 &&
                    i.isManagerLv2Approve != 0) ||
                (i.isDoubleApproval == 0 &&
                    ((i.approvalLevel == 1 && i.isManagerLv1Approve != 0) ||
                        (i.approvalLevel == 2 &&
                            i.isManagerLv2Approve != 0)))) {
              cal.add(RequestTimeCheck(
                  checkIn: Day.fromDateTime(i.start!),
                  checkOut: Day.fromDateTime(i.end!),
                  type: "RequestTime"));
            }
          }
        }
        cal.removeWhere((element) =>
            element == null ||
            (element.checkIn == null && element.checkOut == null));
        cal.sort((a, b) {
          DateTime dateTimeA =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(a!.checkIn.toString());
          DateTime dateTimeB =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(b!.checkIn.toString());
          return dateTimeA.difference(dateTimeB).inMinutes;
        });
        cal.forEach((element) {
          if (element!.checkIn != null && element.checkOut != null) {
            String workTimeIn = element.checkIn!.toString().substring(0, 23);
            String workTimeOut = element.checkOut!.toString().substring(0, 23);
            Day checkInTime = Day.fromString(workTimeIn).second(0);
            Day checkOutTime = Day.fromString(workTimeOut).second(0);
            if (element.checkIn != null && element.checkOut != null) {
              if (((startTemp.isAfter(checkInTime) ||
                          startTemp == checkInTime) &&
                      (startTemp.isBefore(checkOutTime))) &&
                  ((endTemp.isAfter(checkInTime)) &&
                      (endTemp.isBefore(checkOutTime) ||
                          checkOutTime == endTemp))) {
                isInTimeFrame = true;
              } else if ((startTemp.isAfter(checkInTime) ||
                      startTemp == checkInTime) &&
                  startTemp.isBefore(checkOutTime)) {
                startTemp = element.checkOut!;
              } else if (endTemp.isAfter(checkInTime) &&
                  (endTemp.isBefore(checkOutTime) || checkOutTime == endTemp)) {
                endTemp = checkInTime;
              }
            }
          }
        });
      } else if (requestType ==
          AppLocalizations.of(context)!.compensaterequest) {
        isInTimeFrame = true;
      }
    } else {
      isInTimeFrame = true;
    }
    if (requestType == AppLocalizations.of(context)!.compensaterequest) {
      int ot_prebreak = (endTime.isBefore(startBreakHourDate)
              ? endTime
              : startBreakHourDate)
          .diff(startTime.isAfter(curStart) ? startTime : curStart, 'minute');

      if (ot_prebreak > 0) {
        compensateAmountHour += ot_prebreak;
      }
      int ot_afterbreak =
          (endTime.isBefore(workEndDate) ? endTime : workEndDate).diff(
              startTime.isAfter(endBreakHourDate)
                  ? startTime
                  : endBreakHourDate,
              'minute');
      if (ot_afterbreak > 0) {
        compensateAmountHour += ot_afterbreak;
      }
      if (ot_prebreak <= 0 && ot_afterbreak <= 0) {
        compensateAmountHour = endTime.diff(startTime, 'minute').toDouble();
      }
    } else {
      if (attendanceData[index].pattern!.idWorkingType == 1) {
        int ot_previous = (endTime.isBefore(preEnd) ? endTime : preEnd)
            .diff(startTime.isAfter(preStart) ? startTime : preStart, 'minute');
        if (ot_previous > 0) {
          if (preIsWorking == 1) {
            overlapWorking += ot_previous;
          } else if (preIsWorking == 0) {
            if (idPaymentType == 2) {
              xWorkingMonthlyHoliday += ot_previous;
            } else if (idPaymentType == 1) {
              xWorkingDailyHoliday += ot_previous;
            }
          }
        } else {
          ot_previous = 0;
        }

        int ot_pre_current = (endTime.isBefore(curStart) ? endTime : curStart)
            .diff(startTime.isAfter(preEnd) ? startTime : preEnd, 'minute');
        if (ot_pre_current > 0) {
          if (preIsWorking == 1) {
            xOT += ot_pre_current;
          } else if (preIsWorking == 0) {
            xOTHoliday += ot_pre_current;
          }
        } else {
          ot_pre_current = 0;
        }

        int ot_current = (endTime.isBefore(curEnd) ? endTime : curEnd)
            .diff(startTime.isAfter(curStart) ? startTime : curStart, 'minute');
        if (ot_current > 0) {
          if (curIsWorking == 1) {
            overlapWorking += ot_current;
            // xOT += ot_previous
          } else if (curIsWorking == 0) {
            if (idPaymentType == 2) {
              xWorkingMonthlyHoliday += ot_current;
            } else if (idPaymentType == 1) {
              xWorkingDailyHoliday += ot_current;
            }
          }
        } else {
          ot_current = 0;
        }
        int ot_pre_next = (endTime.isBefore(nextStart) ? endTime : nextStart)
            .diff(startTime.isAfter(curEnd) ? startTime : curEnd, 'minute');
        if (ot_pre_next > 0) {
          if (curIsWorking == 1 && curPeriod == 3 && nextIsWorking == 0) {
            xOTHoliday += ot_pre_next;
            // } else if (curIsWorking === 0 && curPeriod === 1 && nextIsWorking === 1 && nextPeriod === 3){
          } else if (curIsWorking == 0 && curPeriod == 1 && nextPeriod == 3) {
            // let over730 = dayjs(end).diff(`${nextStart.format("YYYY-MM-DD")} 07:30:00`, 'minute', true)
            Day curTimeInPlusOneDay = curStart.add(1, 'date')!;

            int overCurTimeInPlusOneDay =
                (endTime.isBefore(nextStart) ? endTime : nextStart)
                    .diff(curTimeInPlusOneDay, 'minute');

            if (overCurTimeInPlusOneDay > 0) {
              if (idPaymentType == 2) {
                xWorkingMonthlyHoliday += overCurTimeInPlusOneDay;
              } else if (idPaymentType == 1) {
                xWorkingDailyHoliday += overCurTimeInPlusOneDay;
              }
              xOTHoliday += (ot_pre_next - overCurTimeInPlusOneDay);
              // if(over730 > 0){
              // 	if(idPaymentType === 2){
              // 		xWorkingMonthlyHoliday += over730;
              // 	} else if(idPaymentType === 1){
              // 		xWorkingDailyHoliday += over730;
              // 	}
              // 	xOTHoliday += (ot_pre_next - over730)
            } else {
              xOTHoliday += ot_pre_next;
            }
          } else if (curIsWorking == 1) {
            xOT += ot_pre_next;
          } else if (curIsWorking == 0) {
            xOTHoliday += ot_pre_next;
          }
        } else {
          ot_pre_next = 0;
        }

        int ot_next = (endTime.isBefore(nextEnd) ? endTime : nextEnd).diff(
            startTime.isAfter(nextStart) ? startTime : nextStart, 'minute');
        if (ot_next > 0) {
          if (nextIsWorking == 1) {
            overlapWorking += ot_next;
            // xOT += ot_previous
          } else if (nextIsWorking == 0) {
            if (idPaymentType == 2) {
              xWorkingMonthlyHoliday += ot_next;
            } else if (idPaymentType == 1) {
              xWorkingDailyHoliday += ot_next;
            }
          }
        } else {
          ot_next = 0;
        }
      }
      if (attendanceData[index].pattern!.idWorkingType == 2) {
        int ot_pre_current = (endTime.isBefore(curStart) ? endTime : curStart)
            .diff(startTime, 'minute');
        if (ot_pre_current > 0) {
          if (curIsWorking == 1) {
            xOT += ot_pre_current;
          } else if (curIsWorking == 0) {
            xOTHoliday += ot_pre_current;
          }
        } else {
          ot_pre_current = 0;
        }

        int ot_prebreak = (endTime.isBefore(startBreakHourDate)
                ? endTime
                : startBreakHourDate)
            .diff(startTime.isAfter(curStart) ? startTime : curStart, 'minute');

        if (ot_prebreak > 0) {
          if (curIsWorking == 1) {
            overlapWorking += ot_prebreak;
          } else if (curIsWorking == 0) {
            if (idPaymentType == 2) {
              xWorkingMonthlyHoliday += ot_prebreak;
            } else if (idPaymentType == 1) {
              xWorkingDailyHoliday += ot_prebreak;
            }
          }
        }
        int ot_afterbreak =
            (endTime.isBefore(workEndDate) ? endTime : workEndDate).diff(
                startTime.isAfter(endBreakHourDate)
                    ? startTime
                    : endBreakHourDate,
                'minute');
        if (ot_afterbreak > 0) {
          if (curIsWorking == 1) {
            overlapWorking += ot_afterbreak;
          } else if (curIsWorking == 0) {
            if (idPaymentType == 2) {
              xWorkingMonthlyHoliday += ot_afterbreak;
            } else if (idPaymentType == 1) {
              xWorkingDailyHoliday += ot_afterbreak;
            }
          }
        }

        int ot_afterTimeOut = (endTime).diff(
            startTime.isAfter(workEndDate) ? startTime : workEndDate, 'minute');
        if (ot_afterTimeOut > 0) {
          if (curIsWorking == 1) {
            xOT += ot_afterTimeOut;
          } else if (curIsWorking == 0) {
            xOTHoliday += ot_afterTimeOut;
          }
        }
      }
    }

    CalculateTimeEntity result = CalculateTimeEntity(
      xOT: xOT,
      xOTHoliday: xOTHoliday,
      compensateAmountHour: compensateAmountHour,
      xWorkingDailyHoliday: xWorkingDailyHoliday,
      xWorkingMonthlyHoliday: xWorkingMonthlyHoliday,
      overlapWorking: overlapWorking,
      isInTimeFrame: isInTimeFrame,
    );

    return result;
  }
}

class RequestTimeCheck {
  Day? checkIn;
  Day? checkOut;
  String type;

  RequestTimeCheck({
    required this.checkIn,
    required this.checkOut,
    required this.type,
  });
}
