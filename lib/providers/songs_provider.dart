import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class SongsProvider extends BaseProvider {
  static const String _SONGS = 'songs';
  static const String _TITLE_FIELD = 'title';
  static const int _LIMIT = 40;

  final List<Song> _songs;
  final String _accessToken;

  int currentPage = 0;

  UnmodifiableListView<Song> get songs => UnmodifiableListView(_songs);

  SongsProvider(this._accessToken, this._songs);

  Future<void> loadSongs() async {
    print('Fetching more songs... (current number of songs: ${_songs.length})');

    var loadSongsUrl = "$API_URL/songs?page=$currentPage&size=$_LIMIT";

    final songs = await _getSongsByUrl(loadSongsUrl);
    _songs.addAll(songs);

    currentPage++;
    notifyListeners();
    print('Songs fetched (current number of songs: ${_songs.length})');
  }

  Future<List<Song>> getSongsById(List<String> ids) async {
    var loadSongsUrl = "$API_URL/songs/?ids=$ids";
    return await _getSongsByUrl(loadSongsUrl);
  }

  Future<List<Song>> finByTitle(String title) async {
    var loadSongsUrl = "$API_URL/songs?title=$title";
    return await _getSongsByUrl(loadSongsUrl);
  }

  clearLoadedSongs() {
    _songs.clear();
    currentPage = 0;
  }

  Future addSong(Song song) {
    throw UnimplementedError();
//    return Firestore.instance.collection(_SONGS).add(song.toJson());
  }

  Future<List<Song>> _getSongsByUrl(String url) async {
    final response = await get(url, headers: {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $_accessToken"
    });
    final List loadedSongs = jsonDecode(response.body);
    return loadedSongs.map((e) => Song.fromMap(e)).toList();
  }
}
