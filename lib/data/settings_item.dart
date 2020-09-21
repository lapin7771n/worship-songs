import 'package:flutter/cupertino.dart';

class SettingsItem {
  final String title;
  final String subtitle;
  final Function(BuildContext context) onTap;
  bool showArrow;

  SettingsItem({
    @required this.title,
    this.subtitle,
    this.onTap,
    bool showArrow = true,
  }) : showArrow = onTap != null && showArrow;
}
