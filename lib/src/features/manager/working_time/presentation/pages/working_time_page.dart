import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'individual_detail/individual_detail.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkingTimePage extends StatefulWidget {
  const WorkingTimePage({super.key});

  @override
  State<WorkingTimePage> createState() => _WorkingTimePageState();
}

class _WorkingTimePageState extends State<WorkingTimePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<bool> onBackPress() async {
    final NavIndex navigationProvider =
        Provider.of<NavIndex>(context, listen: false);
    navigationProvider.controller.jumpToPage(0);
    navigationProvider.setIndex(0);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: DefaultTabController(
        length: 3,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 100,
                child: AppBar(
                  elevation: 0,
                  toolbarHeight: 80,
                  flexibleSpace: Stack(children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background_img.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.5)
                          ])),
                    ),
                  ]),
                  title: TabBar(
                    controller: tabController,
                    onTap: (value) {
                      setState(() {
                        tabController.index = value;
                      });
                    },
                    indicatorWeight: 5,
                    labelPadding: const EdgeInsets.all(0),
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff5B4589), Color(0xffE793B8)])),
                    indicatorPadding:
                        const EdgeInsets.only(top: 25, left: 25, right: 25),
                    indicatorColor: Colors.deepPurple,
                    unselectedLabelColor: const Color(0xffC4C4C4),
                    tabs: [
                      Text(
                        "${AppLocalizations.of(context)!.dailyinformation}",
                        style: GoogleFonts.kanit(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.personalinformation}",
                        style: GoogleFonts.kanit(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  EmployeeStatusTabBar(),
                  IndividualDetail(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
