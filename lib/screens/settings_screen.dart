import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  static final List<_SettingsItem> _settingItems = [
    _SettingsItem(
      title: 'Account Settings',
      subtitle: 'Change password, email, logout',
      onTap: () {},
    ),
    _SettingsItem(
      title: 'Notifications',
      subtitle: 'Manage notifications',
      onTap: () {},
    ),
    _SettingsItem(title: '', subtitle: ''),
    _SettingsItem(
      title: 'Report about bug',
      subtitle: 'Write us a line about problem you have',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) => ListTile(
          title: Text(
            _settingItems[index].title,
            style: Theme.of(context).textTheme.headline4,
          ),
          subtitle: Text(
            _settingItems[index].subtitle,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onTap: _settingItems[index].onTap,
          trailing: _settingItems[index].onTap != null
              ? SvgPicture.asset('assets/images/ArrowRight.svg')
              : null,
        ),
        itemCount: _settingItems.length,
      ),
    );
  }
}

class _SettingsItem {
  final String title;
  final String subtitle;
  final Function onTap;

  _SettingsItem({
    this.title,
    this.subtitle,
    this.onTap,
  });
}
