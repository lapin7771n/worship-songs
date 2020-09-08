import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class BaseProvider with ChangeNotifier {
  static const String _DEBUG_URL = 'http://localhost';
  static const String _PROD_URL = 'http://worship-songs-lyrics.tk';

  // ignore: non_constant_identifier_names
  String get API_URL {
    if (kReleaseMode) {
      return _PROD_URL;
    } else {
      return _DEBUG_URL;
    }
  }
}
