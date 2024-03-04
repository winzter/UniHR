import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/learning_app_bar.dart';
import '../widgets/complete_skill_page/grid_complete_skill.dart';


class MySkillCompletePage extends StatelessWidget {
  const MySkillCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "My Skill", null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridCompleteSkill(),
            ],
          ),
        ),
      ),
    );
  }
}
