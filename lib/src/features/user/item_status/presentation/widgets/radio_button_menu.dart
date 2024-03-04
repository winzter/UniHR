import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/home/presentation/provider/leave_provider.dart';
import '../../../../../core/error/token_expires.dart';
import '../bloc/item_status_bloc.dart';
import '../providers/radio_button_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RadioButtonMenu extends StatefulWidget {
  final ItemStatusBloc itemStatusBloc;
  const RadioButtonMenu({super.key, required this.itemStatusBloc});

  @override
  State<RadioButtonMenu> createState() => _RadioButtonMenuState();
}

class _RadioButtonMenuState extends State<RadioButtonMenu> {
  TextEditingController dateController = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
    final item = Provider.of<WaitingProvider>(context, listen: false);
    setState(() {
      dateController.text =
          "${DateFormat("dd/MM/yyyy").format(dateRange.start)} - ${DateFormat("dd/MM/yyyy").format(dateRange.end)}";
      widget.itemStatusBloc.add(GetItemStatusData(
          startDate: DateFormat("yyyy-MM-dd").format(dateRange.start),
          endDate: DateFormat("yyyy-MM-dd").format(dateRange.end)));
      item.getAllDataByDate(dateRange,context);
    });
  }

  Future pickDateRange() async {
    final item = Provider.of<WaitingProvider>(context, listen: false);
    DateTimeRange? newDateRange = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
      initialDateRange: dateRange,
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

    if (newDateRange == null) {
      return;
    } else {
      final startDateFormatted =
          DateFormat("dd/MM/yyyy").format(newDateRange.start);
      final endDateFormatted =
          DateFormat("dd/MM/yyyy").format(newDateRange.end);
      widget.itemStatusBloc.add(GetItemStatusData(
          startDate: DateFormat("yyyy-MM-dd").format(newDateRange.start),
          endDate: DateFormat("yyyy-MM-dd").format(newDateRange.end)));
      setState(() {
        dateRange = newDateRange;
        dateController.text = "$startDateFormatted - $endDateFormatted";
        item.getAllDataByDate(dateRange,context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.date,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                  width: 250,
                  child: TextFormField(
                    onTap: pickDateRange,
                    controller: dateController,
                    readOnly: true,
                    style: TextStyle(),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        suffixIcon: const Icon(Icons.calendar_month),
                        hintText: "${AppLocalizations.of(context)!.mm_dd_yy}",
                        hintStyle: TextStyle(),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        errorStyle: TextStyle()),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.payruntype,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RadioButton(
                  title: "${AppLocalizations.of(context)!.all}",
                  value: "all",
                ),
                RadioButton(
                  title: "${AppLocalizations.of(context)!.requestleave}",
                  value: "ขอลา",
                ),
                RadioButton(
                  title: "${AppLocalizations.of(context)!.certifyntime}",
                  value: "ขอรับรองเวลาทำงาน",
                ),
                RadioButton(
                  title: "${AppLocalizations.of(context)!.worknOvertime}",
                  value: "ขอทำงานล่วงเวลา",
                ),
                RadioButton(
                  title: "${AppLocalizations.of(context)!.timeCompensate}",
                  value: "ขอทำชั่วโมงCompensate",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
  }
}

class RadioButton extends StatelessWidget {
  final String title;
  final String value;

  const RadioButton({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioButtonProvider>(context);
    return BlocBuilder<ItemStatusBloc, ItemStatusState>(
      builder: (context, state) {
        return Column(
          children: [
            Transform.scale(
              scale: 1.3,
              child: Radio(
                activeColor: const Color(0xffE793B8),
                value: value,
                groupValue: radioProvider.type,
                onChanged: (String? value) {
                  if (value != null) {
                    radioProvider.setType(value);
                  }
                },
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
