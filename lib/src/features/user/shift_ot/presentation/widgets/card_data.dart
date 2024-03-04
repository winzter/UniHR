import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/shift_ot_entitiy.dart';
import '../provider/shift_ot_provider.dart';
import 'card_day_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardData extends StatefulWidget {
  final int index;
  final ShiftAndOtEntity data;

  const CardData({super.key, required this.index, required this.data});

  @override
  State<CardData> createState() => _CardDataState();
}

class _CardDataState extends State<CardData> {
  @override
  Widget build(BuildContext context) {
    final shiftOtProvider = Provider.of<GetShiftAndOTProvider>(context);
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
                height: 200,
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButton2(
                          isExpanded: true,
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          value: shiftOtProvider.monthValue,
                          underline: Container(),
                          items: shiftOtProvider.months
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
                            setState(() {
                              shiftOtProvider.monthValue = value!;
                              shiftOtProvider.setIndex(
                                  shiftOtProvider.months.indexOf(value));
                            });
                            shiftOtProvider.getSummaryTime();
                          }),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CardDayDetail(
                      sumOT: shiftOtProvider.sumOTOfMonth(),
                      sumShiftMorning: shiftOtProvider.sumShiftMorning(),
                      sumShiftNoon: shiftOtProvider.sumShiftNoon(),
                      sumShiftNight: shiftOtProvider.sumShiftNight(),
                      sumLoss: shiftOtProvider.sumLoss(),
                      key: ValueKey(widget.index),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
