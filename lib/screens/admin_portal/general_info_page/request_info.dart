import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
import 'package:worshipsongs/widgets/settings_list_item.dart';

class RequestInfo extends StatelessWidget {
  final int authorID;
  final DateTime timestamp;

  const RequestInfo({
    this.timestamp,
    this.authorID,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of(context).requestInfo,
          style: Theme.of(context).textTheme.headline3,
        ),
        buildRequestInfoItem(
          Strings.of(context).requestedBy,
          authorID ?? Provider.of<AuthProvider>(context).user.email,
        ),
        buildRequestInfoItem(
          Strings.of(context).dateAndTime,
          getFormattedDate(timestamp),
        ),
      ],
    );
  }

  Widget buildRequestInfoItem(
    String title,
    String subtitle, [
    Function onClick,
  ]) {
    return SettingsListItem.custom(
      title: title,
      subtitle: subtitle,
      onTap: onClick == null ? null : (context) => onClick(),
    );
  }

  String getFormattedDate(DateTime dateTime) {
    dateTime = dateTime ?? DateTime.now();
    return DateFormat.yMMMMd().format(dateTime).toString() +
        ', ' +
        DateFormat.jm().format(dateTime);
  }
}
