import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tea_time/screen/root/root_screen.dart';
import 'package:tea_time/screen/signin/sign_in_screen.dart';

void main() async {
  // dotenv
  await dotenv.load(fileName: "assets/config/.env");

  // init Screen

  // intl
  await initializeDateFormatting();

  // runApp
  runApp(const AppPage(initialRoute: "/sign-in"));
}

class AppPage extends StatelessWidget {
  final String initialRoute;
  const AppPage({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    return GetMaterialApp(
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
      getPages: [
        GetPage(
          name: '/sign-in',
          page: () => const SignInScreen(),
        ),
        GetPage(
          name: '/',
          page: () => const RootScreen(),
        ),
      ],
    );
  }
}
