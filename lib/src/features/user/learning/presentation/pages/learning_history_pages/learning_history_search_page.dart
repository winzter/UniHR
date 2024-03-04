import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../skill/presentation/widgets/skill_page/search_mock.dart';

class LearningHistorySearchPage extends StatefulWidget {
  const LearningHistorySearchPage({super.key});

  @override
  State<LearningHistorySearchPage> createState() => _LearningHistorySearchPageState();
}

class _LearningHistorySearchPageState extends State<LearningHistorySearchPage> {

  TextEditingController searchController = TextEditingController();
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    countries = data.map((e) => Country.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
              },
              icon:SvgPicture.asset("assets/icons/learning_user/search_icon.svg")),
        ],
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xff6FC9E4),
                        Color(0xffE793B8),
                      ])),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.3)
                      ])),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        centerTitle: true,
        title: SearchField(
          controller: searchController,
          searchStyle: GoogleFonts.kanit(
            fontSize: 18,
            color: Colors.white,
          ),
          hint: "ค้นหาประวัติการเรียนรุู้",
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
                      style: GoogleFonts.kanit(color: Colors.white),
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
            border: Border.all(color: Color(0xffC4C4C4)),
          ),
          searchInputDecoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),

      ),
    );
  }
}
