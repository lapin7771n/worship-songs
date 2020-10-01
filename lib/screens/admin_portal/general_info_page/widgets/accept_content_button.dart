import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/widgets/buttons.dart';

class AcceptContentButton extends StatelessWidget {
  static const double ACCEPT_BUTTON_HEIGHT = 88;
  static const double PADDING = 16;
  static const double SHADOW_COLOR_OPACITY = .1;
  static const double SHADOW_Y_OFFSET = -2;
  static const double SHADOW_BLUR_RADIUS = 20;
  static const double SHADOW_SPREAD_RADIUS = 1;

  final String text;
  final Function onTap;

  const AcceptContentButton({
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ACCEPT_BUTTON_HEIGHT,
      padding: const EdgeInsets.all(PADDING),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(SHADOW_COLOR_OPACITY),
            offset: const Offset(0, SHADOW_Y_OFFSET),
            blurRadius: SHADOW_BLUR_RADIUS,
            spreadRadius: SHADOW_SPREAD_RADIUS,
          )
        ],
      ),
      child: Container(
        child: Button(
          title: text,
          onPressed: onTap,
        ),
        width: double.infinity,
      ),
    );
  }
}
