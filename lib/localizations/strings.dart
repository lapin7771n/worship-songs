import 'package:flutter/cupertino.dart';
import 'package:worshipsongs/localizations/app_localizations.dart';

class Strings {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}
