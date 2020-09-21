import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/widgets/settings_list_item.dart';

class AccountSettingsScreen extends StatelessWidget {
  static const String routeName = '/account-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.of(context).accountSettings,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: ListView(
        children: [
          Consumer<AuthProvider>(
            builder: (_, auth, __) => SettingsListItem.custom(
              title: auth.user?.email ?? '',
            ),
          ),
          SettingsListItem.custom(
            title: '',
            subtitle: '',
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
                Provider.of<SongsProvider>(context, listen: false)
                    .clearLoadedSongs();
                Navigator.of(context).pop();
              },
              child: Text(Strings.of(context).logout),
              textColor: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }

  void _onEmailClicked(BuildContext ctx) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(Strings.of(ctx).notYetImplemented),
      ),
    );
  }

  void _onPasswordClicked(BuildContext ctx) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(Strings.of(ctx).notYetImplemented),
      ),
    );
  }
}
