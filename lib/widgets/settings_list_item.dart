import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worshipsongs/data/settings_item.dart';

class SettingsListItem extends StatelessWidget {
  final SettingsItem _settingsItem;

  const SettingsListItem(this._settingsItem);

  SettingsListItem.custom({
    @required String title,
    String subtitle,
    Function(BuildContext context) onTap,
  }) : this._settingsItem = SettingsItem(
          title: title,
          subtitle: subtitle,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      title: Text(
        _settingsItem.title,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: _settingsItem.subtitle == null
          ? null
          : Text(
              _settingsItem.subtitle,
              style: Theme.of(context).textTheme.subtitle2,
            ),
      onTap: _settingsItem.onTap != null
          ? () => _settingsItem.onTap(context)
          : null,
      trailing: _settingsItem.showArrow
          ? SvgPicture.asset('assets/images/ArrowRight.svg')
          : null,
    );
  }
}
