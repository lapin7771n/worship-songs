import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/songs_provider.dart';

class FavoriteSongsProvider with ChangeNotifier {
  static const String _FAVORITE_SONGS = 'favorite_songs';

  FavoriteSongsProvider({
    @required String userId,
    @required SongsProvider songsProvider,
    List<Song> favSongs = const [],
  })  : _favSongs = favSongs,
        _userId = userId,
        _songsProvider = songsProvider;

  final List<Song> _favSongs;
  final String _userId;
  final SongsProvider _songsProvider;

  UnmodifiableListView<Song> get songs => UnmodifiableListView(_favSongs);

  int get loadedSongsSize => _favSongs.length;

  Future add(int songId) async {
    // final future = await Firestore.instance
    //     .collection(_FAVORITE_SONGS)
    //     .document(_userId)
    //     .setData({
    //   songId: null,
    // }, merge: true);
    await getAll();
    // return future;
  }

  Future remove(int songId) async {
    // final future = await Firestore.instance
    //     .collection(_FAVORITE_SONGS)
    //     .document(_userId)
    //     .setData({
    //   songId: FieldValue.delete(),
    // }, merge: true);
    _favSongs.removeWhere((element) => element.uuid == songId);
    notifyListeners();
    // return future;
  }

  Future<List> getAll() async {
    // final DocumentSnapshot snapshot = await Firestore.instance
    //     .collection(_FAVORITE_SONGS)
    //     .document(_userId)
    //     .get();
    // final List<String> songsKeys = snapshot.data?.keys?.toList() ?? [];
    // final List<Song> favSongs = await _songsProvider.getSongsById(songsKeys);
    // _favSongs.clear();
    // _favSongs.addAll(favSongs);
    // notifyListeners();
    // return songs;
  }

  Future<bool> isFavorite(int songId) async {
    if (_favSongs.isEmpty) {
      await getAll();
    }

    return _favSongs.where((element) => element.uuid == songId).isNotEmpty;
  }
}
