import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/shift_ot_provider.dart';

class DropdownYear extends StatefulWidget {
  const DropdownYear({super.key});
  @override
  State<DropdownYear> createState() => _DropdownYearState();
}

class _DropdownYearState extends State<DropdownYear> {

  @override
  Widget build(BuildContext context) {
    final shiftOTProvider = Provider.of<GetShiftAndOTProvider>(context);
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).devicePixelRatio*5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff5C468A)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 250,
                      decoration: BoxDecoration(
                        color: const Color(0xff5C468A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    isExpanded: true,
                    value: shiftOTProvider.value,
                    alignment: Alignment.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    items: shiftOTProvider.years.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            value,
                            style: TextStyle(fontFamily: 'kanit'),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? item) {
                      shiftOTProvider.setYear(item!);
                      shiftOTProvider.getSummaryTime();
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
