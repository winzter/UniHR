import 'package:flutter/material.dart';

import 'complete_skill_card.dart';

class GridCompleteSkill extends StatelessWidget {
  const GridCompleteSkill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 250,
              maxCrossAxisExtent: MediaQuery.of(context).size.width*0.5,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemCount: 4,
          itemBuilder: (context, index) {
            return CompleteSkillCard();
          },
        ),
      ),
    );
  }
}
