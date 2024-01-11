import 'package:get/get.dart';
import 'package:tea_time/binding/root_binding.dart';
import 'package:tea_time/util/class/app_routes.dart';
import 'package:tea_time/view/entry/entry_screen.dart';
import 'package:tea_time/view/join/join_screen.dart';
import 'package:tea_time/view/root/root_screen.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding()
  ),
  GetPage(
    name: Routes.JOIN,
    page: () => const JoinScreen(),
    binding: RootBinding()
  ),
  GetPage(
    name: Routes.ENTRY,
    page: () => SignInScreen(),
  )
];