import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../../item_status/presentation/pages/item_status_page.dart';
import 'menu_tabbar/request_wating.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitingStatus extends StatefulWidget {
  const WaitingStatus({super.key});

  @override
  State<WaitingStatus> createState() => _WaitingStatusState();
}

class _WaitingStatusState extends State<WaitingStatus>
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

  Widget tabs(int index, String title, String svgPath) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        decoration: BoxDecoration(
            gradient: _tabController.index == index
                ? const LinearGradient(colors: [
                    Color(0xffE793B8),
                    Color(0xff6FC9E4),
                  ])
                : const LinearGradient(
                    colors: [Colors.transparent, Colors.transparent]),
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
            ),
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
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).devicePixelRatio * 7.5,
          right: MediaQuery.of(context).devicePixelRatio * 7.5,
          bottom: MediaQuery.of(context).devicePixelRatio * 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).devicePixelRatio * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/question.svg",
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.015),
                        Text(
                          AppLocalizations.of(context)!.acceptlist,
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!profile.isLoading) {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const ItemStatusPage()));
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.viewHistory,
                      style: TextStyle(
                          color: const Color(0xffE793B8), fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Expanded(
              child: DateTimeWorkingWaiting(),
            ),
          ],
        ),
      ),
    );
  }
}
