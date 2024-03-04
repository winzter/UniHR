import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../storage/secure_storage.dart';

class TokenExpires{
  static void checkTokenExpires(BuildContext context) async{
    if(JwtDecoder.isExpired(await LoginStorage.readToken())){
      await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: 'ตกลง',
          title: 'เกิดข้อผิดพลาด',
          text: "Token is Expired",
          confirmBtnColor: const Color(0xffE46A76),
          onConfirmBtnTap: () async{
            await LoginStorage.deleteAll();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          });
    }
  }
}
