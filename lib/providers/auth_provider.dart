import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worshipsongs/data/auth_status.dart';
import 'package:worshipsongs/data/payloads/requests/sign_in_request.dart';
import 'package:worshipsongs/data/payloads/requests/sign_up_request.dart';
import 'package:worshipsongs/data/payloads/responses/sign_in_response.dart';
import 'package:worshipsongs/data/user.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class AuthProvider extends BaseProvider {
  static const String _AUTH_PATH = '/api/v1/auth';
  static const String _ACCESS_TOKEN_KEY = "accessToken";

  User _user;
  String _accessToken;

  User get user {
    return _user;
  }

  String get accessToken {
    return _accessToken;
  }

  AuthStatus authStatus = AuthStatus.UNINITIALIZED;

  Future<User> createUser(String email, String password) async {
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

  Future<User> signIn(String email, String password) async {
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

    if (response.statusCode == 200) {
      final SignInResponse signInResponse = SignInResponse.fromMap(
        jsonDecode(response.body),
      );
      User user = _userFromSignInResponse(signInResponse);
      await _saveAccessToken(signInResponse.accessToken);
      _updateUser(user);
      return user;
    }

    return null;
  }

  Future signInViaGoogle() async {
    throw UnimplementedError();
  }

  Future tryToLogin() async {
    _accessToken = await _tryToGetAuthToken();

    User user;
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
      final signInResponse = SignInResponse.fromMap(jsonDecode(response.body));
      user = _userFromSignInResponse(signInResponse);
    }

    _updateUser(user);
    return user;
  }

  Future logOut() async {
    authStatus = AuthStatus.UNAUTHENTICATED;
    _user = null;
    await _removeAccessToken();
    notifyListeners();
  }

  User _userFromSignInResponse(SignInResponse signInResponse) {
    final User user = User(
      uuid: signInResponse.id,
      email: signInResponse.email,
      creationDate: signInResponse.creationDate,
      enabled: signInResponse.enabled,
      lastSignIn: signInResponse.lastSignInDate,
      role: signInResponse.roles,
    );
    return user;
  }

  void _updateUser(User user) {
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
  }
}
