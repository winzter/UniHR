import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../domain/entities/entities.dart';

class LeaveChart extends StatelessWidget {
  final List<LeaveAvailableEntity> leaveData;
  const LeaveChart({
    super.key,
    required this.leaveData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 120,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0),
        tooltipBehavior: TooltipBehavior(enable: false),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: const PhysicalModel(
                  shape: BoxShape.circle,
                  elevation: 0,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                  ))),
          CircularChartAnnotation(
              widget: Text(
            "${leaveData.isNotEmpty ? (leaveData[0].leaveUsed?.toStringAsFixed(2) ?? 999) : 999}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ))
        ],
        series: <CircularSeries>[
          RadialBarSeries<LeaveAvailableEntity, String>(
            dataSource: leaveData,
            enableTooltip: false,
            trackColor: const Color(0xffEAEDF2),
            maximumValue: leaveData[0].leaveValue == null
                ? 999
                : ((leaveData[0].carryValue ?? 0) +
                        (leaveData[0].leaveValue ?? 0))
                    .toDouble(),
            xValueMapper: (LeaveAvailableEntity data, _) => data.name,
            yValueMapper: (LeaveAvailableEntity data, _) => data.leaveUsed ?? 0,
            pointColorMapper: (_, __) => const Color(0xff6FC9E4),
            cornerStyle: CornerStyle.bothCurve,
            innerRadius: "70%",
            radius: "100%",
          ),
        ],
      ),
    );
  }
}
