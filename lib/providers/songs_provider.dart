import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class SongsProvider extends BaseProvider {
  static const int _LIMIT = 40;
  static const List<String> supportedLanguages = const ['en', 'ru', 'ua'];

  final List<Song> _songs;
  final String accessToken;

  int currentPage = 0;

  List<String> languagesToLoad = [...supportedLanguages];

  List<Song> get songs => [..._songs];

  SongsProvider({
    @required String accessToken,
    List<Song> songs = const [],
  })  : _songs = songs,
        accessToken = accessToken;

  Future<void> loadSongs() async {
    print('Fetching more songs... (current number of songs: ${_songs.length})');

    final loadSongsUrl =
        "$API_URL/songs?page=$currentPage&size=$_LIMIT&lang=${languagesToLoad.join(',')}";

    final songs = await _getSongsByUrl(loadSongsUrl);
    _songs.addAll(songs);

    currentPage++;
    notifyListeners();
    print('Songs fetched (current number of songs: ${_songs.length})');
  }

  Future<List<Song>> getSongsById(List<int> ids) async {
    final loadSongsUrl = "$API_URL/songs/?ids=${ids.join(",")}";
    return await _getSongsByUrl(loadSongsUrl);
  }

  Future<List<Song>> finByTitle(String title) async {
    final loadSongsUrl =
        "$API_URL/songs?title=$title&lang=${languagesToLoad.join(',')}";
    return await _getSongsByUrl(loadSongsUrl);
  }

  clearLoadedSongs() {
    _songs.clear();
    currentPage = 0;
  }

  Future incrementViews(int songId) async {
    final url = '$API_URL/songs/$songId/viewings';
    final response = await put(url, accessToken, null);
    print(
      'Http Response: ${response.statusCode} | ${jsonDecode(response.body)}',
    );
  }

  Future create(Song song) async {
    final url = '$API_URL/songs';
    final result = await post(url, accessToken, jsonEncode(song.toJson()));
    print(
      "SongProvider::create: ${result.statusCode}, body: ${jsonDecode(result.body)}",
    );
    return result.statusCode == 201;
  }

  Future<List<Song>> _getSongsByUrl(String url) async {
    final response = await get(url, accessToken);
    if (response.statusCode != 200) {
      return Future.error(
        throw HttpException(
          "Status code: ${response.statusCode} | " +
              jsonDecode(response.body).toString(),
        ),
      );
    }
    final List loadedSongs = jsonDecode(response.body);
    return loadedSongs.map((e) => Song.fromMap(e)).toList();
  }
}
