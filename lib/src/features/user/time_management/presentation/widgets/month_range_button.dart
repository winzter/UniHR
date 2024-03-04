import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:unihr/src/features/user/time_management/presentation/bloc/time_management_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthRangeButton extends StatefulWidget {
  final TimeManagementBloc bloc;

  const MonthRangeButton({super.key, required this.bloc});

  @override
  State<MonthRangeButton> createState() => _MonthRangeButtonState();
}

class _MonthRangeButtonState extends State<MonthRangeButton> {
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  DateTime? startDate;

  void monthPicker() {
    showMonthPicker(
            context: context,
            initialDate: startDate,
            headerColor: Colors.purple,
            selectedMonthBackgroundColor: Colors.purple,
            unselectedMonthTextColor: Colors.purple)
        .then((date) {
      if (date != null) {
        setState(() {
          startDate = date;
          widget.bloc.add(ChangeDate(date: date));
          monthController.text = DateFormat("MMMM").format(date);
          yearController.text = DateFormat("yyyy").format(date);
          // widget.bloc.add(TimeManagementLoadShiftData());
          widget.bloc.add(TimeManagementLoadScheduleData(
              startDate: DateFormat('yyyy-MM-dd').format(
                DateTime(date.year, date.month, 1),
              ),
              date: DateTime(date.year, date.month, 1)));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final dateNow = DateTime.now();
    startDate = DateTime(dateNow.year, dateNow.month+2, 0);
    monthController.text = DateFormat("MMMM").format(startDate!);
    yearController.text = DateFormat("yyyy").format(startDate!);
    widget.bloc.add(ChangeDate(date: startDate!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeManagementBloc, TimeManagementState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.month,
                    style: TextStyle(fontSize: 18),
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
                          borderSide: BorderSide(color: Color(0xffC4C4C4)),
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
                  Text(
                    AppLocalizations.of(context)!.year,
                    style: TextStyle(fontSize: 18),
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
                          borderSide: BorderSide(color: Color(0xffC4C4C4)),
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
                  Text(""),
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
                          color: const Color(0xff6FC9E4),
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
      },
    );
  }
}
