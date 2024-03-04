import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../widgets/succes_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EndPage extends StatelessWidget {
  final bool isError;
  final DateTime date;
  final List<Placemark> address;
  final bool isCheck;
  final String? note;

  const EndPage({
    super.key,
    required this.date,
    required this.isError,
    required this.address,
    required this.isCheck,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            elevation: 0,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                        Color(0xff6FC9E4),
                        Color(0xffE793B8),
                      ])),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.3)
                      ])),
                ),
              ],
            ),
            centerTitle: true,
            title: Text(
              '${AppLocalizations.of(context)!.workRecord}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xff6FC9E4), Color(0xffE793B8)])),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.4)
                  ])),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).devicePixelRatio * 10,
                        horizontal: MediaQuery.of(context).devicePixelRatio * 5,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).devicePixelRatio * 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Column(
                          children: [
                            isError
                                ? Icon(
                                    Icons.dangerous_outlined,
                                    color: Color(0xFFF15E5E),
                                    size: 100,
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .devicePixelRatio *
                                            5),
                                    child: SvgPicture.asset(
                                      "assets/icons/success.svg",
                                      width: 100,
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).devicePixelRatio *
                                      5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isError
                                        ? "${AppLocalizations.of(context)!.error01}"
                                        : "${AppLocalizations.of(context)!.savedsuccessfully}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context)
                                            .devicePixelRatio *
                                        10),
                                child: isError
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.pleastryagain}",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          DetailSuccess(
                                            title:
                                                '${AppLocalizations.of(context)!.successfully}',
                                            detail:
                                                "${address.reversed.last.name ?? ''} ${address.reversed.last.street ?? ''} "
                                                "${address.reversed.last.subLocality ?? ''} "
                                                "${address.reversed.last.locality ?? ''} ${address.reversed.last.postalCode ?? ''} "
                                                "${address.reversed.last.country ?? ''}",
                                            isEnd: false,
                                          ),
                                          DetailSuccess(
                                            title:
                                                '${AppLocalizations.of(context)!.date} ',
                                            detail: DateFormat("dd/MM/yy")
                                                .format(date),
                                            isEnd: false,
                                          ),
                                          DetailSuccess(
                                            title:
                                                '${AppLocalizations.of(context)!.time}',
                                            detail: DateFormat("HH:mm")
                                                .format(date),
                                            isEnd: note != null ? false : true,
                                          ),
                                          if (note != null)
                                            DetailSuccess(
                                              title:
                                                  '${AppLocalizations.of(context)!.note}',
                                              detail: note!,
                                              isEnd: true,
                                            ),
                                        ],
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 5),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    elevation: 5,
                    backgroundColor: const Color(0xffE793B8)),
                onPressed: () async {
                  int count = 0;
                  if (isCheck) {
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  } else {
                    Navigator.of(context).popUntil((_) => count++ >= 4);
                  }
                },
                child: Text(
                  isError
                      ? "${AppLocalizations.of(context)!.back}"
                      : "${AppLocalizations.of(context)!.successfully}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat),
    );
  }
}
