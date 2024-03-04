import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/LocationBloc_bloc.dart';

class DateRangeButton extends StatefulWidget {
  final LocationBloc bloc;
  final int idEmp;
  const DateRangeButton({super.key, required this.bloc, required this.idEmp});

  @override
  State<DateRangeButton> createState() => _DateRangeButtonState();
}

class _DateRangeButtonState extends State<DateRangeButton> {
  TextEditingController dateController = TextEditingController();

  Future pickDate() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2030, 12));

    if (newDate == null) {
      return;
    } else {
      final startDateFormatted = DateFormat("dd/MM/yyyy").format(newDate);
      widget.bloc.add(GetTimeLineDataById(idEmp: widget.idEmp, date: newDate));
      setState(() {
        dateController.text = "$startDateFormatted";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${AppLocalizations.of(context)!.searchdate}",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
            width: 250,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: dateController,
              readOnly: true,
              onTap: pickDate,
              style: TextStyle(),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  suffixIcon: const Icon(Icons.calendar_month),
                  hintText: "${AppLocalizations.of(context)!.mm_dd_yy}",
                  hintStyle: TextStyle(),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorStyle: TextStyle()),
            ),
          ),
        ],
      ),
    );
  }
}
