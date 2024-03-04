import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../../user/item_status/domain/entities/entities.dart';
import '../../domain/entities/entities.dart';

class ManagerRadioButtonProvider extends ChangeNotifier {
  String _type = "ขอลา";

  List<LeaveRequestManager> _leaveData = [];
  List<RequestTimeManager> _reqTimeData = [];
  List<WithdrawLeaveManager> _withdrawData = [];
  List<ChangeTimeManager> _changeTimeData = [];
  PayrollSettingEntity? _payrollData;
  List<RequestTimeManager> _dataRequestTime = [];
  List<RequestTimeManager> _dataRequestOT = [];

  bool _isSelectAll = false;
  bool isSelectionMode = false;
  HashSet _selectedFlag = HashSet();

  String get type => _type;
  bool get isSelectAll => _isSelectAll;
  HashSet get selectedFlag => _selectedFlag;
  List<LeaveRequestManager> get leaveData => _leaveData;
  List<RequestTimeManager> get reqTimeData => _reqTimeData;
  List<WithdrawLeaveManager> get withdrawData => _withdrawData;
  PayrollSettingEntity? get payrollData => _payrollData;
  List<RequestTimeManager> get dataRequestTime => _dataRequestTime;
  List<RequestTimeManager> get dataRequestOT => _dataRequestOT;

  void setType(String userType) {
    _selectedFlag.clear();
    _isSelectAll = false;
    _type = userType;
    notifyListeners();
  }

  void setData(
      List<LeaveRequestManager> leaveData,
      List<RequestTimeManager> reqTimeData,
      List<WithdrawLeaveManager> withdrawData,
      List<ChangeTimeManager> changeTimeData,
      PayrollSettingEntity payrollData,
      List<RequestTimeManager> dataRequestTime,
      List<RequestTimeManager> dataRequestOT) {
    _leaveData = [...leaveData];
    _reqTimeData = [...reqTimeData];
    _withdrawData = [...withdrawData];
    _changeTimeData = [...changeTimeData];
    _payrollData = payrollData;
    _dataRequestOT = [...dataRequestOT];
    _dataRequestTime = [...dataRequestTime];
  }

  int dataLength() {
    if (_type == "ขอลา" && _leaveData.isNotEmpty) {
      return _leaveData.length;
    } else if (_type == "ขอรับรองเวลาทำงาน" && _dataRequestTime.isNotEmpty) {
      return _dataRequestTime.length;
    } else if (_type == "ขอทำงานล่วงเวลา" && _dataRequestOT.isNotEmpty) {
      return _dataRequestOT.length;
    } else if (_type == "ขอเปลี่ยนกะ" && _changeTimeData.isNotEmpty) {
      return _changeTimeData.length;
    } else if (_type == "ขอถอนลา" && _withdrawData.isNotEmpty) {
      return _withdrawData.length;
    } else {
      return 0;
    }
  }

  void setSelectAll(bool selectAll) {
    _isSelectAll = selectAll;
    notifyListeners();
  }

  void onTap(int index) {
    if (_selectedFlag.contains(index)) {
      _selectedFlag.remove(index);
      if (_selectedFlag.isEmpty) {
        _isSelectAll = false;
      }
    } else {
      _selectedFlag.add(index);
    }
    notifyListeners();
  }

  void selectAll(int length) {
    for (int i = 0; i < length; i++) {
      _selectedFlag.add(i);
    }
  }

  void clearAllData() {
    _leaveData.clear();
    _reqTimeData.clear();
    _withdrawData.clear();
    _changeTimeData.clear();
    _dataRequestTime.clear();
    _dataRequestOT.clear();
    notifyListeners();
  }

  void unSelectAll() {
    _selectedFlag.clear();
    notifyListeners();
  }
}
