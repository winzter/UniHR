import 'package:flutter/material.dart';
import '../../../learning/presentation/widgets/learning_app_bar.dart';
import '../widgets/challenge_skill_page/challenge_nested_page.dart';

class ChallengeSkill extends StatefulWidget {
  const ChallengeSkill({super.key});

  @override
  State<ChallengeSkill> createState() => _ChallengeSkillState();
}

class _ChallengeSkillState extends State<ChallengeSkill>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLearning(context, "Challenge Skill",null),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).devicePixelRatio * 7),
            child: TabBar(
              controller: tabController,
              onTap: (value) {
                setState(() {
                  tabController.index = value;
                });
              },
              indicatorWeight: 5,
              labelPadding: const EdgeInsets.all(0),
              labelColor: Colors.black,
              indicator: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff68D5E8), Color(0xffF394BC)])),
              indicatorPadding:
                  const EdgeInsets.only(top: 30, left: 2, right: 2),
              indicatorColor: Colors.deepPurple,
              tabs: [
                Text(
                  "Level 1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Level 2",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Level 3",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              ChallengeSkillSubPage(),
              ChallengeSkillSubPage(),
              ChallengeSkillSubPage(),
            ],
          ))
        ],
      ),
    );
  }
}
