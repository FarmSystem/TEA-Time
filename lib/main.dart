import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tea_time/util/class/app_routes.dart';

import 'app.dart';

void main() async {
  // dotenv
  await dotenv.load(fileName: "assets/config/.env");
  await initializeDateFormatting();

  // runApp
  runApp(const AppPage(initialRoute: Routes.ROOT));
}
