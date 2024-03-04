import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/individual_detail/workingtime_individual_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchFormIndividual extends StatefulWidget {
  final WorkingTimeIndividualBloc bloc;
  final List<EmployeesEntity> empData;
  const SearchFormIndividual({
    super.key,
    required this.bloc,
    required this.empData,
  });

  @override
  State<SearchFormIndividual> createState() => _SearchFormIndividualState();
}

class _SearchFormIndividualState extends State<SearchFormIndividual> {
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  int? empId;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

  Future pickDateRange() async {
    FocusScope.of(context).unfocus();
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
      setState(() {
        dateRange = newDateRange;
        dateController.text = "$startDateFormatted - $endDateFormatted";
        if (empId != null) {
          widget.bloc.add(GetAttendanceEmpDateData(
              id: empId!,
              start: DateFormat("yyyy-MM-dd").format(newDateRange.start),
              end: DateFormat("yyyy-MM-dd").format(newDateRange.end)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
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
                        onSuggestionTap:
                            (SearchFieldListItem<EmployeesEntity> x) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            empId = x.item!.idEmployees!;
                          });
                          widget.bloc.add(GetAttendanceEmpDateData(
                              id: x.item!.idEmployees!,
                              start: DateFormat("yyyy-MM-dd")
                                  .format(dateRange.start),
                              end: DateFormat("yyyy-MM-dd")
                                  .format(dateRange.end)));
                        },
                        suggestionsDecoration: SuggestionDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Color(0xffC4C4C4))),
                        searchInputDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                      controller: dateController,
                      readOnly: true,
                      onTap: pickDateRange,
                      style: GoogleFonts.kanit(),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          suffixIcon: const Icon(Icons.calendar_month),
                          hintText: "${AppLocalizations.of(context)!.mm_dd_yy}",
                          hintStyle: GoogleFonts.kanit(),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          errorStyle: GoogleFonts.kanit()),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
    dateController.dispose();
    searchController.dispose();
  }
}
