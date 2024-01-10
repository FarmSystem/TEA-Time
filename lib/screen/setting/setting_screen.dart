import 'package:flutter/material.dart';
import 'package:tea_time/screen/setting/Calendar/Calendar_screen.dart';
import '../base/default_appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Setting',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildSettingItem(context, '달력', 'calendar'),
          buildSettingItem(context, '마이 프로필', 'my_profile'),
          buildSettingItem(context, '내 정보 설정', 'account_settings'),
          buildSettingItem(context, '레벨 보기', 'view_level'),
          buildLogoutButton(context),
        ],

      ),
    );
  }

  Widget buildSettingItem(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () {
        // '달력' 항목을 누를 때 CalendarScreen 페이지로 이동하도록 처리
        if (title == '달력') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingDetailScreen(route)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

Widget buildLogoutButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushReplacementNamed(context, '/entry');
    },
    child: const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('로그아웃'),
        ],
      ),
    ),
  );
}

class SettingDetailScreen extends StatelessWidget {
  final String route;

  SettingDetailScreen(this.route);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(route), // 실제 페이지로 변경 가능
      ),
      body: Center(
        child: Text('This is the $route page.'),
      ),
    );
  }
}
