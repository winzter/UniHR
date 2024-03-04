import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unihr/src/features/user/leave/domain/entities/entities.dart';
import 'package:unihr/src/features/user/shift_ot/presentation/bloc/shift_ot_bloc.dart';
import '../../../../../core/features/login/presentation/pages/login_page.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../../../leave/presentaion/bloc/leave_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> alertErrorDialog(BuildContext context,String title) async{
  await QuickAlert.show(
      disableBackBtn: true,
      context: context,
      type: QuickAlertType.error,
      confirmBtnText: AppLocalizations.of(context)!.agree,
      title: AppLocalizations.of(context)!.error_data01,
      text: AppLocalizations.of(context)!.error_inter,
      confirmBtnColor: const Color(0xffE46A76),
      onConfirmBtnTap: () async {
        // await LoginStorage.deleteAll();
        // Navigator.pushReplacement(
        //   context,
        //   PageTransition(
        //       child: const LoginPage(),
        //       type: PageTransitionType.rightToLeft),
        // );
      });
  // await LoginStorage.deleteAll();
  // Navigator.pushReplacement(
  //   context,
  //   PageTransition(
  //       child: const LoginPage(),
  //       type: PageTransitionType.rightToLeft),
  // );
}

class ChartVacation extends StatefulWidget {
  final LeaveBloc bloc;

  const ChartVacation({super.key, required this.bloc});

  @override
  State<ChartVacation> createState() => _ChartVacationState();
}

class _ChartVacationState extends State<ChartVacation> {
  final List<Color> colors = [
    const Color(0xffFDC793),
    const Color(0xffE793B8),
    const Color(0xff6FC9E4),
  ];

  @override
  void initState() {
    super.initState();
    // widget.bloc.add(GetAllLeaveData());
  }

  final List<double> stops = [0.2, 0.5, 0.8];

  Float64List _resolveTransform(Rect bounds, TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }

  // Convert degree to radian
  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveBloc, LeaveState>(
      listener: (context,state){
        // if(state.status == FetchStatus.failed){
        //   alertErrorDialog(context,state.error?.errMsgText??"เกิดข้อผิดพลาด กรุณาติดต่อแอดมิน");
        // }
      },
      builder: (context, state) {
        if (state is LeaveInitial) {
          return SizedBox(
            width: 230, //230
            height: 210,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.fetchingdata,
                style: TextStyle(),
              ),
            ),
          );
        }
        else if (state.status == FetchStatus.fetching) {
          return SizedBox(
            width: 230, //230
            height: 210,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.loading,
              ),
            ),
          );
        }
        else if (state.status == FetchStatus.success) {
          LeaveAvailableEntity? leaveAuthData;
          try {
            leaveAuthData = state.leaveAvailableData.firstWhere(
              (element) => element.isLeaveAnnual == 1,
            );
          } catch (e) {
            leaveAuthData = null;
          }
          double leaveValue = (leaveAuthData?.leaveValue ?? 0).toDouble();
          double carryRemainValue = (leaveAuthData?.carryRemain ?? 0).toDouble();
          double carryValue = (leaveAuthData?.carryValue ?? 0).toDouble();
          double usedValue = (leaveAuthData?.leaveUsed ?? 0).toDouble();
          return SizedBox(
            width: 230, //230
            height: 210, //210
            child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    textStyle: TextStyle()),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(usedValue > (leaveValue + carryValue) ? leaveValue + carryValue : usedValue).toStringAsFixed(2)}/${leaveValue + carryValue}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(AppLocalizations.of(context)!.vacationRights,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff757575)))
                    ],
                  ))
                ],
                onCreateShader: (ChartShaderDetails chartShaderDetails) {
                  return ui.Gradient.sweep(
                      chartShaderDetails.outerRect.center,
                      colors,
                      stops,
                      TileMode.clamp,
                      _degreeToRadian(0),
                      _degreeToRadian(360),
                      _resolveTransform(
                          chartShaderDetails.outerRect, TextDirection.ltr));
                },
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                      maximumValue: (leaveValue + carryValue).toDouble(),
                      trackBorderWidth: 30,
                      innerRadius: "69%",
                      dataSource: [
                        ChartData(
                            AppLocalizations.of(context)!.numberofvacation,
                            ((usedValue > (leaveValue + carryValue + carryRemainValue + carryRemainValue)
                                ? leaveValue + carryValue + carryRemainValue
                                : usedValue)))
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      trackColor: Colors.white,
                      legendIconType: LegendIconType.circle,
                      radius: '142%')
                ]),
          );
        }
        else if (state.status == FetchStatus.failed) {
          return SizedBox(
            width: 230, //230
            height: 210, //210
            child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    textStyle: TextStyle()),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: Text(
                    AppLocalizations.of(context)!.error01,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ))
                ],
                onCreateShader: (ChartShaderDetails chartShaderDetails) {
                  return ui.Gradient.sweep(
                      chartShaderDetails.outerRect.center,
                      colors,
                      stops,
                      TileMode.clamp,
                      _degreeToRadian(0),
                      _degreeToRadian(360),
                      _resolveTransform(
                          chartShaderDetails.outerRect, TextDirection.ltr));
                },
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                      maximumValue: 0,
                      trackBorderWidth: 30,
                      innerRadius: "69%",
                      dataSource: [ChartData("เกิดข้อผิดพลาด", 0)],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      trackColor: Colors.white,
                      legendIconType: LegendIconType.circle,
                      radius: '142%')
                ]),
          );
        }
        return SizedBox(
            width: 230, //230
            height: 210,
            child: Center(
                child: Text(
              AppLocalizations.of(context)!.noinformation,
              style: TextStyle(),
            )));
      },
    );
  }
}
/*-------------------------------------------------*/

/* Deduction Chart */
class ChartDeduction extends StatefulWidget {
  final ShiftOtBloc bloc;

  const ChartDeduction({super.key, required this.bloc});

  @override
  State<ChartDeduction> createState() => _ChartDeductionState();
}

class _ChartDeductionState extends State<ChartDeduction> {
  final DateTime now = DateTime.now();

  void initState() {
    super.initState();
    // if (now.day >= 28) {
    //   widget.bloc.add(getShiftOT(
    //       start: date_time.DateFormat('yyyy-MM-dd')
    //           .format(DateTime(now.year, now.month + 1, 1)), end: date_time.DateFormat('yyyy-MM-dd')
    //       .format(DateTime(now.year, now.month + 1, 0))));
    // } else {
    //   widget.bloc.add(getShiftOT(
    //       start: date_time.DateFormat('yyyy-MM-dd')
    //           .format(DateTime(now.year, now.month, 1)), end: date_time.DateFormat('yyyy-MM-dd')
    //       .format(DateTime(now.year, now.month + 1, 0))));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShiftOtBloc, ShiftOtState>(
      listener: (context,state){
        // if(state is ShiftOtFailure){
        //   alertErrorDialog(context,state.error.errMsgText??"กรุณาติดต่อแอดมิน");
        // }
      },
      builder: (context, state) {
        if (state is ShiftOtInitial) {
          return SizedBox(
            width: 220, //230
            height: 200,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.fetchingdata,
                style: TextStyle(),
              ),
            ),
          );
        }
        else if (state is ShiftOtLoading) {
          return SizedBox(
            width: 220, //230
            height: 200,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.loading,
              ),
            ),
          );
        }
        else if (state is ShiftOtLoaded) {
          return SizedBox(
            width: 220,
            height: 200,
            child: SfCircularChart(
                legend: Legend(
                    alignment: ChartAlignment.center,
                    isVisible: true,
                    isResponsive: true,
                    padding: 5,
                    itemPadding: 6,
                    position: LegendPosition.bottom,
                    textStyle: TextStyle()),
                tooltipBehavior: TooltipBehavior(enable: true),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${state.data.dock!.absent!.amount! + state.data.dock!.lateEarly!.amount!} ${AppLocalizations.of(context)!.b}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        AppLocalizations.of(context)!.deduction,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff757575)),
                      ),
                    ],
                  ))
                ],
                series: <CircularSeries>[
                  DoughnutSeries<ChartDataDeduction, String>(
                      innerRadius: "75%",
                      dataSource: [
                        ChartDataDeduction(
                            AppLocalizations.of(context)!.late,
                            state.data.dock!.lateEarly!.amount!.toDouble(),
                            const Color(0xffFDC793)),
                        ChartDataDeduction(
                            AppLocalizations.of(context)!.leaveEarly,
                            state.data.dock!.lateEarly!.amount!.toDouble(),
                            const Color(0xff5C468A)),
                        ChartDataDeduction(
                            AppLocalizations.of(context)!.absent,
                            state.data.dock!.absent!.amount!.toDouble(),
                            const Color(0xff6FC9E4))
                      ],
                      xValueMapper: (ChartDataDeduction data, _) => data.x,
                      yValueMapper: (ChartDataDeduction data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      pointColorMapper: (ChartDataDeduction data, _) =>
                          data.color,
                      legendIconType: LegendIconType.circle,
                      radius: '105%')
                ]),
          );
        }
        else if(state is ShiftOtFailure){
          return SizedBox(
            width: 230, //230
            height: 210, //210
            child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    textStyle: TextStyle()),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: const PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ))),
                  CircularChartAnnotation(
                      widget: Text(
                        AppLocalizations.of(context)!.error01,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ))
                ],
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                      maximumValue: 0,
                      trackBorderWidth: 30,
                      innerRadius: "69%",
                      dataSource: [ChartData("เกิดข้อผิดพลาด", 0)],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      cornerStyle: CornerStyle.bothCurve,
                      trackColor: Colors.white,
                      legendIconType: LegendIconType.circle,
                      radius: '142%')
                ]),
          );
        }
        return SizedBox(
            width: 220,
            height: 200,
            child: Center(
                child: Text(
              AppLocalizations.of(context)!.noinformation,
            )));
      },
    );
  }
}
/*-------------------------------------------------*/

/*-------------------------------------------------*/
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartDataDeduction {
  ChartDataDeduction(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
