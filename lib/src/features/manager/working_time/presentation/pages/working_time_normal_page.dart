import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'individual_detail/individual_detail.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkingTimeNormalPage extends StatefulWidget {
  const WorkingTimeNormalPage({super.key});

  @override
  State<WorkingTimeNormalPage> createState() => _WorkingTimeNormalPageState();
}

class _WorkingTimeNormalPageState extends State<WorkingTimeNormalPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          indicatorPadding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          indicatorColor: Colors.deepPurple,
          unselectedLabelColor: const Color(0xffC4C4C4),
          tabs: [
            Text(
              "${AppLocalizations.of(context)!.dailyinformation}",
              style:
                  GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "${AppLocalizations.of(context)!.personalinformation}",
              style:
                  GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Expanded(
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
