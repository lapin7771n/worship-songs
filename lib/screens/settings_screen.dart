import 'package:flutter/material.dart';
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
      SettingsItem(
        title: Strings.of(context).notification,
        subtitle: Strings.of(context).manageNotifications,
        onTap: (BuildContext context) {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(Strings.of(context).notYetImplemented),
            ),
          );
        },
      ),
      SettingsItem(title: '', subtitle: ''),
      SettingsItem(
        title: Strings.of(context).reportABug,
        subtitle: Strings.of(context).writeUsALineAboutProblemYouHave,
        showArrow: false,
        onTap: (context) async {
          const url = 'mailto:nlapin.java@gmail.com?subject=WSongs_bug_report';
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
        itemBuilder: (ctx, index) =>
            SettingsListItem(_settingItems(context)[index]),
        itemCount: _settingItems(context).length,
      ),
    );
  }
}
