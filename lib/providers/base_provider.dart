import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class BaseProvider with ChangeNotifier {
  static const String _ANDROID_DEBUG_URL = 'http://10.0.2.2';
  static const String _IOS_DEBUG_URL = 'http://localhost';
  static const String _PROD_URL = 'http://worship-songs-lyrics.tk';

  // ignore: non_constant_identifier_names
  String get API_URL {
    if (kReleaseMode || kProfileMode) {
      return _PROD_URL;
    } else {
      return Platform.isAndroid ? _ANDROID_DEBUG_URL : _IOS_DEBUG_URL;
    }
  }

  Future<http.Response> get(String url, String accessToken) {
    return http.get(url, headers: _getHeaders(accessToken));
  }

  Future<http.Response> put(String url, String accessToken, String body) {
    return http.put(url, headers: _getHeaders(accessToken), body: body);
  }

  Future<http.Response> post(String url, String accessToken, String body) {
    return http.post(url, headers: _getHeaders(accessToken), body: body);
  }

  Future<http.Response> delete(String url, String accessToken) {
    return http.delete(url, headers: _getHeaders(accessToken));
  }

  Map<String, String> _getHeaders(String accessToken) {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $accessToken"
    };
  }
}
