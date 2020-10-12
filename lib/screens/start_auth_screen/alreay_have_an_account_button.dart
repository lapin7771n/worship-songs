import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/localizations/strings.dart';

class AlreadyHaveAnAccountButton extends StatelessWidget {
  final Function onPressed;

  const AlreadyHaveAnAccountButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          Strings.of(context).alreadyHaveAnAccount,
          style: AppTextStyles.buttonLink.copyWith(
            color: AppColors.blue,
          ),
        ),
      ),
    );
  }
}
