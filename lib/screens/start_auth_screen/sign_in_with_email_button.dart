import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/localizations/strings.dart';

class SignInWithEmailButton extends StatelessWidget {
  final double borderRadius;
  final Function onPressed;

  const SignInWithEmailButton({
    Key key,
    @required this.onPressed,
    this.borderRadius = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        Strings.of(context).signUpWithEmail,
        style: AppTextStyles.title3.copyWith(
          color: AppColors.blue,
        ),
      ),
    );
  }
}
