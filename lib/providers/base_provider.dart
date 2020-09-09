import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

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

  Future<http.Response> get(String url, String accessToken) {
    return http.get(url, headers: _getHeaders(accessToken));
  }

  Future<http.Response> put(String url, String accessToken, String body) {
    return http.put(url, headers: _getHeaders(accessToken), body: body);
  }

  Future<http.Response> delete(String url, String accessToken) {
    return http.delete(url, headers: _getHeaders(accessToken), );
  }

  Map<String, String> _getHeaders(String accessToken) {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $accessToken"
    };
  }
}
