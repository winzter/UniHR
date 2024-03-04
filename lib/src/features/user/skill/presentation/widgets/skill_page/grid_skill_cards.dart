import 'package:flutter/material.dart';

import 'skill_cards.dart';
class GridSkillCards extends StatelessWidget {
  const GridSkillCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 270,
              maxCrossAxisExtent: MediaQuery.of(context).size.width*0.5,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemCount: 4,
          itemBuilder: (context, index) {
            return SkillCards();
          },
        ),
      ),
    );
  }
}
