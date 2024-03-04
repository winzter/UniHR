import 'dart:developer';
import 'package:flutter/material.dart';
import '../../domain/usecases/use_cases.dart';

class EditProfileProvider extends ChangeNotifier {
  final SendEditPhoneNumber sendEditPhoneNumber;
  final SendEditAddress sendEditAddress;

  final ChangePassword changePassword;
  final SendEditEmergencyContract sendEditEmergencyContract;

  // final ChangePassword changePassword;

  EditProfileProvider({
    required this.sendEditPhoneNumber,
    required this.sendEditAddress,
    required this.sendEditEmergencyContract,
    required this.changePassword,
    // required this.changePassword
  });

  Future<void> sendEditPhoneNumberData(String phoneNum) async {
    try {
      await sendEditPhoneNumber(phoneNum);
      notifyListeners();
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }

  Future<void> sendEditAddressData(
      String zipcode,
      String district,
      String province,
      String alley,
      String houseNo,
      String road,
      String subDistrict,
      String village,
      String villageNo) async {
    try {
      await sendEditAddress(zipcode, district, province, alley, houseNo, road,
          subDistrict, village, villageNo);
      notifyListeners();
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }

  Future<void> sendEditEmergencyContractData(String emergencyName,
      String phoneNum, String emergencyRelationship) async {
    try {
      await sendEditEmergencyContract(
          emergencyName, phoneNum, emergencyRelationship);
      notifyListeners();
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }

  Future<bool> changePasswordData(String oldPass, String newPass,
      String confirm, BuildContext context) async {
    var res = await changePassword(oldPass, newPass, confirm);
    bool isError = true;
    res.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${l.errMsgTitle}',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      notifyListeners();
      isError = true;
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'เปลี่ยนรหัสผ่านสำเร็จ',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: const Color(0xff6FC9E4),
        behavior: SnackBarBehavior.floating,
      ));
      notifyListeners();
      isError = false;
    });
    notifyListeners();
    return isError;
  }
}
