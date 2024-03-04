import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../bloc/overview_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtMoreThan36 extends StatelessWidget {
  final OverviewBloc bloc;

  const OtMoreThan36({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 5,
          vertical: MediaQuery.of(context).devicePixelRatio * 5.6),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFF364B),
                Color(0xffFF364B).withOpacity(0.5),
              ])),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.oTOVer36Hr}",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("assets/icons/overview_manager/alert.svg"),
              Row(
                children: [
                  BlocBuilder<OverviewBloc, OverviewState>(
                    builder: (context, state) {
                      if (state.status == FetchStatus.success) {
                        return Text(
                          state.overviewData == null
                              ? "0"
                              : "${state.overviewData?.employeeOtOver36Total!.weekInMonth!.fold(
                                  0,
                                  (value, element) =>
                                      value + element.over36HoursEmployeeTotal!,
                                )}",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        );
                      }
                      return Text(
                        "0",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    },
                  ),
                  Text(
                    " ${AppLocalizations.of(context)!.person}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
