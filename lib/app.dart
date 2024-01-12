import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tea_time/util/function/app_pages.dart';

import 'binding/init_binding.dart';

class AppPage extends StatelessWidget {
  final String initialRoute;

  const AppPage({
    super.key,
    required this.initialRoute,
  });

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
      initialBinding: InitBinding(),
      getPages: appPages,
    );
  }
}
