import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;

  const Button({
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const TextButton({
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      splashColor: AppColors.blueText.withAlpha(50),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4.copyWith(
              color: onPressed == null ? AppColors.gray : AppColors.blueText,
            ),
      ),
    );
  }
}
