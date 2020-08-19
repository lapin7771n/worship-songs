import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
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
          'Account Settings',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: ListView(
        children: [
          Consumer<AuthProvider>(
            builder: (_, auth, __) => SettingsListItem.custom(
              title: auth.user?.email ?? '',
              subtitle: 'Change email address',
              onTap: (ctx) {
                Scaffold.of(ctx).hideCurrentSnackBar();
                Scaffold.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text('Not yet implemented'),
                  ),
                );
              },
            ),
          ),
          SettingsListItem.custom(
            title: '********',
            subtitle: 'Change password',
            onTap: (ctx) {
              Scaffold.of(ctx).hideCurrentSnackBar();
              Scaffold.of(ctx).showSnackBar(
                SnackBar(
                  content: Text('Not yet implemented'),
                ),
              );
            },
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
              child: Text('Logout'),
              textColor: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
