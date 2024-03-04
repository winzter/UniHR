import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../storage/secure_storage.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/usecase/get_profile.dart';

class ProfileProvider extends ChangeNotifier {

 final Logger logger = Logger();
 final GetProfile getProfile;
 ProfileProvider({required this.getProfile});

 ProfileEntity _profileData = const ProfileEntity();

 bool _isLoading = true;

 bool _isPayslipValidate = false;
 String? _telephoneMobile;
 String? _address;
 String? _houseNo;
 String? _village;
 String? _villageNo;
 String? _alley;
 String? _road;
 String? _subDistrict;
 String? _district;
 String? _province;
 String? _areaCode;
 String? _emergencyContact;
 String? _emergencyRelationship;
 String? _emergencyPhone;


 ProfileEntity get profileData => _profileData;

 bool get isLoading => _isLoading;
 bool get isPayslipValidate => _isPayslipValidate;
 String? get telephoneMobile => _telephoneMobile;
 String? get address => _address;
 String? get houseNo => _houseNo;
 String? get village => _village;
 String? get villageNo => _villageNo;
 String? get alley => _alley;
 String? get road => _road;
 String? get subDistrict => _subDistrict;
 String? get district => _district;
 String? get province => _province;
 String? get areaCode => _areaCode;
 String? get emergencyContact => _emergencyContact;
 String? get emergencyRelationship => _emergencyRelationship;
 String? get emergencyPhone => _emergencyPhone;


 Future<void> getProfileData(BuildContext context) async {
  Either<ErrorMessage, ProfileEntity> data = await getProfile();
  data.fold((l){
   alertErrorDialog(context,"${l.errMsgTitle}","${l.errMsgText}",true);
  }, (r){
       _profileData = r;
       _telephoneMobile = _profileData.telephoneMobile;
       _address = _profileData.address;
       _houseNo = _profileData.houseNo;
       _village = _profileData.village;
       _villageNo = _profileData.villageNo;
       _alley = _profileData.alley;
       _road = _profileData.road;
       _subDistrict = _profileData.subDistrict;
       _district = _profileData.district;
       _province = _profileData.provience;
       _areaCode = _profileData.areaCode;
       _emergencyContact = _profileData.emergencyContact;
       _emergencyRelationship = _profileData.emergencyRelationship;
       _emergencyPhone = _profileData.emergencyPhone;
      });
  notifyListeners();
 }

 void setPhoneNum(String num) {
  _telephoneMobile = num;
  notifyListeners();
 }

 void setPayslipValidate(bool isPass) {
  _isPayslipValidate = isPass;
  notifyListeners();
 }

 void setIsLoading(bool isIt){
  try{
   _isLoading = isIt;
   Future.delayed(Duration.zero, () {
    notifyListeners();
   });
  }catch(e){
   log("$e");
  }

 }

 Future<void> alertErrorDialog(BuildContext context ,String title,String text,bool isSevere) async{
  await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      confirmBtnText: "ยืนยัน",
      title: title,
      text: text,
      confirmBtnColor: const Color(0xffE46A76),
      onConfirmBtnTap: () async {
       if(isSevere){
        await LoginStorage.deleteAll();
        Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => const LoginPage()),
        );
       }else{
        Navigator.pop(context);
       }
      }
      );
  if(isSevere){
   await LoginStorage.deleteAll();
   Navigator.pushReplacement(
    context,
    PageTransition(
        child: const LoginPage(), type: PageTransitionType.rightToLeft),
   );
  }
 }
 void setAddress(
     String zipcode,
     String district,
     String province,
     String alley,
     String houseNo,
     String road,
     String subDistrict,
     String village,
     String villageNo
     ) {
  _district = district;
  _province = province;
  _alley = alley;
  _houseNo = houseNo;
  _road = road;
  _subDistrict = subDistrict;
  _village = village;
  _villageNo = villageNo;
  _areaCode = zipcode;
  notifyListeners();
 }

 void setEmergency(String contract, String relationship, String phone) {
  _emergencyContact = contract;
  _emergencyRelationship = relationship;
  _emergencyPhone = phone;
  notifyListeners();
 }

 static ProfileProvider of(BuildContext context, {listen = true}) =>
     Provider.of<ProfileProvider>(context, listen: listen);
}
