import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/payslip.dart';

class ExpenseList extends StatefulWidget {
  final PayslipEntity data;
  const ExpenseList({super.key, required this.data});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.data.addition!.length + widget.data.deduction!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (index < widget.data.addition!.length) ...[
                    Text(
                      "${widget.data.addition![index].name}",
                      style: TextStyle(
                          color: const Color(0xff3D6670), fontSize: 16),
                    ),
                    Text(
                      NumberFormat("#,###.##")
                          .format(widget.data.addition![index].value),
                      style: TextStyle(
                          color: const Color(0xff30B98F), fontSize: 16),
                    )
                  ] else ...[
                    Text(
                      "${widget.data.deduction![index - widget.data.addition!.length].name}",
                      style: TextStyle(
                          color: const Color(0xff3D6670), fontSize: 16),
                    ),
                    Text(
                      "-${NumberFormat("#,###.##").format(widget.data.deduction![index - widget.data.addition!.length].value)}",
                      style: TextStyle(
                          color: const Color(0xffFF6575), fontSize: 16),
                    )
                  ]
                ],
              ),
              const Divider()
            ],
          );
        });
  }
}
