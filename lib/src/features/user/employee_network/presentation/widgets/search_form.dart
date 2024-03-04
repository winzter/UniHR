import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:unihr/src/features/user/employee_network/presentation/bloc/employee_network_bloc.dart';
import '../../domain/entities/employee_network_entity.dart';

class SearchForm extends StatefulWidget {

  final List<EmployeeNetworkEntity> allEmpData;

  final EmployeeNetworkBloc bloc;
  const SearchForm({super.key, required this.allEmpData, required this.bloc});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {

  TextEditingController searchController = TextEditingController();
  OutlineInputBorder borderStyle = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffC4C4C4)),
      borderRadius: BorderRadius.all(
          Radius.circular(15)));
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: SearchField(
          controller: searchController,
          searchStyle: GoogleFonts.kanit(
            fontSize: 18,
            color: Colors.black.withOpacity(0.8),
          ),
          hint: "ค้นหาพนักงานที่สนใจ",
          suggestions: widget.allEmpData
              .map(
                (e) => SearchFieldListItem(
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
                      "${e.firstnameTh} ${e.lastnameTh}",
                      style: GoogleFonts.kanit(),
                    )
                  ],
                ),
              ),
            ),
          ).toList(),
          onSuggestionTap: (SearchFieldListItem x) {
            FocusScope.of(context).unfocus();
            widget.bloc.add(ShowSomeEmpData(empId: x.item!.idEmployees!));
          },
          onSearchTextChanged: (String? text){
            if(text == ""){
              widget.bloc.add(ShowSomeEmpData(empId: null));
            }
            return null;
          },
          suggestionsDecoration: SuggestionDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Color(0xffC4C4C4))
          ),
          searchInputDecoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(Icons.search_sharp),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(10),
            border:borderStyle,
            focusedBorder: borderStyle,
            enabledBorder: borderStyle,
          )),
    );
  }
}
