import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:unihr/src/features/user/learning/presentation/pages/my_certificate_page/my_certificate_search_page.dart';
import 'package:unihr/src/features/user/learning/presentation/widgets/learning_app_bar.dart';

import 'certificate_detail.dart';

class MyCertificatePage extends StatelessWidget {
  const MyCertificatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLearning(context, "ใบประกาศของฉัน", () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCertificateSearchPage(),
            ));
      }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 150,
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemCount: 1,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  CertificateDetail(),));
              },
              child: badges.Badge(
                stackFit: StackFit.expand,
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.transparent),
                position: badges.BadgePosition.topStart(
                    start: MediaQuery.of(context).size.width * 1/100,
                    top: 0),
                badgeContent: Image.asset("assets/images/learning_user/my_cert.png",width: 35,),
                child: Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffEEEEEE),
                        border: Border.all(width: 10, color: Colors.white)),
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          "Building Hybrid Applications with Flutter",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          // overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
