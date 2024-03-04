import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/learning_app_bar.dart';
import '../../../skill/presentation/widgets/challenge_skill_page/approve_history_card.dart';

class ApproveHistory extends StatelessWidget {
  const ApproveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "ประวัติการอนุมัติ", () { }),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).devicePixelRatio * 1,
            horizontal: MediaQuery.of(context).devicePixelRatio * 5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 25,left: 10,right: 10),
              child: ApproveHistoryCards(),
            );
          },
        ),
      ),
    );
  }
}
