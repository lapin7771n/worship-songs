import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:worshipsongs/data/favorite_song.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class FavoriteSongsProvider extends BaseProvider {
  static const String _FAV_PATH = "favorites";

  FavoriteSongsProvider({
    @required String accessToken,
    List<FavoriteSong> favSongs = const [],
  })  : _favSongs = favSongs,
        _accessToken = accessToken;

  final List<FavoriteSong> _favSongs;
  final String _accessToken;

  UnmodifiableListView<FavoriteSong> get songs =>
      UnmodifiableListView(_favSongs);

  int get loadedSongsSize => _favSongs.length;

  Future<List> getAll() async {
    final String url = "$API_URL/$_FAV_PATH";
    final response = await get(url, _accessToken);
    final List jsonBody = jsonDecode(response.body);
    return jsonBody.map((element) => FavoriteSong.fromMap(element)).toList();
  }

  Future add(int songId) async {
    final String url = "$API_URL/$_FAV_PATH";
    final response = await put(
      url,
      _accessToken,
      jsonEncode({"songId": songId}),
    );
    if (response.statusCode == 200) {
      var favoriteSong = FavoriteSong.fromMap(jsonDecode(response.body));
      _favSongs.add(favoriteSong);
      notifyListeners();
      return favoriteSong;
    }

    return Future.error(_getHttpExceptionFromResponse(response));
  }

  Future remove(int songId) async {
    final String url = "$API_URL/$_FAV_PATH/$songId";
    final http.Response response = await delete(url, _accessToken);

    if (response.statusCode == 200) {
      _favSongs.removeWhere((element) => element.songId == songId);
      notifyListeners();
      return Future.value();
    }

    return Future.error(_getHttpExceptionFromResponse(response));
  }

  Future<bool> isFavorite(int songId) async {
    final String url = "$API_URL/$_FAV_PATH/$songId";
    final http.Response response = await get(url, _accessToken);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  HttpException _getHttpExceptionFromResponse(http.Response response) {
    return HttpException("Status: ${response.statusCode} |" +
        jsonDecode(response.body)["message"]);
  }
}
