import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/screens/start_auth_screen/sign_in_with_email_button.dart';

enum ProviderType {
  apple,
  google,
  email,
}

class SignInProviderButton extends StatelessWidget {
  static const double _BORDER_RADIUS = 8.0;

  final ProviderType providerType;
  final Function onPressed;

  const SignInProviderButton({
    Key key,
    @required this.providerType,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      child: getButton(providerType),
    );
  }

  Widget getButton(ProviderType providerType) {
    switch (providerType) {
      case ProviderType.apple:
        return AppleSignInButton(
          borderRadius: _BORDER_RADIUS,
          centered: true,
          style: AppleButtonStyle.black,
          onPressed: onPressed,
        );
      case ProviderType.google:
        return GoogleSignInButton(
          borderRadius: _BORDER_RADIUS,
          centered: true,
          darkMode: true,
          splashColor: AppColors.blue,
          onPressed: onPressed,
        );
      case ProviderType.email:
        return SignInWithEmailButton(
          borderRadius: _BORDER_RADIUS,
          onPressed: onPressed,
        );
    }
    return null;
  }
}
