import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../../core/error/exception.dart';
import '../../domain/entities/payslip.dart';
import '../../domain/usecases/get_payslip.dart';

class GetPayslipProvider extends ChangeNotifier {
  final Logger logger = Logger();
  final GetPayslip getPayslip;
  final List<String> _years = List.generate(10, (index) => DateFormat("yyyy").format(DateTime(DateTime.now().year - index)));
  static final List<String> _months = List.generate(12, (index) {
    return DateFormat('MMMM').format(DateTime(DateTime.now().year, index + 1, 1));
  });
  List<PayslipEntity>? payslipData;
  List<PayslipEntity>? previousPayslipData;
  TionEntity _deductionSSO = const TionEntity();
  TionEntity _deductionPF = const TionEntity();
  int _currentPageIndex = int.parse(DateFormat('MM').format(DateTime.now()));
  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime(DateTime.now().year));

  GetPayslipProvider({required this.getPayslip});
  List<String> get months => _months;
  TionEntity get deductionSSO => _deductionSSO;
  TionEntity get deductionPF => _deductionPF;
  String get month => _month;
  List<String> get years => _years;
  String get year => _year;
  int get currentPageIndex => _currentPageIndex;

  void setMonth(String month) {
    _month = month;
    notifyListeners();
  }

  void setIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void setYear(String year) {
    _year = year;
    notifyListeners();
  }

  Future<void> getPayslipData() async {
    try {
      payslipData = null;
      var data = await getPayslip(month: _month, year: _year);
      payslipData = data.foldRight(payslipData, (r, previous) => r);
      setDeductionValue();
      notifyListeners();
    } catch (error) {
      if(error is ClientException){
        logger.e("No internet connection");
      }
      else if(error is TypeError){
        logger.e("แปลงข้อมูลจาก API ผิดพลาด : ${error}");
        logger.w("แก้ที่ Entity และ Model ของ Feature นั้น");
      }
      else if(error is ErrorException){
        logger.e("ไม่สามารถเชื่อมต่อกับ Server ได้");
      }
      notifyListeners();
    }
  }

  Future<void> getPreviousPayslipData(BuildContext context) async {
    try {
      // int indexMonth = _months.indexOf(_month);
      previousPayslipData = null;
      var data = await getPayslip(
          month: DateFormat("MMMM").format(DateTime.now().subtract(Duration(days: DateTime.now().day))),
          year: _months.indexOf(_month) == 0
              ? (int.parse(_year) - 1).toString()
              : _year);
      previousPayslipData =
          data.foldRight(previousPayslipData, (r, previous) => r);
      notifyListeners();
    } catch (error) {
      if(error is ClientException){
        logger.e("No internet connection");
        alertErrorDialog(context,"ไม่สามารถดึงข้อมูลได้","ไม่พบการเชื่อมต่ออินเทอร์เน็ต");
      }
      else if(error is TypeError){
        logger.e("แปลงข้อมูลจาก API ผิดพลาด : ${error}");
        logger.w("แก้ที่ Entity และ Model ของ Feature นั้นว่า Type ตรงกับ API");
        alertErrorDialog(context,"ข้อมูลผิดพลาด","ไม่สามารถแปลงข้อมูลได้");
      }
      else if(error is ErrorException){
        logger.e("ไม่สามารถเชื่อมต่อกับ Server ได้");
        alertErrorDialog(context,"ไม่สามารถเชื่อมต่อกับเซิฟเวอร์ได้","No internet connection");
      }
      notifyListeners();
    }
  }

  void setDeductionValue() {
    if (payslipData != null && payslipData!.isNotEmpty) {
      for (var i = 0; i < payslipData![0].deduction!.length; i++) {
        if (payslipData![0].deduction![i].idPayrollType == 11) {
          _deductionSSO = payslipData![0].deduction![i];
        }
        if (payslipData![0].deduction![i].idPayrollType == 10) {
          _deductionPF = payslipData![0].deduction![i];
        }
      }
    }
  }

  Future<void> alertErrorDialog(BuildContext context ,String title,String text) async{
    await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: "ยืนยัน",
        title: title,
        text: text,
        confirmBtnColor: const Color(0xffE46A76),
        onConfirmBtnTap: () async {
          // await LoginStorage.deleteAll();
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const LoginPage()),
          // );
        });
    // await LoginStorage.deleteAll();
    // Navigator.pushReplacement(
    //   context,
    //   PageTransition(
    //       child: const LoginPage(), type: PageTransitionType.rightToLeft),
    // );
  }

  static GetPayslipProvider of(BuildContext context, {listen = true}) =>
      Provider.of<GetPayslipProvider>(context, listen: listen);
}
