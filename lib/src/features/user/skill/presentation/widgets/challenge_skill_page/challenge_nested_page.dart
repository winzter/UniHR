import 'package:flutter/material.dart';
import 'widgets_challenge_skill.dart';

class ChallengeSkillSubPage extends StatelessWidget {
  const ChallengeSkillSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio * 3),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/images/test_lerning.png"))),
            SkillDetails(),
            TestType(),
            AvatarImgStack(),
            Assessors(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff68D5E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    onPressed: () {},
                    child: Text("Challenge Skill",style: TextStyle(fontSize: 17),),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
