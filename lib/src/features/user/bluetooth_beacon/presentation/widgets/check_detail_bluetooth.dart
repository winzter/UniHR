import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../bloc/bluetooth_bloc.dart';
import 'checkinout_body.dart';
import 'checkinout_header.dart';
import 'send_data_button.dart';

class CheckDetailBluetooth extends StatelessWidget {
  final String? platFormName;
  final bool checkInOut;
  final bool isLoading;

  CheckDetailBluetooth({
    super.key,
    required this.platFormName,
    required this.checkInOut,
    required this.isLoading,
  });

  final BluetoothBloc bloc = sl<BluetoothBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white),
        child: Column(
          children: [
            Text(
              "บันทึกเวลา${checkInOut ? 'เข้า' : 'ออก'}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            const CheckInOutHeader(),
            const CheckInOutBody(),
            Center(
              child: Text(isLoading?'กำลังค้นหา...':platFormName??'ไม่พบอุปกรณ์',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),),
            const SizedBox(
              height: 15,
            ),
            checkInOut ?SendDataButton(
              isDeviceFounded: platFormName != null,
              title: 'ยืนยันเวลาเข้างาน',
              bgColor: const Color(0xff30B98F),
              bloc: bloc,
              isCheckInOut: true,
            ):SendDataButton(
              isDeviceFounded: platFormName != null,
              title: 'ยืนยันเวลาออกงาน',
              bgColor: Colors.red,
              bloc: bloc,
              isCheckInOut: false,
            )
            // const SizedBox(
            //   height: 10,
            // ),

          ],
        ),
      ),
    );
  }
}
