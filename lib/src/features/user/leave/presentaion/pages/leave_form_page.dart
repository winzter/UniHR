import 'dart:ffi';
import 'dart:io';
import 'package:day/day.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/leave/presentaion/bloc/leave_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../widgets/appbar.dart';
import 'confirm_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveFormPage extends StatefulWidget {
  final List<LeaveAvailableEntity> data;
  final DateTime startPeriodDate;
  final DateTime endPeriodDate;
  final List<LeaveHistoryEntity> historyData;
  final LeaveBloc bloc;
  final List<HolidayLeaveEntity> holidayLeave;
  final List<ManagerLeave> managerData;

  // final Map<String,List<double>> leaveUsedData;

  const LeaveFormPage({
    super.key,
    required this.data,
    required this.bloc,
    required this.historyData,
    required this.managerData,
    required this.holidayLeave,
    required this.startPeriodDate,
    required this.endPeriodDate,
  });

  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  final LeaveBloc leaveBloc = sl<LeaveBloc>();
  List<String> leaveList = [];
  List<DayCannotLeave> dayCannotLeave = [];
  DayCannotLeave? toDayLeaveAvailable = null;
  List<ManagerLeave> selectedManager = [];
  bool isInTimeFrame = false;
  List<String> hours =
      List.generate(24, (index) => index.toString().padLeft(2, '0'));
  List<String> minutes = ["00", "15", "30", "45"];
  LeaveAvailableEntity? leaveType;
  String? holiday;
  List<String> startTime = ["00", "00"];
  List<String> endTime = ["00", "00"];
  late DateTime startDate;
  late DateTime endDate;
  String? note;
  PlatformFile? filePic;
  String fileName = "No file selected";
  bool isUpload = false;
  String filePath = "";
  late File fileSend;
  FilePickerResult? result;
  bool isFirstHalf = true;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isFullDay = true;
  bool isHalfDay = false;
  int? minLeave;
  Map<String, bool> isLocked = {
    'fullday': true,
    'halfday': true,
    'time': true,
  };
  double used = 0;
  double leaveCalHour = 0;
  LeaveAvailableEntity? leaveCurrentType;

  OutlineInputBorder borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffC4C4C4)),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: widget.startPeriodDate,
      lastDate: widget.endPeriodDate,
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
      if (isFullDay) {
        if (isStartDate) {
          startDate = DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
          startDateController.text = DateFormat('dd/MM/yyyy')
              .format(DateTime(date.year, date.month, date.day));
        } else {
          endDate = DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
          endDateController.text = DateFormat('dd/MM/yyyy')
              .format(DateTime(date.year, date.month, date.day));
        }
        if (startDate.isAfter(endDate)) {
          endDate = startDate;
          endDateController.text = DateFormat('dd/MM/yyyy')
              .format(DateTime(endDate.year, endDate.month, endDate.day));
        }
        leaveBloc.add(GetDayCannotLeaveData(
            start: startDate,
            end: endDate,
            idEmp: userData.profileData.idEmployees!));
        setState(() {});
      }
      if (isHalfDay) {
        startDate = date;
        startDateController.text = DateFormat('dd/MM/yyyy').format(date);
        endDate = date;
        endDateController.text = DateFormat('dd/MM/yyyy').format(date);
        leaveBloc.add(GetDayCannotLeaveData(
            start: startDate,
            end: endDate,
            idEmp: userData.profileData.idEmployees!));
        setState(() {});
      } else {
        if (isStartDate) {
          startDate = date;
          startTime = ['00', '00'];
          endDate = date;
          endTime = ['00', '00'];
          startDateController.text = DateFormat('dd/MM/yyyy').format(date);
        } else {
          endDate = DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
          endDateController.text = DateFormat('dd/MM/yyyy').format(date);
        }
        if (startDate.isAfter(endDate)) {
          endDate = startDate;
          endDateController.text = DateFormat('dd/MM/yyyy')
              .format(DateTime(endDate.year, endDate.month, endDate.day));
        }
        leaveBloc.add(GetDayCannotLeaveData(
            start: startDate,
            end: startDate.isAfter(endDate) ? startDate : endDate,
            idEmp: userData.profileData.idEmployees!));
        setState(() {});
      }
    }
  }

  void showInSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '${AppLocalizations.of(context)!.duplicatedata}',
        style: TextStyle(fontSize: 17),
      ),
      backgroundColor: const Color(0xff6FC9E4),
      behavior: SnackBarBehavior.floating,
    ));
  }

  String? getAllManagerMail(List<ManagerLeave> selectedManager) {
    String managerMail = "";
    if (selectedManager.isNotEmpty) {
      for (var i in selectedManager) {
        if (selectedManager.last == i) {
          managerMail += i.email!;
        } else {
          managerMail += i.email! + ";";
        }
      }
      return managerMail;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    setState(() {
      DateTime now = DateTime.now();
      startDate = DateTime(widget.startPeriodDate.year, now.month, now.day);
      endDate = DateTime(widget.startPeriodDate.year, now.month, now.day);
      startDateController.text = DateFormat('dd/MM/yyyy').format(startDate);
      endDateController.text = DateFormat('dd/MM/yyyy').format(endDate);
      leaveList = widget.data
          .map((e) => e.name)
          .where((name) => name != null)
          .toList()
          .cast<String>();
      leaveBloc.add(GetDayCannotLeaveData(
          start: startDate,
          end: endDate,
          idEmp: userData.profileData.idEmployees!));
      // used = calculateUsedDay(isFullDay, startDate, endDate,dayCannotLeave);
    });
  }

  int daysInAdvance(LeaveAvailableEntity leaveType, DateTime selectedDate) {
    final selectedDayInDay = Day.fromDateTime(selectedDate);
    final currentDay = Day.fromDateTime(DateTime.now());
    if (leaveType.daysInAdvance != null) {
      return currentDay
          .add(leaveType.daysInAdvance!, 'date')!
          .diff(selectedDayInDay, 'd');
    }
    return 0;
  }

  bool isNotLessHalfHour() {
    if (!isFullDay && !isHalfDay) {
      return leaveCalHour >= 0.5;
    } else {
      return true;
    }
  }

  bool isBetween(
      DateTime date, DateTime left, DateTime right, String type, String range) {
    List<String> listOrderType = [
      'year',
      'month',
      'day',
      'hour',
      'minute',
      'second'
    ];

    int orderType = listOrderType.indexWhere((t) => t == type);

    List<String> listRange = range.split("");

    if (orderType >= 0 &&
        listRange.length == 2 &&
        ['[', '('].indexOf(listRange[0]) >= 0 &&
        [']', ')'].indexOf(listRange[1]) >= 0) {
      DateTime leftCal = DateTime(
          left.year,
          orderType > 0 ? left.month : 1,
          orderType > 1 ? left.day : 1,
          orderType > 2 ? left.hour : 0,
          orderType > 3 ? left.minute : 0,
          orderType > 4 ? left.second : 0);

      DateTime rightCal = DateTime(
          right.year,
          orderType > 0 ? right.month : 1,
          orderType > 1 ? right.day : 1,
          orderType > 2 ? right.hour : 0,
          orderType > 3 ? right.minute : 0,
          orderType > 4 ? right.second : 0);

      DateTime dateCal = DateTime(
          date.year,
          orderType > 0 ? date.month : 1,
          orderType > 1 ? date.day : 1,
          orderType > 2 ? date.hour : 0,
          orderType > 3 ? date.minute : 0,
          orderType > 4 ? date.second : 0);
      bool result = false;

      if (listRange[0] == "[" &&
          (DateFormat("dd-MM-yyyy HH:mm").format(dateCal) ==
              DateFormat("dd-MM-yyyy HH:mm").format(leftCal))) {
        result = true;
      }
      if (listRange[1] == "]" &&
          (DateFormat("dd-MM-yyyy HH:mm").format(dateCal) ==
              DateFormat("dd-MM-yyyy HH:mm").format(rightCal))) {
        result = true;
      }
      if (dateCal.isAfter(leftCal) && dateCal.isBefore(rightCal)) {
        result = true;
      }
      return result;
    } else {
      return false;
    }
  }

  Widget show({
    required PlatformFile file,
  }) {
    return buildFile(file);
  }

  void lockCheck() {
    setState(() {
      if (minLeave == null) {
        isLocked['full'] = false;
        isLocked['halfday'] = false;
        isLocked['time'] = false;
      } else if (minLeave == 100) {
        isLocked['full'] = false;
        isLocked['halfday'] = true;
        isLocked['time'] = true;
        isFullDay = true;
        isHalfDay = false;
      } else if (minLeave == 50) {
        isLocked['full'] = false;
        isLocked['halfday'] = false;
        isLocked['time'] = true;
      } else if (minLeave == 10) {
        isLocked['full'] = false;
        isLocked['halfday'] = false;
        isLocked['time'] = false;
      } else if (minLeave == 5) {
        isLocked['full'] = false;
        isLocked['halfday'] = false;
        isLocked['time'] = false;
      } else if (minLeave == 5 && leaveType != "ลาชั่วโมง Compensate") {
        isLocked['full'] = false;
        isLocked['halfday'] = false;
        isLocked['time'] = false;
      } else if (leaveType == "ลาชั่วโมง Compensate") {
        isLocked['full'] = true;
        isLocked['halfday'] = true;
        isLocked['time'] = false;
        isFullDay = false;
        isHalfDay = false;
      }
    });
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Container(
      child: InkWell(
          onTap: () => null,
          child: Column(
            children: [
              (file.extension == 'jpg' || file.extension == 'png')
                  ? Image.file(
                      File(file.path.toString()),
                      width: 80,
                      height: 80,
                    )
                  : Container(
                      width: 80,
                      height: 80,
                    ),
              Text('$size')
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => leaveBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 7),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.type}",
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
                                enabledBorder: borderStyle,
                                errorStyle: TextStyle(fontSize: 14),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: borderStyle,
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return "${AppLocalizations.of(context)!.selectleavetype}";
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              hint: Text(
                                "${AppLocalizations.of(context)!.selectleavetype}",
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
                              items: widget.data
                                  .map<DropdownMenuItem<LeaveAvailableEntity>>(
                                      (LeaveAvailableEntity value) {
                                return DropdownMenuItem<LeaveAvailableEntity>(
                                    value: value,
                                    child: Text(
                                      AppLocalizations.of(context)!.hello ==
                                              "Hello"
                                          ? value.name_EN ?? value.name!
                                          : value.name!,
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'kanit'),
                                    ));
                              }).toList(),
                              onChanged: (LeaveAvailableEntity? value) {
                                setState(() {
                                  leaveType = value!;
                                  minLeave = value.minLeave;
                                  holiday = null;
                                  lockCheck();
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        leaveType != null && leaveType!.isLeaveHoliday == 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.dayoff}",
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
                                    return "${AppLocalizations.of(context)!.chooseaholiday}";
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                hint: Text(
                                  "${AppLocalizations.of(context)!.chooseaholiday}",
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
                                items: widget.holidayLeave
                                    .map<DropdownMenuItem<String>>(
                                        (HolidayLeaveEntity value) {
                                  return DropdownMenuItem<String>(
                                      value: value.name,
                                      child: Text(
                                        value.name!,
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'kanit'),
                                      ));
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    holiday = value;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: !isFullDay
                                        ? const Color(0xffE793B8)
                                        : Colors
                                            .white, // Border color// Border width
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(isFullDay
                                        ? const Color(0xffE793B8)
                                        : Colors.white)),
                            onPressed: () {
                              if (minLeave != 5 ||
                                  (minLeave == 5 &&
                                      leaveType != null &&
                                      leaveType!.isLeaveCompensate == 1)) {
                                isFullDay = true;
                                isHalfDay = false;
                                isFirstHalf = true;
                                startTime = ["00", "00"];
                                endTime = ["00", "00"];
                                used = calculateUsedDay(isFullDay, startDate,
                                    endDate, dayCannotLeave);
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                "${AppLocalizations.of(context)!.fullday}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: (minLeave == 100 ||
                                                minLeave == 50 ||
                                                minLeave == 10 ||
                                                minLeave == null ||
                                                minLeave == 5) &&
                                            isFullDay
                                        ? Colors.white
                                        : const Color(0xffE793B8)),
                              ),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: (isLocked['halfday'] == false) &&
                                            isHalfDay == true
                                        ? Colors.white
                                        : const Color(
                                            0xffE793B8), // Border color// Border width
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        (isLocked['halfday'] == false) &&
                                                isHalfDay
                                            ? const Color(0xffE793B8)
                                            : Colors.white)),
                            onPressed: () {
                              if ((isLocked['halfday'] == false)) {
                                setState(() {
                                  isFullDay = false;
                                  isHalfDay = true;
                                  used = calculateUsedDay(isFullDay, startDate,
                                      endDate, dayCannotLeave);
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                "${AppLocalizations.of(context)!.half_day}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: (isLocked['halfday'] == false) &&
                                            isHalfDay == true
                                        ? Colors.white
                                        : const Color(0xffE793B8)),
                              ),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as needed
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    color: !isFullDay &&
                                            !isHalfDay &&
                                            isLocked['time'] == false
                                        ? Colors.white
                                        : const Color(
                                            0xffE793B8), // Border color// Border width
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        !isFullDay &&
                                                !isHalfDay &&
                                                isLocked['time'] == false
                                            ? const Color(0xffE793B8)
                                            : Colors.white)),
                            onPressed: () {
                              if (isLocked['time'] == false) {
                                isFullDay = false;
                                isHalfDay = false;
                                isFirstHalf = true;
                                endDate = startDate;
                                endDateController.text =
                                    startDateController.text;
                                DateTime startReqDate = DateTime(
                                    startDate.year,
                                    startDate.month,
                                    startDate.day,
                                    int.parse(startTime[0]),
                                    int.parse(startTime[1]));
                                DateTime endReqDate = DateTime(
                                    endDate.year,
                                    endDate.month,
                                    endDate.day,
                                    int.parse(endTime[0]),
                                    int.parse(endTime[1]));
                                used = calculateUsedDay(isFullDay, startReqDate,
                                    endReqDate, dayCannotLeave);
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                "${AppLocalizations.of(context)!.enterTime}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: !isFullDay &&
                                            !isHalfDay &&
                                            isLocked['time'] == false
                                        ? Colors.white
                                        : const Color(0xffE793B8)),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isHalfDay,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust the radius as needed
                                    ),
                                  ),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                      color: !isFirstHalf
                                          ? const Color(0xff6FC9E4)
                                          : Colors
                                              .white, // Border color// Border width
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          isFirstHalf
                                              ? const Color(0xff6FC9E4)
                                              : Colors.white)),
                              onPressed: () {
                                setState(() {
                                  isFirstHalf = true;
                                  used = calculateUsedDay(isFullDay, startDate,
                                      endDate, dayCannotLeave);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${AppLocalizations.of(context)!.first_half}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: isFirstHalf
                                          ? Colors.white
                                          : const Color(0xff6FC9E4)),
                                ),
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust the radius as needed
                                    ),
                                  ),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                      color: isFirstHalf
                                          ? const Color(0xffE6FC9E4)
                                          : Colors
                                              .white, // Border color// Border width
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          !isFirstHalf
                                              ? const Color(0xff6FC9E4)
                                              : Colors.white)),
                              onPressed: () {
                                setState(() {
                                  isFirstHalf = false;
                                  used = calculateUsedDay(isFullDay, startDate,
                                      endDate, dayCannotLeave);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${AppLocalizations.of(context)!.second_half}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: !isFirstHalf
                                          ? Colors.white
                                          : const Color(0xff6FC9E4)),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isFullDay
                              ? "${AppLocalizations.of(context)!.startdate}"
                              : "${AppLocalizations.of(context)!.leavedate}",
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "${AppLocalizations.of(context)!.selectdate}";
                              } else if (startDate.isAfter(endDate)) {
                                return "${AppLocalizations.of(context)!.incorrectdateortime}";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: borderStyle,
                              focusedBorder: borderStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              suffixIcon: const Icon(Icons.calendar_month),
                              hintText:
                                  "${AppLocalizations.of(context)!.mm_dd_yy}",
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              border: borderStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isFullDay && !isHalfDay,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.start_time}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                        focusedBorder: borderStyle,
                                        errorStyle: TextStyle(fontSize: 14),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5),
                                        border: borderStyle,
                                        enabledBorder: borderStyle),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "${AppLocalizations.of(context)!.selecthours}";
                                      } else if (startDate.isAfter(endDate)) {
                                        return "${AppLocalizations.of(context)!.incorrectdateortime}";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    hint: Text(
                                      "${AppLocalizations.of(context)!.hour}",
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
                                    value: startTime[0],
                                    items: hours.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'kanit',
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        startTime[0] = value!;
                                        used = calculateUsedDay(
                                            isFullDay,
                                            DateTime(
                                                startDate.year,
                                                startDate.month,
                                                startDate.day,
                                                int.parse(startTime[0]),
                                                int.parse(startTime[1])),
                                            DateTime(
                                                endDate.year,
                                                endDate.month,
                                                endDate.day,
                                                int.parse(endTime[0]),
                                                int.parse(endTime[1])),
                                            dayCannotLeave);
                                      });
                                    }),
                              ),
                              Text(
                                " : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                // width: 120,
                                child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      focusedBorder: borderStyle,
                                      errorStyle: TextStyle(fontSize: 14),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5),
                                      border: borderStyle,
                                      enabledBorder: borderStyle,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "${AppLocalizations.of(context)!.selectminutes}";
                                      } else if (startDate.isAfter(endDate)) {
                                        return "${AppLocalizations.of(context)!.incorrectdateortime}";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    hint: Text(
                                      "${AppLocalizations.of(context)!.minute}",
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    value: startTime[1],
                                    items: minutes
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'kanit',
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        startTime[1] = value!;
                                        used = calculateUsedDay(
                                            isFullDay,
                                            DateTime(
                                                startDate.year,
                                                startDate.month,
                                                startDate.day,
                                                int.parse(startTime[0]),
                                                int.parse(startTime[1])),
                                            DateTime(
                                                endDate.year,
                                                endDate.month,
                                                endDate.day,
                                                int.parse(endTime[0]),
                                                int.parse(endTime[1])),
                                            dayCannotLeave);
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isFullDay
                        ? true
                        : !isHalfDay &&
                            (toDayLeaveAvailable != null &&
                                Day.fromString(
                                            "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeIn!}")
                                        .compareTo(Day.fromString(
                                            "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeOut!}")) ==
                                    1),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.enddate}",
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${AppLocalizations.of(context)!.selectdate}";
                                } else if (startDate.isAfter(endDate)) {
                                  return "${AppLocalizations.of(context)!.incorrectdateortime}";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                suffixIcon: const Icon(Icons.calendar_month),
                                enabledBorder: borderStyle,
                                focusedBorder: borderStyle,
                                hintText:
                                    "${AppLocalizations.of(context)!.mm_dd_yy}",
                                hintStyle:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                                border: borderStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isFullDay == false && isHalfDay == false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).devicePixelRatio * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.end_time}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                        focusedBorder: borderStyle,
                                        errorStyle: TextStyle(fontSize: 14),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5),
                                        border: borderStyle,
                                        enabledBorder: borderStyle),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "${AppLocalizations.of(context)!.selecthours}";
                                      } else if (startDate.isAfter(endDate)) {
                                        return "${AppLocalizations.of(context)!.incorrectdateortime}";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    hint: Text(
                                      "${AppLocalizations.of(context)!.hour}",
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
                                        borderRadius: BorderRadius.circular(5),
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
                                              fontSize: 18,
                                              fontFamily: 'kanit',
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        endTime[0] = value!;
                                        used = calculateUsedDay(
                                            isFullDay,
                                            DateTime(
                                                startDate.year,
                                                startDate.month,
                                                startDate.day,
                                                int.parse(startTime[0]),
                                                int.parse(startTime[1])),
                                            DateTime(
                                                endDate.year,
                                                endDate.month,
                                                endDate.day,
                                                int.parse(endTime[0]),
                                                int.parse(endTime[1])),
                                            dayCannotLeave);
                                      });
                                    }),
                              ),
                              Text(
                                " : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                // height: 35,
                                // width: 120,
                                child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      focusedBorder: borderStyle,
                                      enabledBorder: borderStyle,
                                      errorStyle: TextStyle(fontSize: 14),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5),
                                      border: borderStyle,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "${AppLocalizations.of(context)!.selectminutes}";
                                      } else if (startDate.isAfter(endDate)) {
                                        return "${AppLocalizations.of(context)!.incorrectdateortime}";
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    hint: Text(
                                      "${AppLocalizations.of(context)!.minute}",
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    value: endTime[1],
                                    items: minutes
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'kanit',
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        endTime[1] = value!;
                                        used = calculateUsedDay(
                                            isFullDay,
                                            DateTime(
                                                startDate.year,
                                                startDate.month,
                                                startDate.day,
                                                int.parse(startTime[0]),
                                                int.parse(startTime[1]),
                                                0),
                                            DateTime(
                                                endDate.year,
                                                endDate.month,
                                                endDate.day,
                                                int.parse(endTime[0]),
                                                int.parse(endTime[1]),
                                                0),
                                            dayCannotLeave);
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.note}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: TextFormField(
                            maxLength: 500,
                            maxLines: 5,
                            onChanged: (String value) {
                              note = value;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              hintText:
                                  "${AppLocalizations.of(context)!.descriptions}",
                              border: borderStyle,
                              enabledBorder: borderStyle,
                              focusedBorder: borderStyle,
                            ),
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
                          "${AppLocalizations.of(context)!.attachfile}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffC4C4C4))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'jpg',
                                          'png',
                                          'jpeg'
                                        ],
                                        allowMultiple: false,
                                        withData: false,
                                        withReadStream: false,
                                      );
                                      if (result != null) {
                                        filePic = result!.files.first;
                                        setState(() {
                                          isUpload = true;
                                          filePath = result!.files.single.path!;
                                          fileName = result!.files.first.name;
                                        });
                                      } else {
                                        return;
                                      }
                                    },
                                    icon: const Icon(Icons.folder),
                                    label: Text(
                                      "${AppLocalizations.of(context)!.clickselectfile}",
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        fileName,
                                        style: TextStyle(),
                                      ),
                                      if (isUpload)
                                        InkWell(
                                          onTap: () async {
                                            File file = File(
                                                result!.files.single.path!);
                                            await file.delete();
                                            filePic = null;
                                            isUpload = false;
                                            filePath = "";
                                            fileName = "No file selected";
                                            setState(() {});
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        )
                                    ],
                                  ),
                                  if (filePic != null)
                                    Container(
                                      width: 200,
                                      height: 100,
                                      child: show(file: filePic!),
                                    ),
                                  Text(
                                    "*Allowed *.jpeg, *.jpg, *.png, max size of 3 MB",
                                    softWrap: true,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 14),
                    child: MultipleSearchSelection<ManagerLeave>(
                      clearSearchFieldOnSelect: true,
                      showClearAllButton: false,
                      selectAllButton: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "${AppLocalizations.of(context)!.selectAll}",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6FC9E4)),
                      ),
                      clearAllButton: ElevatedButton(
                        onPressed: () {},
                        child: Text("${AppLocalizations.of(context)!.clearall}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffE793B8)),
                      ),
                      items: widget.managerData,
                      fieldToCheck: (c) {
                        return c.firstnameTh!;
                      },
                      itemBuilder: (manager, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 12,
                              ),
                              child: ListTile(
                                title: Text(
                                    "${manager.firstnameTh!} ${manager.lastnameTh!}"),
                                subtitle: Text("${manager.email!}"),
                              ),
                            ),
                          ),
                        );
                      },
                      pickedItemBuilder: (manager) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${manager.firstnameTh!} ${manager.lastnameTh!}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onTapShowedItem: () {},
                      onTapClearAll: () {
                        setState(() {
                          selectedManager.clear();
                        });
                      },
                      onTapSelectAll: () {},
                      onPickedChange: (items) {},
                      onItemAdded: (item) {
                        setState(() {
                          selectedManager.add(item);
                        });
                      },
                      onItemRemoved: (item) {
                        setState(() {
                          selectedManager.removeWhere((element) =>
                              element.idEmployees == item.idEmployees);
                        });
                      },
                      sortShowedItems: true,
                      sortPickedItems: true,
                      fuzzySearch: FuzzySearch.jaro,
                      itemsVisibility: ShowedItemsVisibility.onType,
                      title: Text(
                        '${AppLocalizations.of(context)!.cctomanager}',
                        style: TextStyle(fontSize: 20),
                      ),
                      showSelectAllButton: false,
                      maximumShowItemsHeight: 200,
                      searchField: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          hintText:
                              "${AppLocalizations.of(context)!.searchmanager}",
                          border: borderStyle,
                          focusedBorder: borderStyle,
                          enabledBorder: borderStyle,
                        ),
                      ),
                    ),
                  ),
                  BlocConsumer<LeaveBloc, LeaveState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).devicePixelRatio * 10,
                            bottom:
                                MediaQuery.of(context).devicePixelRatio * 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.leaves}",
                                  style: TextStyle(fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            if (leaveType != null &&
                                daysInAdvance(leaveType!, startDate) > 0) ...[
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                        "*วันลาไม่ถึงขั้นต่ำที่กำหนด ต้องขอลาล่วงหน้าอย่างน้อย ${leaveType!.daysInAdvance} วัน (นับจากวันปัจจุบัน)",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)),
                                  ),
                                ],
                              )
                            ] else if (!isInTimeFrame &&
                                !isFullDay &&
                                !isHalfDay) ...[
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                        "*ไม่สามารถลางานนอกเวลาทำงานได้ \n"
                                        "(${toDayLeaveAvailable != null ? toDayLeaveAvailable!.timeIn!.substring(0, 5) : ''} - "
                                        "${toDayLeaveAvailable != null ? toDayLeaveAvailable!.timeOut!.substring(0, 5) : ''})",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)),
                                  ),
                                ],
                              )
                            ] else if (!isFullDay &&
                                !isHalfDay &&
                                !isNotLessHalfHour()) ...[
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                        "*จำนวนการลาไม่ถึงขั้นต่ำที่กำหนด",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)),
                                  ),
                                ],
                              )
                            ] else if ((startDate.compareTo(endDate) == 1 &&
                                    isHalfDay == false) ||
                                used < 0) ...[
                              Text(
                                "*วันที่หรือเวลาไม่ถูกต้อง",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ] else if (used > -1) ...[
                              Text(
                                "${used.toStringAsFixed(2)} ${AppLocalizations.of(context)!.day} (${leaveCalHour.toStringAsFixed(2)} ${AppLocalizations.of(context)!.hour})",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    },
                    listener: (BuildContext context, LeaveState state) {
                      if (state.status == FetchStatus.success) {
                        dayCannotLeave = state.dayCannotLeave;
                        toDayLeaveAvailable = state.dayCannotLeave
                            .firstWhere((e) => e.date == startDate);
                        if (isFullDay) {
                          used = calculateUsedDay(
                              isFullDay,
                              DateTime(startDate.year, startDate.month,
                                  startDate.day, 0, 0, 0, 0, 0),
                              DateTime(endDate.year, endDate.month, endDate.day,
                                  0, 0, 0, 0, 0),
                              state.dayCannotLeave);
                        } else {
                          used = calculateUsedDay(
                              isFullDay,
                              DateTime(startDate.year, startDate.month,
                                  startDate.day),
                              DateTime(
                                  endDate.year, endDate.month, endDate.day),
                              dayCannotLeave);
                        }
                        setState(() {});
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5,
                        bottom: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.currentrightsremaining}",
                              style: TextStyle(fontSize: 19),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (leaveType != null &&
                                leaveType!.isLeaveAnnual == 1) ...[
                              (((leaveType!.carryRemain ?? 0) +
                                              (leaveType!.leaveRemain ?? 0)) -
                                          used <=
                                      0)
                                  ? (((leaveType!.carryRemain ?? 0) +
                                                  (leaveType!.leaveRemain ??
                                                      0)) -
                                              used <
                                          0
                                      ? Text(
                                          "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red))
                                      : Text(
                                          "${((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)).toStringAsFixed(2)} ${AppLocalizations.of(context)!.day}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  : Text(
                                      "${((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0))} ${AppLocalizations.of(context)!.day}",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ))
                            ] else if (leaveType != null &&
                                leaveType!.isLeaveCompensate == 1) ...[
                              ((leaveType!.carryRemain ?? 0) +
                                          (leaveType!.leaveRemain ?? 0)) <
                                      0
                                  ? Text(
                                      "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red))
                                  : Text(
                                      "${((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hour}",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                            ] else ...[
                              leaveType != null
                                  ? (leaveType!.leaveRemain != null &&
                                          leaveType!.leaveRemain! < 0)
                                      ? Text(
                                          "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          leaveType!.leaveRemain == null
                                              ? "${AppLocalizations.of(context)!.unlimited}"
                                              : "${(leaveType!.leaveRemain! + (leaveType!.carryRemain ?? 0)).toStringAsFixed(2)} ${leaveType!.isLeaveCompensate == 1 ? 'ชั่วโมง' : 'วัน'}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                  : Text("-")
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).devicePixelRatio * 5,
                        bottom: MediaQuery.of(context).devicePixelRatio * 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.remainingrightsafterrequestingleave}",
                              style: TextStyle(fontSize: 19),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (leaveType != null &&
                                leaveType!.isLeaveAnnual == 1) ...[
                              (((leaveType!.carryRemain ?? 0) +
                                              (leaveType!.leaveRemain ?? 0)) -
                                          used <=
                                      0)
                                  ? (((leaveType!.carryRemain ?? 0) +
                                                  (leaveType!.leaveRemain ??
                                                      0)) -
                                              used <
                                          0
                                      ? Text(
                                          "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red))
                                      : Text(
                                          "${(((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)) - used).toStringAsFixed(2)} ${AppLocalizations.of(context)!.day}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  : Text(
                                      "${(((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)) - used).toStringAsFixed(2)} ${AppLocalizations.of(context)!.day}",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ))
                            ] else if (leaveType != null &&
                                leaveType!.isLeaveCompensate == 1 &&
                                leaveCalHour > 0) ...[
                              ((leaveType!.carryRemain ?? 0) +
                                          (leaveType!.leaveRemain ?? 0)) <
                                      leaveCalHour
                                  ? Text(
                                      "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red))
                                  : Text(
                                      "${((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0) - leaveCalHour).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hour}",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                            ] else ...[
                              leaveType != null
                                  ? ((leaveType!.leaveRemain ?? 999) - used) < 0
                                      ? Text(
                                          "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          leaveType!.leaveRemain == null
                                              ? "${AppLocalizations.of(context)!.unlimited}"
                                              : "${(leaveType!.leaveRemain! + (leaveType!.carryRemain ?? 0) - used).toStringAsFixed(2)} ${leaveType!.isLeaveCompensate == 1 ? 'ชั่วโมง' : 'วัน'}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                  : Text("-")
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
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
                            backgroundColor: used > 0 &&
                                    leaveType != null &&
                                    (leaveType!.leaveRemain ?? 999) +
                                            (leaveType!.carryRemain ?? 0) -
                                            used >=
                                        0 &&
                                    daysInAdvance(leaveType!, startDate) <= 0 &&
                                    isEnoughLeave() &&
                                    isNotLessHalfHour()
                                ? const Color(0xffE793B8)
                                : Colors.grey),
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              used > 0 &&
                              (leaveType != null &&
                                  ((leaveType!.leaveRemain ?? 999) +
                                          (leaveType!.carryRemain ?? 0) -
                                          used) >=
                                      0 &&
                                  daysInAdvance(leaveType!, startDate) <= 0) &&
                              isEnoughLeave() &&
                              isNotLessHalfHour()) {
                            if (widget.historyData.any((element) => (element.isFullDay ==
                                    1
                                ? (isBetween(startDate, element.start!, element.end!, "day", "[]") ||
                                    isBetween(endDate, element.start!,
                                        element.end!, "day", "[]") ||
                                    (isBetween(element.start!, startDate, endDate, 'day', "[]") &&
                                        isBetween(element.end!, startDate,
                                            endDate, 'day', "[]")))
                                : (isBetween(DateTime(startDate.year, startDate.month, startDate.day, int.parse(startTime[0]), int.parse(startTime[1])), element.start!, element.end!, 'minute', "[)") ||
                                    isBetween(
                                        DateTime(
                                            endDate.year,
                                            endDate.month,
                                            endDate.day,
                                            int.parse(endTime[0]),
                                            int.parse(endTime[1])),
                                        element.start!,
                                        element.end!,
                                        'minute',
                                        "(]") ||
                                    (isBetween(element.start!, DateTime(startDate.year, startDate.month, startDate.day, int.parse(startTime[0]), int.parse(startTime[1])), DateTime(endDate.year, endDate.month, endDate.day, int.parse(endTime[0]), int.parse(endTime[1])), 'minute', "[)") &&
                                        isBetween(
                                            element.end!,
                                            DateTime(startDate.year, startDate.month, startDate.day, int.parse(startTime[0]), int.parse(startTime[1])),
                                            DateTime(endDate.year, endDate.month, endDate.day, int.parse(endTime[0]), int.parse(endTime[1])),
                                            'minute',
                                            "(]")))))) {
                              showInSnackBar();
                            } else {
                              DateTime startRequestDate = DateTime(
                                  startDate.year,
                                  startDate.month,
                                  startDate.day,
                                  int.parse(startTime[0]),
                                  int.parse(startTime[1]));
                              DateTime endRequestDate = DateTime(
                                  endDate.year,
                                  endDate.month,
                                  endDate.day,
                                  int.parse(endTime[0]),
                                  int.parse(endTime[1]));
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ConfirmPage(
                                      data: widget.data,
                                      holidayLeaveEntity: widget.holidayLeave,
                                      start: startRequestDate,
                                      end: endRequestDate,
                                      leaveType: leaveType!,
                                      note: note,
                                      holiday: holiday,
                                      used: used,
                                      isFullDay: isFullDay,
                                      filePath: result,
                                      file: filePic,
                                      ccMail: selectedManager.isNotEmpty
                                          ? getAllManagerMail(selectedManager)
                                          : null,
                                      leaveCalHour: leaveCalHour,
                                    )),
                              );
                            }
                          }
                        },
                        child: Text(
                          "${AppLocalizations.of(context)!.requestleaveapproval}",
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

  double calculateUsedDay(bool isFullDay, DateTime startRequestDate,
      DateTime endRequestDate, List<DayCannotLeave> dayCannotLeave) {
    double diffDay = 0;
    int numOfUnusedDay = 0;
    int indexStartCount = 0;
    int indexEndCount = 0;

    leaveCalHour = 0;
    if (isFullDay) {
      if (dayCannotLeave.isNotEmpty) {
        indexStartCount = dayCannotLeave.indexOf(dayCannotLeave
            .firstWhere((element) => element.date == startRequestDate));
        indexEndCount = dayCannotLeave.indexOf(dayCannotLeave
            .firstWhere((element) => element.date == endRequestDate));
        for (var i = indexStartCount; i <= indexEndCount; i++) {
          if (dayCannotLeave[i].isWorkingDay == 0) {
            numOfUnusedDay++;
          } else {
            leaveCalHour += (dayCannotLeave[i].workingHours ?? 0) -
                ((dayCannotLeave[i].breakTime ?? 1) == 0 ? 1 : 0);
          }
        }
      }
      if (startRequestDate != endRequestDate) {
        diffDay =
            (endRequestDate.difference(startRequestDate).inDays + 1).toDouble();
      } else if (dayCannotLeave.isNotEmpty) {
        if (numOfUnusedDay >= 1) {
          return 0;
        } else if (dayCannotLeave[indexStartCount].isWorkingDay != 0) {
          return 1;
        }
      }
      return (diffDay) - numOfUnusedDay;
    } else if (isHalfDay) {
      if (dayCannotLeave.isNotEmpty) {
        DayCannotLeave data = dayCannotLeave
            .firstWhere((element) => element.date == startRequestDate);
        if (data.isWorkingDay == 0) {
          leaveCalHour = 0;
          startTime = ['00', '00'];
          endTime = ['00', '00'];
          return 0;
        }
        if (data.breakTime == 1) {
          leaveCalHour = (data.workingHours ?? 0) / 2;
          Day timeIn = Day.fromString(
              "${DateFormat("yyyy-MM-dd").format(data.date!)} ${data.timeIn}");
          Day timeOut = Day.fromString(
              "${DateFormat("yyyy-MM-dd").format(data.date!)} ${data.timeOut}");
          Day? startBreak = timeIn.add(leaveCalHour.toInt(), 'm');
          startTime = startBreak!.format('HH:mm').split(':');
          endTime = timeOut.format('HH:mm').split(':');
          return 0.5;
        }
        if (data.startBreak != null) {
          List<String> tempStart = startTime;
          List<String> tempEnd = endTime;
          Day timeIn = Day.fromString(
              "${DateFormat("yyyy-MM-dd").format(data.date!)} ${data.timeIn}");
          Day timeOut = Day.fromString(
              "${DateFormat("yyyy-MM-dd").format(data.date!)} ${data.timeOut}");
          Day startBreak = Day.fromString(
              "${DateFormat("yyyy-MM-dd").format(data.date!)} ${data.startBreak}");
          if (isFirstHalf) {
            leaveCalHour = (timeIn.diff(startBreak) / 3600000).abs();
            tempStart = timeIn.format('HH:mm').split(':');
            tempEnd = startBreak.format('HH:mm').split(':');
          } else {
            Day? endBreak = startBreak.add(data.breakTimeMin!, 'm');
            leaveCalHour = (endBreak!.diff(timeOut) / 3600000).abs();
            tempStart = endBreak.format('HH:mm').split(':');
            tempEnd = timeOut.format('HH:mm').split(':');
          }
          startTime = tempStart;
          endTime = tempEnd;
          return leaveCalHour /
              ((data.workingHours ?? 0) - (data.breakTime! == 0 ? 1 : 0));
        } else {
          int leaveCalMinute = ((data.workingMinutes ?? 0) ~/ 2).toInt();
          leaveCalHour = leaveCalMinute / 60;
          Day timeIn = Day.fromString(
              "${DateFormat("yyyy-MM-dd").format(data.date!)} ${data.timeIn}");
          Day? startBreak = timeIn.add(leaveCalMinute, 'm');
          startTime = timeIn.format('HH:mm').split(':');
          endTime = startBreak!.format('HH:mm').split(':');
          return 0.5;
        }
      }
    } else if (!isFullDay && !isHalfDay) {
      Day startWorkingDayPeriod = Day.fromString(
          "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeIn}");
      Day endWorkingDayPeriod = Day.fromString(
          "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeOut}");
      Day currentStartDate = Day.fromDateTime(startRequestDate);
      Day currentEndDate = Day.fromDateTime(endRequestDate);
      int breakTime = 60;
      if (toDayLeaveAvailable != null &&
          toDayLeaveAvailable!.breakTime != null) {
        if (toDayLeaveAvailable!.breakTime == 1) {
          breakTime = 0;
        } else {
          breakTime = toDayLeaveAvailable!.breakTimeMin != null
              ? toDayLeaveAvailable!.breakTimeMin
              : 60;
        }
      }
      double workingHours =
          ((toDayLeaveAvailable!.workingMinutes ?? 540) - breakTime) / 60;
      // กรณีที่เวลาทำงาน 07.30 - 19.30
      if (Day.fromString(
                  "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeIn!}")
              .compareTo(Day.fromString(
                  "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeOut!}")) !=
          1) {
        // currentEndDate = currentStartDate;
        isInTimeFrame = (currentStartDate.isAfter(startWorkingDayPeriod) ||
                currentStartDate == startWorkingDayPeriod) &&
            (currentEndDate.isBefore(endWorkingDayPeriod) ||
                currentEndDate == endWorkingDayPeriod);
      }
      // กรณีที่เวลาทำงาน 19.30 - 07.30
      else {
        endWorkingDayPeriod.add(10, 'date');
        isInTimeFrame = (currentStartDate.isAfter(startWorkingDayPeriod) ||
                currentStartDate == startWorkingDayPeriod) &&
            (currentEndDate.isBefore(endWorkingDayPeriod.add(1, 'date')!) ||
                endWorkingDayPeriod.add(1, 'date')! == currentEndDate);
      }
      if (isInTimeFrame) {
        if (Day.fromString(
                    "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeIn!}")
                .compareTo(Day.fromString(
                    "${DateFormat("yyyy-MM-dd").format(toDayLeaveAvailable!.date!)} ${toDayLeaveAvailable!.timeOut!}")) ==
            1) {
          leaveCalHour = (currentEndDate.diff(currentStartDate)) * 2.7778E-07;
          return ((currentEndDate.diff(currentStartDate) * 1.1574E-08) /
                  0.0416664) /
              12;
        }
        var numDiff = 0;
        int hourDiff = endRequestDate.hour - startRequestDate.hour;
        int minuteDiff = (endRequestDate.minute - startRequestDate.minute);
        if ((toDayLeaveAvailable!.breakTime ?? 1) == 0) {
          DateTime startBreak = DateTime(startRequestDate.year,
              startRequestDate.month, startRequestDate.day, 12, 0, 0);
          DateTime endBreak = DateTime(startRequestDate.year,
              startRequestDate.month, startRequestDate.day, 13, 0, 0);
          if (isBetween(
                  startRequestDate, startBreak, endBreak, "minute", "[)") &&
              isBetween(endRequestDate, startBreak, endBreak, "minute", "(]")) {
            numDiff = -Day.fromDateTime(endRequestDate)
                .diff(Day.fromDateTime(startRequestDate), 'm');
          } else if (isBetween(
              startRequestDate, startBreak, endBreak, "minute", "[)")) {
            numDiff = -Day.fromDateTime(endBreak)
                .diff(Day.fromDateTime(startRequestDate), 'm');
          } else if (isBetween(
              endRequestDate, startBreak, endBreak, "minute", "(]")) {
            numDiff = -Day.fromDateTime(endRequestDate)
                .diff(Day.fromDateTime(startBreak), 'm');
          } else if (isBetween(startBreak, startRequestDate, endRequestDate,
                  "minute", "[)") &&
              isBetween(
                  endBreak, startRequestDate, endRequestDate, "minute", "(]")) {
            numDiff = -Day.fromDateTime(endBreak)
                .diff(Day.fromDateTime(startBreak), 'm');
          }
        }
        double inDays =
            (((hourDiff * 60) + numDiff + minuteDiff) / 60) / workingHours;
        diffDay = double.parse(inDays.toStringAsFixed(2));

        leaveCalHour =
            (double.parse('${currentEndDate.diff(currentStartDate, 'm')}') +
                    double.parse('${numDiff}')) /
                60;
        return double.parse((inDays).toStringAsFixed(2));
      }
    }
    return 0;
  }

  bool isEnoughLeave() {
    if (leaveType != null && leaveType!.isLeaveAnnual == 1) {
      if (((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)) -
              used <=
          0) {
        if (((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)) -
                used <
            0) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else if (leaveType != null && leaveType!.isLeaveCompensate == 1) {
      if (((leaveType!.carryRemain ?? 0) + (leaveType!.leaveRemain ?? 0)) <
          leaveCalHour) {
        return false;
      } else {
        return true;
      }
    } else {
      if (leaveType != null) {
        if (((leaveType!.leaveRemain ?? 999) - used) < 0) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}
