import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:unihr/src/features/manager/overview/presentation/bloc/overview_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthYearPicker extends StatefulWidget {
  final OverviewBloc bloc;
  final String title;
  const MonthYearPicker({super.key, required this.bloc, required this.title});

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  DateTime? startMonth;

  @override
  void initState() {
    super.initState();
    startMonth = DateTime.now();
    monthController.text = DateFormat("MMMM").format(DateTime.now());
    yearController.text = DateFormat("yyyy").format(DateTime.now());
    widget.bloc.add(ChangeDate(date: startMonth!));
    if (widget.title == "มุมมองภาพรวม") {
      widget.bloc.add(GetOverviewData(
          year: startMonth!.year.toString(),
          month: startMonth!.month.toString()));
    } else if (widget.title == "ข้อมูลค่าล่วงเวลา") {
      widget.bloc.add(GetOvertimeData(
          year: startMonth!.year.toString(),
          month: startMonth!.month.toString()));
    } else if (widget.title == "ภาพรวมเวลาทำงาน") {
      widget.bloc.add(GetWorkingTimeData(
          year: startMonth!.year.toString(),
          month: startMonth!.month.toString()));
      widget.bloc.add(GetOvertimeData(
          year: startMonth!.year.toString(),
          month: startMonth!.month.toString()));
    } else if (widget.title == "ภาพรวมค่าใช้จ่าย") {
      widget.bloc.add(GetCostData(
          year: startMonth!.year.toString(),
          month: startMonth!.month.toString()));
    }
  }

  void monthPicker() {
    showMonthPicker(
      context: context,
      initialDate: startMonth,
    ).then((date) {
      if (date != null) {
        setState(() {
          startMonth = date;
          monthController.text = DateFormat("MMMM").format(date);
          yearController.text = DateFormat("yyyy").format(date);
          widget.bloc.add(ChangeDate(date: startMonth!));
          if (widget.title == "มุมมองภาพรวม") {
            widget.bloc.add(GetOverviewData(
                year: startMonth!.year.toString(),
                month: startMonth!.month.toString()));
          } else if (widget.title == "ข้อมูลค่าล่วงเวลา") {
            widget.bloc.add(GetOvertimeData(
                year: startMonth!.year.toString(),
                month: startMonth!.month.toString()));
          } else if (widget.title == "ภาพรวมเวลาทำงาน") {
            widget.bloc.add(GetWorkingTimeData(
                year: startMonth!.year.toString(),
                month: startMonth!.month.toString()));
            widget.bloc.add(GetOvertimeData(
                year: startMonth!.year.toString(),
                month: startMonth!.month.toString()));
          } else if (widget.title == "ภาพรวมค่าใช้จ่าย") {
            widget.bloc.add(GetCostData(
                year: startMonth!.year.toString(),
                month: startMonth!.month.toString()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "   ${AppLocalizations.of(context)!.month}",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                width: 130,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  controller: monthController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "   ${AppLocalizations.of(context)!.year}",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                width: 130,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  controller: yearController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              const Text(""),
              InkWell(
                onTap: monthPicker,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: const Color(0xffE793B8),
                      border: Border.all(color: Colors.transparent),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(17))),
                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
