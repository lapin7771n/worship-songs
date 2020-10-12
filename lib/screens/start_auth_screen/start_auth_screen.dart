import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/auth_screen/auth_screen.dart';
import 'package:worshipsongs/screens/start_auth_screen/alreay_have_an_account_button.dart';
import 'package:worshipsongs/screens/start_auth_screen/sign_in_provider_button.dart';
import 'package:worshipsongs/screens/start_auth_screen/sign_in_with_providers.dart';

class StartAuthScreen extends StatelessWidget {
  static const String routeName = '/start-auth-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              children: [
                SignInWithProviders(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    Strings.of(context).or,
                    style: AppTextStyles.titleSongPlaylist.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SignInProviderButton(
                  providerType: ProviderType.email,
                  onPressed: () => signInWithEmail(context),
                ),
                SizedBox(height: 24),
                AlreadyHaveAnAccountButton(
                  onPressed: () => alreadyHaveAnAccountClick(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInWithEmail(BuildContext context) {
    Navigator.of(context).pushNamed(AuthScreen.routeName, arguments: false);
  }

  void alreadyHaveAnAccountClick(BuildContext context) {
    Navigator.of(context).pushNamed(AuthScreen.routeName, arguments: true);
  }
}
