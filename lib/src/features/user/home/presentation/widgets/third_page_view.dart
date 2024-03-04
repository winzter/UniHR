import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/shift_ot/presentation/bloc/shift_ot_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../../payslip/presentation/provider/payslip_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThirdPageView extends StatefulWidget {
  const ThirdPageView({super.key});

  @override
  State<ThirdPageView> createState() => _ThirdPageViewState();
}

class _ThirdPageViewState extends State<ThirdPageView> {
  final ShiftOtBloc shiftOtBloc = sl<ShiftOtBloc>();
  final DateTime now = DateTime.now();

  void initState() {
    super.initState();
    if (DateTime.now().day >= 28) {
      shiftOtBloc.add(getShiftOT(
          start: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month + 1, 1)),
          end: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month + 2, 0))));
    } else {
      shiftOtBloc.add(getShiftOT(
          start:
          DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1)),
          end: DateFormat('yyyy-MM-dd')
              .format(DateTime(now.year, now.month + 1, 0))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final GetPayslipProvider payslipProvider =
    Provider.of<GetPayslipProvider>(context, listen: false);
    return BlocProvider(
      create: (context) => shiftOtBloc,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  //"จ. 18 เมษ 66",
                  DateFormat('EE dd MMM yy').format(DateTime.now()),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ShiftOtBloc, ShiftOtState>(
              builder: (context, state) {
                if (state is ShiftOtLoading) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.otandshift,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.loading,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ],
                          )
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${AppLocalizations.of(context)!.estimatedincomefor} ${now.day >= 28 ? DateFormat("MMM").format(
                                  DateTime(now.year, now.month + 1, now.day),
                                ) : DateFormat("MMM").format(
                                  DateTime(now.year, now.month, now.day),
                                )}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            Row(
                              children: [
                                Text(AppLocalizations.of(context)!.loading,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ],
                            )
                          ])
                    ],
                  );
                } else if (state is ShiftOtLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.otandshift,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          Row(
                            children: [
                              Text(
                                  NumberFormat("#,###.##")
                                      .format(state.sumOfShiftAndOt),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              Text(AppLocalizations.of(context)!.baht,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          )
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.estimatedincomefor} ${now.day >= 28 ? DateFormat("MMM").format(
                                DateTime(now.year, now.month + 1, now.day),
                              ) : DateFormat("MMM").format(
                                DateTime(now.year, now.month, now.day),
                              )}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(payslipProvider.previousPayslipData != null
                                    && payslipProvider.previousPayslipData!.isNotEmpty
                                    ? NumberFormat("#,###.##").format(
                                    payslipProvider
                                        .previousPayslipData![0]
                                        .addition![0]
                                        .value! +
                                        state.sumOfShiftAndOt)
                                    : "0",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                Text(AppLocalizations.of(context)!.baht,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              ],
                            )
                          ])
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.otandshift,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Row(
                          children: [
                            Text("0",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(AppLocalizations.of(context)!.baht,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                          ],
                        )
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "${AppLocalizations.of(context)!.estimatedincomefor} ${now.day >= 28 ? DateFormat("MMM").format(
                                DateTime(now.year, now.month + 1, now.day),
                              ) : DateFormat("MMM").format(
                                DateTime(now.year, now.month, now.day),
                              )}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          Row(
                            children: [
                              Text("0",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              Text(AppLocalizations.of(context)!.baht,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          )
                        ])
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}