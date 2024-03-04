import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:unihr/injection.dart';
import 'injection_container.dart' as di;
import 'src/core/features/splash/splash.page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'src/core/provider/bottom_navbar/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await initializeDateFormatting();
  await di.init();
  await Upgrader().initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()..init()),
      ], child: Injection(router: MyApp()))));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
      Intl.defaultLocale = localizationProvider.locale.languageCode;
      // Intl.defaultLocale = 'th';
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniHR',
        locale: localizationProvider.locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('th')],
        theme: ThemeData(
          fontFamily: 'kanit',
          cardTheme: CardTheme(color: Colors.white),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          dialogTheme: const DialogTheme(backgroundColor: Colors.white),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
          useMaterial3: true,
          // colorScheme: ColorScheme.light(primary: Colors.white)
        ),
        home: const SplashPage(),
      );
    });
  }
}
