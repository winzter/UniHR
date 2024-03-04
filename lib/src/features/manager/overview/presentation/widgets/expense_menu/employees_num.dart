import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unihr/src/features/manager/overview/presentation/bloc/overview_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeesNum extends StatelessWidget {
  final OverviewBloc bloc;

  const EmployeesNum({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 5,
          vertical: MediaQuery.of(context).devicePixelRatio * 4.5),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.emptotal,
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
                      return Text(
                        "${state.overtimeData?.employeeTotal ?? 0}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  Text(
                    " ${AppLocalizations.of(context)!.person}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SvgPicture.asset("assets/icons/overview_manager/employees.svg")
            ],
          ),
        ],
      ),
    );
  }
}
