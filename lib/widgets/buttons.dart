import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;

  const Button({
    @required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      highlightElevation: 2.0,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}
