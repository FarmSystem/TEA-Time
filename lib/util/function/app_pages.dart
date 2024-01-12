import 'package:get/get.dart';
import 'package:tea_time/binding/entry_binding.dart';
import 'package:tea_time/binding/root_binding.dart';
import 'package:tea_time/util/class/app_routes.dart';
import 'package:tea_time/view/entry/entry_screen.dart';
import 'package:tea_time/view/join/join_screen.dart';
import 'package:tea_time/view/main/help_page.dart';
import 'package:tea_time/view/main/home_screen.dart';
import 'package:tea_time/view/main/writing_form.dart';
import 'package:tea_time/view/root/root_screen.dart';
import 'package:tea_time/view/setting/setting_screen.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding()
  ),
  GetPage(
    name: Routes.JOIN,
    page: () => const JoinScreen(),
    binding: EntryBinding()
  ),
  GetPage(
    name: Routes.ENTRY,
    page: () => SignInScreen(),
    binding: EntryBinding()
  ),
  GetPage(
    name: Routes.HELP,
    page: () => const HelpPage(),
    binding: RootBinding()
  ),
  GetPage(
    name: Routes.HOME,
    page: () => const HomeScreen(),
    binding: RootBinding()
  ),
  GetPage(
    name: Routes.POSTING,
    page: () => WritingFormPage(),
    binding: RootBinding()
  ),
  GetPage(
    name: Routes.SETTING,
    page: () => const SettingScreen(),
    binding: RootBinding()
  )
];