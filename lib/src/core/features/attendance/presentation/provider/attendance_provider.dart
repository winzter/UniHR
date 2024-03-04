import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/core/error/exception.dart';
import 'package:unihr/src/core/features/attendance/domain/entities/attendance_entity.dart';
import 'package:unihr/src/core/features/attendance/domain/use_cases/get_attendance.dart';

import '../../../../constanst/errorText.dart';
import '../../../../storage/secure_storage.dart';
import '../../../login/presentation/pages/login_page.dart';

class AttendanceProvider extends ChangeNotifier {
  final GetAttendance getAttendance;
  final Logger logger = Logger();

  AttendanceProvider({required this.getAttendance});
  List<AttendanceEntity> _attendanceData = [];

  Map<int, List<mp.LatLng>> _allCheckInOutLocations = {};
  bool _isCheckIn = false;
  bool _isGoogleMapReady = false;
  bool _isCheckOut = false;
  bool _isAtStatus = false;
  int _idGpsLocation = 0;

  int _indexSignOut = 0;
  int _indexSignIn = 0;

  List<AttendanceEntity> get attendanceData => _attendanceData;
  bool get isCheckIn => _isCheckIn;
  bool get isCheckOut => _isCheckOut;
  bool get isGoogleMapReady => _isGoogleMapReady;
  bool get isAtStatus => _isAtStatus;
  int get idGpsLocation => _idGpsLocation;
  int get indexSignOut => _indexSignOut;
  int get indexSignIn => _indexSignIn;

  void isAt(bool isAt) {
    _isAtStatus = isAt;
  }

  void setIsCheckIn(bool status) {
    _isCheckIn = status;
  }

  void setIsCheckOut(bool status) {
    _isCheckOut = status;
  }

  void setIsGoogleMapReady(bool isIt) {
    try {
      _isGoogleMapReady = isIt;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    } catch (e) {
      Logger().e("$e");
    }
  }

  void setIdGpsLocation(int id) {
    _idGpsLocation = id;
  }

  void locationCheck(double lat, double lng) {
    _allCheckInOutLocations.forEach((key, value) {
      if (mp.PolygonUtil.containsLocation(mp.LatLng(lat, lng), value, true)) {
        isAt(true);
        setIdGpsLocation(key);
      }
    });
  }

  void setCheckIsInPolygons(int index, List<mp.LatLng> data) {
    _allCheckInOutLocations[index] = data;
  }

  Future<void> getAttendanceData(BuildContext context) async {
    try {
      _indexSignIn = 0;
      _indexSignOut = 0;
      var data = await getAttendance();
      _attendanceData = data.foldRight(_attendanceData, (r, previous) => r);
      notifyListeners();
    } catch (error) {
      if(error is ClientException){
        logger.e("No internet connection");
        alertErrorDialog(context,"เกิดข้อผิดพลาด",ErrorText.clientError);
      }
      else if(error is TypeError){
        logger.e("แปลงข้อมูลจาก API ผิดพลาด : ${error}");
        logger.w("แก้ที่ Entity และ Model ของ Feature นั้นว่า Type ตรงกับ API");
        alertErrorDialog(context,"เกิดข้อผิดพลาด",ErrorText.typeError);
      }
      else if(error is ErrorException){
        logger.e("ไม่สามารถเชื่อมต่อกับ Server ได้");
        alertErrorDialog(context,"เกิดข้อผิดพลาด",ErrorText.clientError);
      }
      notifyListeners();
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
          await LoginStorage.deleteAll();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
    await LoginStorage.deleteAll();
    Navigator.pushReplacement(
      context,
      PageTransition(
          child: const LoginPage(), type: PageTransitionType.rightToLeft),
    );
  }
  static AttendanceProvider of(BuildContext context, {listen = true}) =>
      Provider.of<AttendanceProvider>(context, listen: listen);
}
