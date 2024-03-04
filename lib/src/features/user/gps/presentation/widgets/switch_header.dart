// import 'package:flutter/material.dart';
//
// class SwitchHeader extends StatelessWidget {
//
//   final bool checkInOut;
//   final VoidCallback callback;
//   const SwitchHeader({Key? key, required this.checkInOut, required this.callback}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (switchMode.isBoth == 1) ...[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 "บันทึกเวลา${checkInOut ? 'เข้า' : 'ออก'}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//               ),
//               // SizedBox(
//               //   height:35,
//               //   child: LiteRollingSwitch(
//               //     animationDuration: const Duration(milliseconds: 200),
//               //     textSize: 0,
//               //     width: 80,
//               //     value: switchMode.isSwitch,
//               //     onChanged: (isIt) {
//               //       switchMode.setIsSwitch(isIt);
//               //       callback();
//               //     },
//               //     iconOn: Icons.gps_fixed,
//               //     iconOff: Icons.bluetooth,
//               //     onDoubleTap: () {},
//               //     onSwipe: () {},
//               //     onTap: () {},
//               //   ),
//               // )
//             ],
//           ),
//         ] else ...[
//           Text(
//             "บันทึกเวลา${checkInOut ? 'เข้า' : 'ออก'}",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ],
//     );
//   }
// }
