import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('다크 모드'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('알림 설정'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('앱 정보'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
