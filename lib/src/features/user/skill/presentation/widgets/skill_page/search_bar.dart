import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:unihr/src/features/user/skill/presentation/widgets/skill_page/search_mock.dart';

class SearchBarSkill extends StatefulWidget {
  const SearchBarSkill({super.key});

  @override
  State<SearchBarSkill> createState() => _SearchBarSkillState();
}

class _SearchBarSkillState extends State<SearchBarSkill> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countries = data.map((e) => Country.fromMap(e)).toList();
  }

  final focus = FocusNode();
  List<Country> countries = [];

  bool containsCountry(String text) {
    final Country? result = countries.firstWhere(
        (Country country) => country.name.toLowerCase() == text.toLowerCase(),
        orElse: () => Country.init());

    if (result!.name.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 280,
                child: SearchField(
                    controller: searchController,
                    searchStyle: GoogleFonts.kanit(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    hint: "Search Skill",
                    suggestions: countries
                        .map(
                          (e) => SearchFieldListItem(
                            e.name,
                            item: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${e.name}",
                                    style: GoogleFonts.kanit(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onSuggestionTap: (SearchFieldListItem x) {
                      FocusScope.of(context).unfocus();
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
              // Container(
              //     child: IconButton(
              //         onPressed: () {}, icon: Icon(Icons.search_sharp,size: 30,),))
            ],
          ),
        ),
      ),
    );
  }
}
