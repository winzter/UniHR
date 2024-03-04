import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/features/login/presentation/pages/login_page.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../../../item_status/domain/entities/entities.dart';
import '../../../item_status/domain/use_cases/get_leave.dart';
import '../../../item_status/domain/use_cases/get_request_time.dart';

class WaitingProvider extends ChangeNotifier {
  final Logger logger = Logger();
  final GetLeaveData getLeaveData;
  final GetRequestTimeData getRequestTimeData;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0));
  List<RequestTimeEntity> _requestTime = [];
  List<RequestTimeEntity> _requestTimeNotApprove = [];
  List<RequestTimeEntity> _requestTimeApprove = [];
  List<LeaveEntity> _leaveHistory = [];
  List<LeaveEntity> _leaveNotApprove = [];
  List<LeaveEntity> _leaveApprove = [];

  WaitingProvider({
    required this.getLeaveData,
    required this.getRequestTimeData,
  });

  List<LeaveEntity> get leaveHistory => _leaveHistory;
  List<RequestTimeEntity> get requestTime => _requestTime;
  List<RequestTimeEntity> get requestTimeNotApprove => _requestTimeNotApprove;
  List<RequestTimeEntity> get requestTimeApprove => _requestTimeApprove;
  List<LeaveEntity> get leaveNotApprove => _leaveNotApprove;
  List<LeaveEntity> get leaveApprove => _leaveApprove;

  Future<void> getLeave(BuildContext context) async {
    try {
      DateTime start = DateTime(DateTime.now().year, DateTime.now().month, 1);
      DateTime end = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
      Either<ErrorMessage, List<LeaveEntity>> data = await getLeaveData(DateFormat("yyyy-MM-dd").format(start),
          DateFormat("yyyy-MM-dd").format(end));
      _leaveHistory = data.foldRight(_leaveHistory, (r, previous) => r);
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

  Future<void> getRequestTime(BuildContext context) async {
    try {
      Either<ErrorMessage, List<RequestTimeEntity>> data = await getRequestTimeData(
          DateFormat("yyyy-MM-dd").format(dateRange.start),
          DateFormat("yyyy-MM-dd").format(dateRange.end));
      data.fold((l){

      },
              (r){
        _requestTime = r;
      });
      notifyListeners();
    } catch (error) {
      if(error is ClientException){
        logger.e("No internet connection");
        // alertErrorDialog(context,"ไม่สามารถดึงข้อมูลได้","ไม่พบการเชื่อมต่ออินเทอร์เน็ต");
      }
      else if(error is TypeError){
        logger.e("แปลงข้อมูลจาก API ผิดพลาด : ${error}");
        logger.w("แก้ที่ Entity และ Model ของ Feature นั้นว่า Type ตรงกับ API");
        // alertErrorDialog(context,"ข้อมูลผิดพลาด","ไม่สามารถแปลงข้อมูลได้");
      }
      else if(error is ErrorException){
        logger.e("ไม่สามารถเชื่อมต่อกับ Server ได้");
        // alertErrorDialog(context,"ไม่สามารถเชื่อมต่อกับเซิฟเวอร์ได้","No internet connection");
      }
      notifyListeners();
    }
  }

  Future<void> getAllData(BuildContext context) async {
    _requestTimeApprove.clear();
    _requestTimeNotApprove.clear();
    _leaveNotApprove.clear();
    _leaveApprove.clear();
    await getLeave(context);
    await getRequestTime(context);
    isNotApprove();
    isApprove();
    notifyListeners();
  }

  Future getAllDataByDate(DateTimeRange period,BuildContext context) async {
    dateRange = period;
    _requestTimeApprove.clear();
    _requestTimeNotApprove.clear();
    _leaveNotApprove.clear();
    _leaveApprove.clear();
    await getLeave(context);
    await getRequestTime(context);
    isNotApprove();
    isApprove();
    notifyListeners();
  }

  int numRequestIsNotApprove() {
    return _requestTimeNotApprove.length + _leaveNotApprove.length;
  }

  void isNotApprove() {
    _requestTimeNotApprove.clear();
    _leaveNotApprove.clear();
    if (_requestTime.isNotEmpty) {
      _requestTime.sort((a, b) => a.start!.compareTo(b.start!));
      for (var i in _requestTime) {
        if (i.isDoubleApproval == 0 && i.isWithdraw == null) {
          if (i.isManagerLv1Approve == null) {
            _requestTimeNotApprove.add(i);
          }
        } else if (i.isDoubleApproval == 1 && i.isWithdraw == null) {
          if (i.isManagerLv2Approve == null) {
            _requestTimeNotApprove.add(i);
          }
        }
      }
    }
    if (_leaveHistory.isNotEmpty) {
      _leaveHistory.sort((a, b) => a.start!.compareTo(b.start!));
      _leaveNotApprove = _leaveHistory
          .where((element) =>
              element.isApprove == null && element.isWithdraw == null)
          .toList();
    }
  }

  void isApprove() {
    _requestTimeApprove.clear();
    if (_requestTime.isNotEmpty) {
      _requestTime.sort((a, b) => a.start!.compareTo(b.start!));
      for (var i in _requestTime) {
        if (i.isDoubleApproval == 0) {
          if (i.isManagerLv1Approve == 1) {
            _requestTimeApprove.add(i);
          }
        } else {
          if (i.isManagerLv1Approve == 1 && i.isManagerLv2Approve == 1) {
            _requestTimeApprove.add(i);
          }
        }
      }
    }
    if (_leaveHistory.isNotEmpty) {
      _leaveApprove = _leaveHistory
          .where((element) => element.isApprove == 1)
          .where((e) => e.isWithdraw == null)
          .toList();
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
  static WaitingProvider of(BuildContext context, {listen = true}) =>
      Provider.of<WaitingProvider>(context, listen: listen);
}
