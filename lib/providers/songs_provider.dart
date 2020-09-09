import 'dart:convert';
import 'dart:io';

import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/base_provider.dart';

class SongsProvider extends BaseProvider {
  static const int _LIMIT = 40;

  final List<Song> _songs;
  final String _accessToken;

  int currentPage = 0;

  List<Song> get songs => [..._songs];

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

  Future<List<Song>> getSongsById(List<int> ids) async {
    var loadSongsUrl = "$API_URL/songs/?ids=${ids.join(",")}";
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
    final response = await get(url, _accessToken);
    if (response.statusCode != 200) {
      return Future.error(throw HttpException(
        "Status code: ${response.statusCode} | " + jsonDecode(response.body).toString(),
      ));
    }
    final List loadedSongs = jsonDecode(response.body);
    return loadedSongs.map((e) => Song.fromMap(e)).toList();
  }
}
