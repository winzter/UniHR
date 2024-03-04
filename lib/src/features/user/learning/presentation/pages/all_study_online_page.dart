import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import '../widgets/all_study_online_page/study_online_card.dart';
import '../widgets/learning_app_bar.dart';


class AllStudyOnlinePage extends StatelessWidget {
  const AllStudyOnlinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "เรียนออนไลน์",null),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DefaultTabController(
          length: 1,
          child: Column(
            children: [
              ButtonsTabBar(
                  radius: 12,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF6FC9E4),
                        Color(0xFFE793B8),
                      ],
                    ),
                  ),
                  tabs: [
                Tab(child: Text("Programming 1",style: TextStyle(color: Colors.white),),),
                // Tab(child: Text("Programming 2",style: TextStyle(color: Colors.white),),),
              ]),
              Expanded(child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return StudyOnlineCard();
                    },
                  ),
                  // ListView.builder(
                  //   physics: const BouncingScrollPhysics(),
                  //   itemCount: 5,
                  //   itemBuilder: (context, index) {
                  //     return StudyOnlineCard();
                  //   },
                  // ),
                ],
              ))
            ],
          ),

        ),
      )
    );
  }
}
