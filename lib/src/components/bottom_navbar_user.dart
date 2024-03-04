import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import '../features/user/edit_profile/presentation/pages/edit_profile_page.dart';
import '../features/user/gps/presentation/pages/gps_location_page.dart';
import '../features/user/home/presentation/pages/home_page.dart';
import '../features/user/leave/presentaion/pages/leave_page.dart';
import '../features/user/timeline/presentation/pages/timeline_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  List<Widget> pages = [
    HomePage(),
    TimeLinePage(),
    GpsLocationPage(),
    LeavePage(),
    EditProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true, //Bug
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationProvider.controller,
        onPageChanged: (index) {
          navigationProvider.setIndex(index);
        },
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xffE793B8),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedIconTheme: const IconThemeData(
                color: Color(0xffE793B8),
              ),
              onTap: (index) {
                navigationProvider.controller.jumpToPage(index);
                navigationProvider.setIndex(index);
              },
              currentIndex: navigationProvider.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      navigationProvider.currentIndex == 0
                          ? const Color(0xffE793B8)
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/home.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      navigationProvider.currentIndex == 1
                          ? const Color(0xffE793B8)
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.timetable,
                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  label: AppLocalizations.of(context)!.time_stamp,
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      navigationProvider.currentIndex == 3
                          ? const Color(0xffE793B8)
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/leave_menu.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.leave,
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      navigationProvider.currentIndex == 4
                          ? const Color(0xffE793B8)
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/profile.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: 'navbar',
            hoverElevation: 10,
            splashColor: Colors.grey,
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [
                    Color(0xffE793B8),
                    Color(0xff5B4589),
                  ],
                  center: Alignment(-1.0, -1.0),
                  focal: Alignment(-1.0, -1.0),
                  radius: 1.5,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            onPressed: () => setState(() {
              navigationProvider.controller.jumpToPage(2);
              navigationProvider.setIndex(2);
            }),
          ),
        ),
      ),
    ));
  }
}
