import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worshipsongs/data/settings_item.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/account_settings_screen.dart';
import 'package:worshipsongs/widgets/settings_list_item.dart';

class SettingsScreen extends StatelessWidget {
  List<SettingsItem> _settingItems(BuildContext context) {
    return [
      SettingsItem(
        title: Strings.of(context).accountSettings,
        subtitle: Strings.of(context).changePasswordEmailLogout,
        onTap: (BuildContext context) {
          Navigator.of(context).pushNamed(AccountSettingsScreen.routeName);
        },
      ),
      SettingsItem(title: '', subtitle: ''),
      SettingsItem(
        title: Strings.of(context).reportABug,
        subtitle: Strings.of(context).writeUsALineAboutProblemYouHave,
        showArrow: false,
        onTap: (context) async {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          final url = 'mailto:nlapin.java@gmail.com?subject=WSongs_bug_report&' +
              'body=Version:${packageInfo.version}::${packageInfo.buildNumber}';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw '${Strings.of(context).couldNotLaunch} $url';
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0) _buildHeader(context),
              SettingsListItem(_settingItems(context)[index]),
            ],
          );
        },
        itemCount: _settingItems(context).length,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 10,
        bottom: 16,
      ),
      child: Text(
        Strings.of(context).settings,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
