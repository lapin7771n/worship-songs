import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class SongsProvider extends BaseProvider {
  static const int _LIMIT = 40;
  static List<String> supportedLanguages = [
    if (!Platform.isIOS || !kReleaseMode) 'en',
    'ru',
    'ua'
  ];

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

  Future<List<Song>> loadSongs() async {
    print('Fetching more songs... (current number of songs: ${_songs.length})');

    final loadSongsUrl =
        "$API_URL/songs?page=$currentPage&size=$_LIMIT&lang=${languagesToLoad.join(',')}";

    final songs = await _getSongsByUrl(loadSongsUrl);
    _songs.addAll(songs);

    currentPage++;
    notifyListeners();
    print('Songs fetched (current number of songs: ${_songs.length})');
    return songs;
  }

  Future<List<Song>> getSongsById(List<int> ids) async {
    final loadSongsUrl = "$API_URL/songs/?ids=${ids.join(",")}";
    return await _getSongsByUrl(loadSongsUrl);
  }

  Future<List<Song>> finByTitle(String title, [int limit = 20]) async {
    final loadSongsUrl =
        "$API_URL/songs?title=$title&lang=${languagesToLoad.join(',')}&size=$limit";
    return await _getSongsByUrl(loadSongsUrl);
  }

  Future<List<Song>> findByArtistId(int artistId) async {
    final url = '$API_URL/songs/artist/$artistId';
    return await _getSongsByUrl(url);
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

  Future<bool> remove(int uuid) async {
    final url = '$API_URL/songs/$uuid';
    final response = await delete(url, accessToken);
    return Future.value(response.statusCode == 200);
  }

  Future count() async {
    final url = '$API_URL/songs/count';
    final response = await get(url, accessToken);
    return jsonDecode(response.body);
  }

  clearLoadedSongs() {
    _songs.clear();
    currentPage = 0;
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
