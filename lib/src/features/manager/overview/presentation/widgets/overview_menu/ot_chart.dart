import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtChart extends StatelessWidget {
  final OverviewEntity? overviewData;
  final DateTime? date;
  const OtChart({super.key, required this.overviewData, this.date});

  @override
  Widget build(BuildContext context) {
    double sumOT = overviewData != null
        ? (overviewData!.otTotal!.the15!.payTotal! +
            overviewData!.otTotal!.the2!.payTotal! +
            overviewData!.otTotal!.the3!.payTotal!)
        : 0;

    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Center(
        child: Container(
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
          child: SfCircularChart(
              title: ChartTitle(
                  text: "${AppLocalizations.of(context)!.oTTotalByType}",
                  textStyle: TextStyle(color: Colors.white),
                  alignment: ChartAlignment.near),
              legend: Legend(
                  alignment: ChartAlignment.center,
                  isVisible: true,
                  isResponsive: true,
                  padding: 5,
                  itemPadding: 10,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(color: Colors.white, fontSize: 17)),
              tooltipBehavior:
                  TooltipBehavior(enable: true, textStyle: TextStyle()),
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                    widget: const PhysicalModel(
                        shape: BoxShape.circle,
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        child: SizedBox(
                          height: 140,
                          width: 140,
                        ))),
                CircularChartAnnotation(
                    widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${NumberFormat("#,###.##").format(sumOT)}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      date != null ? DateFormat("MMMM").format(date!) : '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff757575)),
                    ),
                  ],
                ))
              ],
              series: <CircularSeries>[
                PieSeries<ChartDataDeduction, String>(
                    dataSource: [
                      ChartDataDeduction('OT1', 0, const Color(0xffFFA25F)),
                      ChartDataDeduction(
                          'OT2',
                          overviewData?.otTotal!.the2!.payTotal ?? 0,
                          const Color(0xffA3FFE3)),
                      ChartDataDeduction(
                          'OT3',
                          overviewData?.otTotal!.the3!.payTotal ?? 0,
                          const Color(0xff6FC9E4)),
                      ChartDataDeduction(
                          'OT1.5',
                          overviewData?.otTotal!.the15!.payTotal ?? 0,
                          const Color(0xff5C468A))
                    ],
                    xValueMapper: (ChartDataDeduction data, _) => data.x,
                    yValueMapper: (ChartDataDeduction data, _) => data.y,
                    // cornerStyle: CornerStyle.bothCurve,
                    pointColorMapper: (ChartDataDeduction data, _) =>
                        data.color,
                    legendIconType: LegendIconType.circle,
                    pointRadiusMapper: (_, __) => "100",
                    radius: '105%')
              ]),
        ),
      ),
    );
  }
}

class ChartDataDeduction {
  ChartDataDeduction(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
