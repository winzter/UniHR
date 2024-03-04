import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/payslip_provider.dart';
import 'widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardList extends StatefulWidget {
  final int index;
  const CardList({super.key, required this.index});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    final GetPayslipProvider data = context.watch<GetPayslipProvider>();
    bool isAvailable = data.payslipData != null && data.payslipData!.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xff5C468A),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                height: 160,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: DropdownButton2(
                                isExpanded: true,
                                value: data.month,
                                underline: Container(),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                items: data.months
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: const Color(0xffE793B8),
                                            fontWeight: FontWeight.w500),
                                      ));
                                }).toList(),
                                onChanged: (String? value) {
                                  data.setMonth(value!);
                                  data.setIndex(data.month.indexOf(value));
                                  data.getPayslipData();
                                }),
                          ),
                        ),
                        // isAvailable
                        //     ? Text(
                        //         DateFormat("1 MMM - dd MMM yyyy").format(
                        //             DateTime(
                        //                 int.parse(data.year) - 543,
                        //                 data.months.indexOf(data.month) + 2,
                        //                 0)),
                        //         style:
                        //             TextStyle(color: const Color(0xff94AFB6)),
                        //       )
                        //     : Text(
                        //         AppLocalizations.of(context)!.noinformation,
                        //         style:
                        //             TextStyle(color: const Color(0xff94AFB6)),
                        //       )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    isAvailable
                        ? PayslipDetail(
                            data: data.payslipData![0],
                            key: ValueKey(widget.index),
                          )
                        : Container()
                  ],
                ),
              ),
              ExpansionTile(
                onExpansionChanged: (value) {},
                title: Text(
                  AppLocalizations.of(context)!.showall,
                  style: TextStyle(color: const Color(0xffC4C4C4)),
                  textAlign: TextAlign.center,
                ),
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide.none),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("1 MMM - dd MMM yyyy").format(DateTime(
                                  int.parse(data.year) - 543,
                                  data.months.indexOf(data.month) + 2,
                                  0)),
                              style: TextStyle(
                                  color: const Color(0xff94AFB6), fontSize: 15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xff41BE06),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                isAvailable
                                    ? "+฿${NumberFormat("#,###.##").format(data.payslipData![0].totalEarnings! - data.payslipData![0].totalDeductions!)}"
                                    : "฿ 0",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isAvailable
                            ? ExpenseList(data: data.payslipData![0])
                            : Text(
                                AppLocalizations.of(context)!.noinformation,
                                style: TextStyle(),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
