import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unihr/src/core/constanst/version_dialog.dart';
import 'package:upgrader/upgrader.dart';
import '../../storage/secure_storage.dart';
import '../loading_page/loading_page.dart';
import '../login/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplash() async {
    // await Upgrader().initialize();
    final userToken = await LoginStorage.readToken();
    return Timer(const Duration(seconds: 2), () {
      // print("upgrader!!!");
      // print(Upgrader.sharedInstance.isUpdateAvailable());
      if (!Upgrader.sharedInstance.isUpdateAvailable()) {
        if (userToken != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LoadingPage(
                      isLogIn: true,
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        canDismissDialog: false,
        showIgnore: false,
        showLater: false,
        showReleaseNotes: false,
        upgrader: Upgrader(
          messages: UpdateAlertMessages(),
          // debugLogging: true,
        ),
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/UniLogoDark.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
