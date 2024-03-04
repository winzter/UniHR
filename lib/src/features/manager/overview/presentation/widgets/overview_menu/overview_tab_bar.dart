import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewTabBar extends StatefulWidget {
  const OverviewTabBar({super.key});

  @override
  State<OverviewTabBar> createState() => _OverviewTabBarState();
}

class _OverviewTabBarState extends State<OverviewTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget tabs(int index, String title, Color color) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        decoration: BoxDecoration(
            color: _tabController.index == index ? color : Color(0xff757575),
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.015),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.40),
              Color.fromRGBO(255, 255, 255, 0.40),
            ],
            stops: [0.0, 1.0],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13),
              offset: Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    indicator: const BoxDecoration(),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      tabs(0, "${AppLocalizations.of(context)!.employeeIn}",
                          Color(0xff6ADFBB)),
                      tabs(1, "${AppLocalizations.of(context)!.employeeOut}",
                          Color(0xffFFA3CB)),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _tabController.index == 0
                        ? Text(
                            "${AppLocalizations.of(context)!.employeeIn} 0 ${AppLocalizations.of(context)!.person}",
                            style: TextStyle(color: Colors.white, fontSize: 15))
                        : Text(
                            "${AppLocalizations.of(context)!.employeeOut} 0 ${AppLocalizations.of(context)!.person}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${AppLocalizations.of(context)!.noEmployeeIn}",
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${AppLocalizations.of(context)!.noEmployeeOut}",
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
