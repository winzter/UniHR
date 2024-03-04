import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../../learning/presentation/widgets/learning_widgets.dart';
import '../../pages/my_skill_complete_page.dart';
import 'my_skill_card.dart';

class OnPlanSkill extends StatelessWidget {
  const OnPlanSkill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadingGradientLine(
              title: "On Plan",
              width: MediaQuery.of(context).size.width * 0.18,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MySkillCompletePage(),));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xff68D5E8),
                      ),
                      borderRadius: BorderRadius.circular(20))),
              child: GradientText(
                "ดูทั้งหมด",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                colors: const [
                  Color(0xff68D5E8),
                  Color(0xffF394BC),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                MySkillCards(level: 'Level 1', isAppointed: false,),
                MySkillCards(level: 'Level 2',isAppointed: false,),
                MySkillCards(level: 'Level 3',isAppointed: false,),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
