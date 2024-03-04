import 'package:flutter/material.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/learning_app_bar.dart';
import '../../widgets/learning_history_page/learning_history_widgets.dart';
import 'learning_history_search_page.dart';

class LearningHistoryPage extends StatelessWidget {
  const LearningHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "ประวัติการเรียนรู้", () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LearningHistorySearchPage(),));
      }),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).devicePixelRatio*10),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 290,
              maxCrossAxisExtent: MediaQuery.of(context).size.width*0.5,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemCount: 1,
          itemBuilder: (context, index) {
            return LearningHistoryCards();
          },
        ),
      ),
      // ListView.builder(
      //   physics: const BouncingScrollPhysics(),
      //   itemCount: 1,
      //   itemBuilder: (context, index) {
      //     return LearningHistoryCards();
      //   },
      // ),
    );
  }
}
