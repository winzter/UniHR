import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class SendTimePage extends StatelessWidget {

  final String platFormName;

  const SendTimePage({super.key, required this.platFormName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBluetooth(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: CheckDetailBluetooth(platFormName:platFormName,),
      ),
    );
  }
}
