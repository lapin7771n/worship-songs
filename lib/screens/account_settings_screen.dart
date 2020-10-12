import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/onboarding_screen.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: ListView(
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
              child: MaterialButton(
                minWidth: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () => logoutPressed(context),
                child: Text(Strings.of(context).logout),
                textColor: AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logoutPressed(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).logOut();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
    Provider.of<SongsProvider>(
      context,
      listen: false,
    ).clearLoadedSongs();
  }
}
