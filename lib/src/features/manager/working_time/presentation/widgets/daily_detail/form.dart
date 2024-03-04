import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/daily_detail_bloc/working_time_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchForm extends StatefulWidget {
  final WorkingTimeBloc bloc;
  final List<EmployeesEntity> empData;
  const SearchForm({super.key, required this.bloc, required this.empData});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

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
      widget.bloc.add(GetWorkingTimeData(
        start: DateFormat("yyyy-MM-dd").format(newDate),
      ));
      setState(() {
        dateController.text = "$startDateFormatted";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${AppLocalizations.of(context)!.name_sur}",
                style: GoogleFonts.kanit(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
                width: 250,
                child: SearchField<EmployeesEntity>(
                    controller: searchController,
                    searchStyle: GoogleFonts.kanit(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    suggestions: widget.empData
                        .map(
                          (e) => SearchFieldListItem<EmployeesEntity>(
                            e.firstnameTh!,
                            item: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${e.firstnameTh!} ${e.lastnameTh!}",
                                    style: GoogleFonts.kanit(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onSearchTextChanged: (String? text) {
                      if (text == "") {
                        widget.bloc.add(ShowSomeEmpAttendance(empId: null));
                      }
                      return null;
                    },
                    onSuggestionTap: (SearchFieldListItem<EmployeesEntity> x) {
                      FocusScope.of(context).unfocus();
                      widget.bloc.add(
                          ShowSomeEmpAttendance(empId: x.item!.idEmployees!));
                    },
                    suggestionsDecoration: SuggestionDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Color(0xffC4C4C4))),
                    searchInputDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.024,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${AppLocalizations.of(context)!.dateofsearch}",
                style: GoogleFonts.kanit(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
                width: 250,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: dateController,
                  readOnly: true,
                  onTap: pickDate,
                  style: GoogleFonts.kanit(),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      suffixIcon: const Icon(Icons.calendar_month),
                      hintText: "${AppLocalizations.of(context)!.mm_dd_yy}",
                      hintStyle: GoogleFonts.kanit(),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorStyle: GoogleFonts.kanit()),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

  void dispose() {
    super.dispose();
    dateController.dispose();
    searchController.dispose();
  }
}
