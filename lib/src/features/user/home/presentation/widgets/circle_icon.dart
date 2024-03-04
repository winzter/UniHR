import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';

class CircleIcons extends StatelessWidget {
  final List<String> imgs;
  final String title;
  final Widget? page;
  final bool isDisable;
  final int index;

  const CircleIcons(this.imgs, this.title,
      {super.key,
      required this.page,
      required this.index,
      required this.isDisable});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
              context,
              PageTransition(child: page!,
                type: title=="สลิปเงินเดือน"?PageTransitionType.bottomToTop :PageTransitionType.leftToRight,
          ));
        } else if(isDisable == false){
          navigationProvider.controller.jumpToPage(index);
          navigationProvider.setIndex(index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.015),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.75))
                ],
                color: isDisable
                    ? const Color(0xffc6c6c6)
                    : const Color(0xffFF7AAA),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                isDisable ? imgs[0] : imgs[1],
                width: MediaQuery.of(context).size.width * 0.04,
                height: MediaQuery.of(context).size.height * 0.05,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
            title,
            style: TextStyle(
                color: isDisable ? Colors.grey : const Color(0xffFFACCA)),
          )
        ],
      ),
    );
  }
}

class CircleIconsWIthNull extends StatelessWidget {
  final String title;
  final Widget? page;
  final bool isDisable;
  final int index;
  final IconData? icons;

  const CircleIconsWIthNull(
    this.title, {
    super.key,
    required this.page,
    required this.index,
    required this.isDisable,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
              context, PageTransition(type:PageTransitionType.leftToRight,child: page!));
        } else {
          navigationProvider.controller.jumpToPage(index);
          navigationProvider.setIndex(index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.015),
              decoration: BoxDecoration(
                color: icons == null?Colors.transparent:(isDisable?  const Color(0xffc6c6c6): const Color(0xffFF7AAA)),
                shape: BoxShape.circle,
                boxShadow: [
              if(icons != null)
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.75))
                ],
              ),
              child: Icon(
                icons,
                color: Colors.white,
                size: 42,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: isDisable ? Colors.grey : const Color(0xffFFACCA)),
          )
        ],
      ),
    );
  }
}
