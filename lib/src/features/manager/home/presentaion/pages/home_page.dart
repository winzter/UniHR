// import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../../../core/provider/bottom_navbar/language_page.dart';
import '../widgets/first_page_view.dart';
import '../widgets/menu_circle_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late ProfileProvider managerProfileProvider;

  void isLoading() async {
    managerProfileProvider = ProfileProvider.of(context, listen: false);
    managerProfileProvider.setIsLoading(true);
    managerProfileProvider.getProfileData(context);
    managerProfileProvider.setIsLoading(false);
  }

  @override
  void initState() {
    super.initState();
    isLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.22,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background_img.png"),
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.cover
        ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.9)
                      ])),
            ),
            Positioned(
                top: 50,
                right: 15,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return LanguageScreen();
                                }));
                          },
                          child: const Icon(Icons.g_translate,
                              color: Colors.white,size: 27)),
                      const SizedBox(width: 10,),
                      const Icon(Icons.notifications_active_outlined,color: Colors.white,size: 29,)
                    ],
                  ),
                )
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Image.asset(
            //       "assets/gifs/Unicorn-LV5.gif",
            //       width: 200,
            //       // height: 300,
            //     ),
            //   ],
            // ),
          ],
        ),
        title: Column(
          children: [
            Stack(
              children: [
                const FirstPageView(),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async=> isLoading(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: const MenuCircle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}