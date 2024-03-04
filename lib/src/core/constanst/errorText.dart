import 'package:logger/logger.dart';

class ErrorText{
  static final Logger logger = Logger();

  /*? แปลงข้อมูลจาก API ไม่ถูก  ?*/
  static const String typeError = "ข้อมูลผิดพลาด โปรดติดต่อแอดมิน";

  /*? Internet มีปัญหา , ดึงข้อมูลจาก Server ไม่ได้  ?*/
  static const String clientError = "ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้ ตรวจสอบการเชื่อมต่ออินเทอร์เน็ตหรือติดต่อแอดมิน";

  /*? Format ที่ได้รับมาจาก Server ไม่ได้อยู่ในรูปของ Json  ?*/
  static const String formatError = "ข้อมูลผิดพลาด โปรดติดต่อแอดมิน";

}