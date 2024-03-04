import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../pages/end_page.dart';
import 'widgets.dart';
import '../../domain/entities/enitities.dart';
import '../bloc/time_management_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeScheduleBody extends StatelessWidget {
  final TimeManagementBloc bloc;
  // final List<HolidayEntity> holidayData;
  final Map<int, String> holidayData;
  final Map<int, String> holidayDataEn;
  final List<TimeScheduleEntity> timeScheduleData;
  // final List<HolidayEntity> holidays;
  final List<int> checkHoliday;
  final Map<int, List<dynamic>> shiftName;

  const TimeScheduleBody(
      {super.key,
      required this.timeScheduleData,
      required this.bloc,
      required this.shiftName,
      // required this.holidays,
      required this.checkHoliday,
      required this.holidayData,
      required this.holidayDataEn});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // bloc.add(TimeManagementLoadShiftData());
        bloc.add(TimeManagementLoadScheduleData(startDate: null, date: null));
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: timeScheduleData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CardList(
                  data: timeScheduleData[index],
                  index: index,
                  bloc: bloc,
                  shiftName: shiftName,
                  checkHoliday: checkHoliday,
                  holidayData: holidayData,
                  holidayDataEn: holidayDataEn),
              if (DateFormat('EE').format(timeScheduleData[index].date!) ==
                  "อา.")
                const Divider(
                  thickness: 10,
                  color: Color(0xffEAEDF2),
                  height: 35,
                ),
              if (DateFormat('EE').format(timeScheduleData[index].date!) ==
                  "Sun")
                const Divider(
                  thickness: 10,
                  color: Color(0xffEAEDF2),
                  height: 35,
                )
            ],
          );
        },
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final int index;
  final TimeScheduleEntity data;
  final TimeManagementBloc bloc;
  final Map<int, List<dynamic>> shiftName;
  final List<int> checkHoliday;
  // final List<HolidayEntity> holidayData;
  final Map<int, String> holidayData;
  final Map<int, String> holidayDataEn;

  const CardList({
    super.key,
    required this.data,
    required this.index,
    required this.bloc,
    required this.shiftName,
    required this.checkHoliday,
    required this.holidayData,
    required this.holidayDataEn,
  });

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MapEntry<int, List<dynamic>>? selectedValue;
  MapEntry<int, List<dynamic>>? preSelected;
  // String? holiday;
  MapEntry<int, String>? holiday;
  // List<HolidayEntity> holidayList = [];
  List<MapEntry<int, String>> holidayList = [];
  List<MapEntry<int, String>> holidayListEn = [];
  final List<MapEntry<int, List<dynamic>>> data = [];

  Future confirmChangeTime(BuildContext context, TimeScheduleEntity data,
      MapEntry<int, List<dynamic>> value, String shiftNow) async {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Center(
                  child: Column(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF6FC9E4),
                    size: 60,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.areyousure} ?',
                    style: TextStyle(color: const Color(0xff75838F)),
                  ),
                ],
              )),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value.value[0] == "วันหยุดนักขัตฤกษ์") ...[
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField2<MapEntry<int, String>>(
                        isExpanded: true,
                        alignment: Alignment.center,
                        validator: (value) {
                          if (value == null) {
                            return '${AppLocalizations.of(context)!.chooseaholiday}"';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: AppLocalizations.of(context)!.hello == "Hello"
                            ? holidayListEn
                                .map<DropdownMenuItem<MapEntry<int, String>>>(
                                    (MapEntry<int, String> entry) {
                                return DropdownMenuItem<MapEntry<int, String>>(
                                  value: entry,
                                  child: Center(child: Text(entry.value)),
                                );
                              }).toList()
                            : holidayList
                                .map<DropdownMenuItem<MapEntry<int, String>>>(
                                    (MapEntry<int, String> entry) {
                                return DropdownMenuItem<MapEntry<int, String>>(
                                  value: entry,
                                  child: Center(child: Text(entry.value)),
                                );
                              }).toList(),
                        hint: Text(
                            "${AppLocalizations.of(context)!.chooseaholiday}"),
                        style: TextStyle(
                            fontFamily: 'kanit',
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        buttonStyleData: ButtonStyleData(
                            padding: EdgeInsets.all(0),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xffc4c4c4),
                                ),
                                borderRadius: BorderRadius.circular(10))),
                        menuItemStyleData: MenuItemStyleData(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).devicePixelRatio *
                                        1.5,
                                vertical: 0)),
                        dropdownStyleData: DropdownStyleData(
                          padding: EdgeInsets.zero,
                          maxHeight: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: holiday,
                        onChanged: (MapEntry<int, String>? value) {
                          holiday = value!;
                          setStateDialog(() {});
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                    Text(
                      DateFormat("dd MMMM yyyy").format(data.date!),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                    value.value[0] == "วันหยุดนักขัตฤกษ์" && value.value[2] == 0
                        ? "วันหยุดนักขัตฤกษ์" : (value.value[2] == 0 ? "วันหยุดประจำสัปดาห์":value.value[0].toString()),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('${AppLocalizations.of(context)!.cancel}',
                          style: TextStyle(color: const Color(0xffA5AFBA))),
                      onPressed: () {
                        holiday = null;
                        setStateDialog(() {});
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF6FC9E4)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius here
                            ),
                          )),
                      child: Text(
                          '${AppLocalizations.of(context)!.confirmtimechange}',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (preSelected!.value[0] == "วันหยุดนักขัตฤกษ์") {
                          if (formKey.currentState!.validate()) {
                            // int idHoliday = widget.holidayData
                            //     .firstWhere(
                            //         (element) => element.name == holiday!)
                            //     .idHoliday!;
                            widget.bloc.add(SendChangeTimeData(
                                idShiftType: value.key,
                                idShiftGroup: null,
                                idEmp: profileProvider.profileData.idEmployees!,
                                shiftName: value.value[0].toString(),
                                shiftNowName:
                                    widget.data.dataRender!.shiftName!,
                                date: widget.data.date!,
                                context: context,
                                // idHoliday: idHoliday
                                idHoliday: holiday!.key));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EndPage(
                                    shiftName: preSelected!.value[0].toString(),
                                    date: widget.data.date!,
                                    isError: false,
                                  ),
                                )).then((value) {
                              // widget.bloc.add(TimeManagementLoadShiftData());
                              widget.bloc.add(TimeManagementLoadScheduleData(
                                  startDate: null, date: null));
                            });
                          }
                        } else {
                          widget.bloc.add(SendChangeTimeData(
                              idShiftType: value.key,
                              idEmp: profileProvider.profileData.idEmployees!,
                              shiftName: value.value[2].toString(),
                              idShiftGroup: value.value[1],
                              shiftNowName: widget.data.dataRender!.shiftName!,
                              date: widget.data.date!,
                              context: context,
                              idHoliday: null));
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: EndPage(
                                  shiftName: preSelected!.value[0].toString(),
                                  date: widget.data.date!,
                                  isError: false,
                                ),
                              )).then((value) {
                            // widget.bloc.add(TimeManagementLoadShiftData());
                            widget.bloc.add(TimeManagementLoadScheduleData(
                                startDate: null, date: null));
                          });
                          selectedValue = value;
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    widget.shiftName.forEach((key, value) => data.add(MapEntry(key, value)));
    if (widget.data.dataRender!.isWorkingDay == 1) {
      selectedValue = data.firstWhere(
          (element) => element.key == widget.data.dataRender!.idShiftType!);
    }
    widget.holidayData.forEach((key, value) {
      if (!widget.checkHoliday.contains(key)) {
        holidayList.add(MapEntry(key, value));
      }
    });
    widget.holidayDataEn.forEach((key, value) {
      if (!widget.checkHoliday.contains(key)) {
        holidayListEn.add(MapEntry(key, value));
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: DayDetailPage(
                timeScheduleData: [],
                data: widget.data,
                shiftName: widget.shiftName,
                bloc: widget.bloc,
                holidayData: widget.holidayData,
              ),
            )).then((value) {
          if (value != null) {
            // widget.bloc.add(TimeManagementLoadShiftData());
            widget.bloc.add(
                TimeManagementLoadScheduleData(startDate: null, date: null));
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: (widget.data.requestChange!.isNotEmpty &&
                  widget.data.requestChange![widget.data.requestChange!.length - 1].isApprove != null)
              ? 160
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
                        color: dayColors(widget.data),
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20)),
                        border: Border.all(color: Colors.transparent)),
                    child: Center(
                        child: Text(
                      DateFormat("EE").format(widget.data.date!),
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
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 50,
                            child: Text(
                              DateFormat("dd/MM/yyyy")
                                  .format(widget.data.date!),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              flex: 75,
                              child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.workingday,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ))),
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: DropdownButton2<MapEntry<int, List<dynamic>>>(
                          isExpanded: true,
                          alignment: Alignment.center,
                          underline: Container(),
                          items: data.map<
                                  DropdownMenuItem<
                                      MapEntry<int, List<dynamic>>>>(
                              (MapEntry<int, List<dynamic>> entry) {
                            return DropdownMenuItem<
                                MapEntry<int, List<dynamic>>>(
                              enabled: entry.key != 9999 &&
                                  entry.key != 999 &&
                                  entry.key != 10000,
                              value: entry,
                              child: Center(
                                  child: Text(
                                entry.key == 9999
                                    ? AppLocalizations.of(context)!.workingday
                                    : entry.key == 999
                                        ? AppLocalizations.of(context)!
                                            .weeklyholiday
                                        : entry.key == 10000
                                            ? AppLocalizations.of(context)!
                                                .publicholiday
                                            : entry.key == 1000
                                                ? AppLocalizations.of(context)!
                                                    .publicholiday
                                                : entry.value[0].toString(),
                                style: TextStyle(
                                    fontSize: (entry.key != 9999 &&
                                            entry.key != 999 &&
                                            entry.key != 10000)
                                        ? 17
                                        : 19,
                                    color: entry.key != 9999 &&
                                            entry.key != 999 &&
                                            entry.key != 10000
                                        ? Colors.black
                                        : Colors.grey,
                                    fontWeight: entry.key != 9999 &&
                                            entry.key != 999 &&
                                            entry.key != 10000
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              )),
                            );
                          }).toList(),
                          style: TextStyle(
                              fontFamily: 'kanit',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.all(0),
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color:
                                      widget.data.dataRender!.isWorkingDay == 0
                                          ? Colors.grey.shade300
                                          : Colors.white,
                                  border: Border.all(
                                    color: Color(0xffc4c4c4),
                                  ),
                                  borderRadius: BorderRadius.circular(15))),
                          menuItemStyleData: MenuItemStyleData(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).devicePixelRatio *
                                          1.5,
                                  vertical: 0)),
                          dropdownStyleData: DropdownStyleData(
                            padding: EdgeInsets.zero,
                            maxHeight: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          hint: Text(
                            "${AppLocalizations.of(context)!.dayoff}",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: selectedValue,
                          onChanged: (MapEntry<int, List<dynamic>>? newValue) {
                            bool hasRequest = false;
                            widget.data.requestChange?.forEach((element) {
                              if (element.isApprove == null) {
                                hasRequest = true;
                              }
                            });
                            if (!hasRequest) {
                              preSelected = newValue!;
                              setState(() {});
                              confirmChangeTime(context, widget.data, newValue,
                                  widget.data.dataRender!.shiftName!);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'ไม่สามารถทำรายการได้ \nเนื่องจากมีรายการคำขอรออนุมัติค้างอยู่',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          },
                        )),
                    if (widget.data.requestChange!.isNotEmpty) ...[
                      IsApprove(
                        data: widget.data,
                        shiftData: widget.shiftName,
                      ),
                    ],
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
