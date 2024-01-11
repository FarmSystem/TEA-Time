import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tea_time/util/function/app_pages.dart';

void main() async {
  // dotenv
  await dotenv.load(fileName: "assets/config/.env");

  // init Screen

  // intl
  await initializeDateFormatting();

  // runApp
  runApp(const AppPage(initialRoute: "/entry"));
}

class AppPage extends StatelessWidget {
  final String initialRoute;
  const AppPage({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TeaTime",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: initialRoute,
      getPages: appPages,
    );
  }
}
