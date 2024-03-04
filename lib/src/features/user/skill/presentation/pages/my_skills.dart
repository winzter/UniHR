import 'package:flutter/material.dart';
import '../../../learning/presentation/pages/pages.dart';
import '../../../learning/presentation/widgets/learning_widgets.dart';
import '../widgets/my_skill_page/skill_page_widgets.dart';

class MySkills extends StatelessWidget {
  const MySkills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLearning(context, "My Skills", () {}),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 3),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(
                      builder: (context) {
                        return DrawerButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              RecommendSkill(),
              CompleteSkill(),
              OnPlanSkill(),
              AppointedSkill(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SkillPage(),
                      ));
                },
                leading: Icon(Icons.construction),
                title: Text(
                  "ทักษะทั้งหมด",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              Builder(
                builder: (context) {
                  return ListTile(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChallengeSkillWaitingApprove(isAssessor: false,),
                          ));
                    },
                    leading: Icon(Icons.access_time_filled_sharp),
                    title: Text(
                      "รายการขอนัด",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),

              ExpansionTile(
                title: Text("Assessor",
                    style: TextStyle(fontSize: 18)),
                leading: Icon(Icons.assessment),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChallengeSkillWaitingApprove(isAssessor: true,),
                          ));
                    },
                    leading: Icon(Icons.access_time_filled_sharp),
                    title: Text(
                      "รายการขอนัด",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
