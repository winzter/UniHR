import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/overview_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumOfCompany extends StatelessWidget {
  final OverviewBloc bloc;

  const NumOfCompany({super.key, required this.bloc});

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
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${AppLocalizations.of(context)!.partnercompany}",
                style: TextStyle(fontSize: 16, color: Color(0xff757575)),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  BlocBuilder<OverviewBloc, OverviewState>(
                    builder: (context, state) {
                      if (state.status == FetchStatus.success) {
                        return Text(
                          "10",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return Text(
                        "0",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
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
