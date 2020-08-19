import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worshipsongs/data/settings_item.dart';
import 'package:worshipsongs/screens/account_settings_screen.dart';
import 'package:worshipsongs/widgets/settings_list_item.dart';

class SettingsScreen extends StatelessWidget {
  static final List<SettingsItem> _settingItems = [
    SettingsItem(
      title: 'Account Settings',
      subtitle: 'Change password, email, logout',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(AccountSettingsScreen.routeName);
      },
    ),
    SettingsItem(
      title: 'Notifications',
      subtitle: 'Manage notifications',
      onTap: (BuildContext context) {
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Not yet implemented'),
          ),
        );
      },
    ),
    SettingsItem(title: '', subtitle: ''),
    SettingsItem(
      title: 'Report about bug',
      subtitle: 'Write us a line about problem you have',
      showArrow: false,
      onTap: (context) async {
        const url = 'mailto:nlapin.java@gmail.com?subject=WSongs_bug_report';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) => SettingsListItem(_settingItems[index]),
        itemCount: _settingItems.length,
      ),
    );
  }
}
