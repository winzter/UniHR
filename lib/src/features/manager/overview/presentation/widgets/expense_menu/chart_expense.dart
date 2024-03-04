import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChartExpense extends StatelessWidget {
  final OverviewEntity? overviewData;
  final DateTime? date;
  const ChartExpense({super.key, required this.overviewData, this.date});

  @override
  Widget build(BuildContext context) {
    List<SalaryData> chartData = [];
    if (overviewData != null) {
      for (var i in overviewData!.salaryTotalAllYear!) {
        chartData.add(SalaryData(DateTime(i.year!, i.month!), i.salaryTotal!));
      }
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Center(
          child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.40),
                    Color.fromRGBO(255, 255, 255, 0.40),
                  ],
                  stops: [0.0, 1.0],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.13),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SfCartesianChart(
                  enableAxisAnimation: true,
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    header: "รายจ่ายงินเดือน",
                  ),
                  title: ChartTitle(
                      text: "${AppLocalizations.of(context)!.processingfee}",
                      textStyle: TextStyle(color: Colors.white)),
                  primaryXAxis: DateTimeAxis(
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      dateFormat: DateFormat("MMM")),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  series: <CartesianSeries>[
                    LineSeries<SalaryData, DateTime>(
                        color: Color(0xff6FC9E4),
                        markerSettings: MarkerSettings(
                            shape: DataMarkerType.circle, isVisible: true),
                        enableTooltip: true,
                        dataSource: chartData,
                        xValueMapper: (SalaryData sales, _) => sales.date,
                        yValueMapper: (SalaryData sales, _) => sales.sales)
                  ]))),
    );
  }
}

class SalaryData {
  SalaryData(this.date, this.sales);
  final DateTime date;
  final double sales;
}
