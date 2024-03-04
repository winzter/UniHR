import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/bluetooth_bloc.dart';

class SendDataButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final bool isCheckInOut;
  final BluetoothBloc bloc;

  final bool isDeviceFounded;

  const SendDataButton(
      {Key? key,
      required this.title,
      required this.bgColor,
      required this.bloc,
      required this.isCheckInOut, required this.isDeviceFounded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileProvider user = Provider.of<ProfileProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all((isDeviceFounded?bgColor:Colors.grey)),
          ),
          onPressed: () async {
            if(isDeviceFounded){
              await QuickAlert.show(
                context: context,
                autoCloseDuration: await Duration(seconds: 1),
                type: QuickAlertType.loading,
                title: 'กำลังลงชื่อ...',
                text: DateFormat('วันที่ dd MMM yyyy').format(
                  DateTime.now(),
                ),
              );
              bloc.add(SendBluetoothData(
                  attendanceDateTime:
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                  isCheckIn: isCheckInOut ? 1 : 0,
                  idAttendanceType: 7,
                  idEmployee: user.profileData.idEmployees!.toString(),
                  idCompany: user.profileData.idCompany.toString()));
              await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  confirmBtnText: 'ยืนยัน',
                  title: 'ลงชื่อสำเร็จ!',
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                  });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          )),
    );
  }
}
