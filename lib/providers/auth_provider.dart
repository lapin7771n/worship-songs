import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worshipsongs/data/auth_status.dart';
import 'package:worshipsongs/data/payloads/requests/sign_in_request.dart';
import 'package:worshipsongs/data/payloads/requests/sign_up_request.dart';
import 'package:worshipsongs/data/payloads/responses/sign_in_response.dart';
import 'package:worshipsongs/data/wsongs_user.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class AuthProvider extends BaseProvider {
  static const String _AUTH_PATH = '/api/v1/auth';
  static const String _ACCESS_TOKEN_KEY = "accessToken";

  WSongsUser _user;
  String _accessToken;

  WSongsUser get user {
    return _user;
  }

  String get accessToken {
    return _accessToken;
  }

  AuthStatus authStatus = AuthStatus.UNINITIALIZED;

  Future<WSongsUser> createUser(String email, String password) async {
    final String signUpUrl = "$API_URL$_AUTH_PATH/signup";
    final Map requestBody = SignUpRequest(
      email: email,
      password: password,
      roles: ["USER"],
    ).toMap();

    final Response response = await post(
      signUpUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return await signIn(email, password);
    }

    throw HttpException(jsonDecode(response.body)["message"]);
  }

  Future<WSongsUser> signIn(String email, String password) async {
    final String signInUrl = "$API_URL$_AUTH_PATH/signin";
    final Map requestBody = SignInRequest(
      email: email,
      password: password,
    ).toMap();

    final response = await post(
      signInUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    var jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final SignInResponse signInResponse = SignInResponse.fromMap(
        jsonBody,
      );
      WSongsUser user = _userFromSignInResponse(signInResponse);
      await _saveAccessToken(signInResponse.accessToken);
      _updateUser(user);
      return user;
    }

    throw HttpException(jsonBody["error"]);
  }

  Future tryToLogin() async {
    _accessToken = await _tryToGetAuthToken();

    WSongsUser user;
    if (accessToken is String) {
      final String url = "$API_URL/users";
      final response = await post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": 'Bearer $accessToken',
        },
        body: jsonEncode({"accessToken": accessToken}),
      );
      if (response.statusCode != 200) {
        print(
          "Status code: ${response.statusCode}, message: ${jsonDecode(response.body)}",
        );
        _updateUser(user);
        return user;
      }
      final signInResponse = SignInResponse.fromMap(jsonDecode(response.body));
      user = _userFromSignInResponse(signInResponse);
    }

    _updateUser(user);
    return user;
  }

  Future logOut() async {
    await _removeAccessToken();
    _updateUser(null);
  }

  WSongsUser _userFromSignInResponse(SignInResponse signInResponse) {
    return WSongsUser(
      uuid: signInResponse.id,
      email: signInResponse.email,
      creationDate: signInResponse.creationDate,
      enabled: signInResponse.enabled,
      lastSignIn: signInResponse.lastSignInDate,
      role: signInResponse.roles,
    );
  }

  void _updateUser(WSongsUser user) {
    authStatus =
        user == null ? AuthStatus.UNAUTHENTICATED : AuthStatus.AUTHENTICATED;
    _user = user;
    notifyListeners();
  }

  Future<String> _tryToGetAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.get(_ACCESS_TOKEN_KEY);
    return accessToken;
  }

  Future _saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ACCESS_TOKEN_KEY, accessToken);
    _accessToken = accessToken;
    print("Access token has saved");
  }

  Future _removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ACCESS_TOKEN_KEY);
    _accessToken = null;
  }
}
