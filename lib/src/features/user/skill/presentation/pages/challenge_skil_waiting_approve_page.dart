import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/learning_app_bar.dart';
import 'package:unihr/src/features/user/skill/presentation/pages/challenge_skill_deal_page.dart';
import '../widgets/challenge_skill_page/challenge_skill_card.dart';
import 'challenge_skill_duel.dart';

class ChallengeSkillWaitingApprove extends StatelessWidget {

  final bool isAssessor;
  const ChallengeSkillWaitingApprove({super.key, required this.isAssessor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarLearning(context, "Challenge Skill", null),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).devicePixelRatio * 1,
              horizontal: MediaQuery.of(context).devicePixelRatio * 5),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 25,left: 10,right: 10),
                child: InkWell(
                    onTap: (){
                      if(isAssessor){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeSkillDuel(),));
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeSkillDealPage(),));
                      }
                    },
                    child: ChallengeSkillCards()),
              );
            },
          ),
        ));
  }
}
