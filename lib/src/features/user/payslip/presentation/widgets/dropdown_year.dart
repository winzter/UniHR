import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/payslip_provider.dart';

class DropdownYear extends StatefulWidget {
  const DropdownYear({super.key});

  @override
  State<DropdownYear> createState() => _DropdownYearState();
}

class _DropdownYearState extends State<DropdownYear> {
  late GetPayslipProvider payslipProvider;

  @override
  void initState() {
    super.initState();
    payslipProvider = GetPayslipProvider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final dataYear = context.watch<GetPayslipProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff5C468A)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                  isExpanded: true,
                  value: dataYear.year,
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xff5C468A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  alignment: Alignment.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  items: dataYear.years.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          value,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? item) {
                    dataYear.setYear(item!);
                    dataYear.getPayslipData();
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
