import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/loading_page/loading_page.dart';
import '../../../../../core/provider/bottom_navbar/bottom_navbar_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CircleIcons extends StatefulWidget {
  final List<String> imgs;
  final String title;
  final Widget? page;
  final bool isDisable;
  final int index;
  final bool isLogOut;

  const CircleIcons(this.imgs, this.title,
      {super.key,
      required this.page,
      required this.index,
      required this.isDisable,
      required this.isLogOut});

  @override
  State<CircleIcons> createState() => _CircleIconsState();
}

class _CircleIconsState extends State<CircleIcons> {
  performLogout(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context, listen: false);
    navigationProvider.setIndex(0);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoadingPage(
                  isLogIn: false,
                )));
  }

  Future<bool> onLogOut() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(5), // Adjust the radius as needed
            ),
            title: Center(
                child: Column(
              children: [
                Icon(
                  Icons.logout,
                  color: Color(0xFFF15E5E),
                  size: 60,
                ),
                Text(
                  '${AppLocalizations.of(context)!.logout}',
                  style: TextStyle(color: const Color(0xff75838F)),
                ),
              ],
            )),
            content: Text(
              '${AppLocalizations.of(context)!.wantlogout}',
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('${AppLocalizations.of(context)!.cancel}',
                        style: TextStyle(color: const Color(0xffA5AFBA))),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFF15E5E)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius here
                          ),
                        )),
                    child: Text('${AppLocalizations.of(context)!.confirm}',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => performLogout(context),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavIndex>(context);
    return GestureDetector(
      onTap: () {
        if (widget.page != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget.page!));
        } else {
          navigationProvider.controller.jumpToPage(widget.index);
          navigationProvider.setIndex(widget.index);
        }
        if (widget.isLogOut) {
          onLogOut();
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
                color: widget.isDisable
                    ? const Color(0xffc6c6c6)
                    : const Color(0xffFF7AAA),
                shape: BoxShape.circle,
              ),
              child: widget.isLogOut
                  ? Icon(
                      Icons.login_outlined,
                      size: MediaQuery.of(context).size.width * 0.1,
                      color: Colors.white,
                    )
                  : SvgPicture.asset(
                      widget.isDisable ? widget.imgs[0] : widget.imgs[1],
                      width: MediaQuery.of(context).size.width * 0.04,
                      height: MediaQuery.of(context).size.height * 0.05,
                    )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
            widget.title,
            style: GoogleFonts.kanit(
                color:
                    widget.isDisable ? Colors.grey : const Color(0xffFFACCA)),
          )
        ],
      ),
    );
  }
}
