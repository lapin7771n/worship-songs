import 'package:flutter/material.dart';

class PopupItem {
  final String title;
  final Color color;
  final String iconPath;
  final Function onTap;

  PopupItem({
    this.title,
    this.color,
    this.iconPath,
    this.onTap,
  });
}
