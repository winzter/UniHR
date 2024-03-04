import 'package:upgrader/upgrader.dart';

class VersionDialog {
  static const String version = '2.1.1';
}

class UpdateAlertMessages extends UpgraderMessages {
  @override
  String? message(UpgraderMessage messageKey) {
    if (languageCode == 'th') {
      switch (messageKey) {
        case UpgraderMessage.body:
          return '{{appName}} มีการอัพเดทเวอร์ชันใหม่ (${VersionDialog.version}) กรุณาอัพเดทแอพพลิเคชั่นเพื่อเข้าใช้งาน';
        case UpgraderMessage.buttonTitleIgnore:
          return 'ข้าม';
        case UpgraderMessage.buttonTitleLater:
          return 'ไว้ทีหลัง';
        case UpgraderMessage.buttonTitleUpdate:
          return 'อัพเดทตอนนี้';
        case UpgraderMessage.prompt:
          return 'กรุณาอัพเดทแอพพลิเคชัน';
        case UpgraderMessage.releaseNotes:
          return '';
        case UpgraderMessage.title:
          return 'ระบบมีการอัพเดทเวอร์ชันใหม่';
      }
    }
    return super.message(messageKey);
  }
}