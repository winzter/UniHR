import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/shift_ot_entitiy.dart';
import '../../domain/use_cases/get_shift_ot.dart';

class GetShiftAndOTProvider extends ChangeNotifier {
  final GetShiftAndOT getSummaryShiftAndOt;
  final List<String> _years = List.generate(
      10,
      (index) => DateFormat("yyyy")
          .format(DateTime(DateTime.now().year + 543 - index)));
  static final List<String> _months = List.generate(12, (index) {
    return DateFormat('MMMM').format(DateTime(2023, index + 1, 1));
  });
  ShiftAndOtEntity shiftOTData = ShiftAndOtEntity();

  int _currentPageIndex =
      _months.indexOf(DateFormat('MMMM').format(DateTime.now()));
  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime(DateTime.now().year + 543));
  late String monthValue = months[currentPageIndex];
  String value = "2566";
  late int yearNum;

  GetShiftAndOTProvider({required this.getSummaryShiftAndOt});
  List<String> get months => _months;
  String get month => _month;
  List<String> get years => _years;
  String get year => _year;
  int get currentPageIndex => _currentPageIndex;

  void setMonth(int index) {
    monthValue = months[index];
    notifyListeners();
  }

  void setIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void setYear(String year) {
    _year = year;
    value = year;
    notifyListeners();
  }

  double sumOTOfMonth() {
    double sumMonthOT = 0;
    if (shiftOTData.dataTable != null) {
      for (var data in shiftOTData.dataTable!) {
        if (data.otThreeAmount == null ||
            data.otTwoAmount == null ||
            data.otOneAmount == null) {
          return sumMonthOT;
        }
        sumMonthOT += data.otThreeAmount! +
            data.otTwoAmount! +
            data.otOneFiveAmount! +
            data.otOneAmount!;
      }
    }

    return sumMonthOT;
  }

  double sumShiftMorning() {
    double sumShiftMorning = 0;
    if (shiftOTData.dataTable != null) {
      for (var data in shiftOTData.dataTable!) {
        if (data.shiftPayMorning == null) {
          return sumShiftMorning;
        }
        sumShiftMorning += data.shiftPayMorning!;
      }
    }

    return sumShiftMorning;
  }

  double sumShiftNoon() {
    double sumShiftNoon = 0;
    if (shiftOTData.dataTable != null) {
      for (var data in shiftOTData.dataTable!) {
        if (data.shiftPayAfternoon == null) {
          return sumShiftNoon;
        }
        sumShiftNoon += data.shiftPayAfternoon!;
      }
    }

    return sumShiftNoon;
  }

  double sumShiftNight() {
    double sumShiftNight = 0;
    if (shiftOTData.dataTable != null) {
      for (var data in shiftOTData.dataTable!) {
        if (data.shiftPayNight == null) {
          return sumShiftNight;
        }
        sumShiftNight += data.shiftPayNight!;
      }
    }

    return sumShiftNight;
  }

  double sumLoss() {
    double sumLoss = 0;
    if (shiftOTData.dock != null) {
      sumLoss = (shiftOTData.dock!.lateEarly!.amount! +
              shiftOTData.dock!.absent!.amount!)
          .toDouble();
      return sumLoss;
    }
    return sumLoss;
  }

  Future<void> getSummaryTime() async {
    try {
      var data = await getSummaryShiftAndOt(
          DateFormat(
            'yyyy-MM-dd',
          ).format(DateTime(int.parse(value) - 543,
              months.indexOf(months[currentPageIndex]) + 1, 1)),
          DateFormat('yyyy-MM-dd').format(DateTime(int.parse(value) - 543,
              months.indexOf(months[currentPageIndex]) + 2, 0)));
      shiftOTData = data.foldRight(shiftOTData, (r, previous) => r);
      notifyListeners();
    } catch (error) {
      log(error.toString());
      notifyListeners();
    }
  }

  static GetShiftAndOTProvider of(BuildContext context, {listen = true}) =>
      Provider.of<GetShiftAndOTProvider>(context, listen: listen);
}
