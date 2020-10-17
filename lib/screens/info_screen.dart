import 'package:flutter/material.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/localizations/strings.dart';

class InfoScreen extends StatelessWidget {
  static const String routeName = 'info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).information),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            Strings.of(context).copyrightText,
            style: AppTextStyles.bodyTextRegular,
          ),
        ),
      ),
    );
  }
}
