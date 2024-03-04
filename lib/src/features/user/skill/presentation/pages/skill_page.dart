import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import '../widgets/skill_page/grid_skill_cards.dart';
import '../widgets/skill_page/search_bar.dart';
import '../../../learning/presentation/widgets/heading_with_gradient_line.dart';


class SkillPage extends StatefulWidget {
  const SkillPage({super.key});

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {

  int tag = 0;
  List<String> options = [
    'ทักษะทั้งหมด', 'Programming', 'Adaptability',
    'Problem-Solving', 'Communication', 'Leadership',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                Color(0xff6FC9E4),
                Color(0xffE793B8),
              ])),
        ),
        centerTitle: true,
        title: Text(
          'Skills',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xff6FC9E4), Color(0xffE793B8)])),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).devicePixelRatio * 4),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarSkill(),
                  HeadingGradientLine(
                    title: "ประเภททักษะ", width: MediaQuery.of(context).size.width*0.25,
                  ),
                  ChipsChoice<int>.single(
                    scrollPhysics: const BouncingScrollPhysics(),
                    value: tag,
                    onChanged: (val) => setState(() => tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                  HeadingGradientLine(
                    title: "รายชื่อทักษะ",width: MediaQuery.of(context).size.width*0.25,
                  ),
                  GridSkillCards(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
