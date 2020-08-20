import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';

class SongsProvider with ChangeNotifier {
  static const String _SONGS = 'songs';
  static const String _TITLE_FIELD = 'title';
  static const int _LIMIT = 40;

  final List<Song> _songs = [];

  DocumentSnapshot _lastSongSnapshot;

  UnmodifiableListView<Song> get songs => UnmodifiableListView(_songs);

  int get loadedSongsSize => _songs.length;

  Future<void> loadSongs() async {
    Query songsCollectionQuery = Firestore.instance
        .collection(_SONGS)
        .limit(_LIMIT)
        .orderBy(_TITLE_FIELD);

    if (_lastSongSnapshot != null) {
      songsCollectionQuery =
          songsCollectionQuery.startAfterDocument(_lastSongSnapshot);
    }

    print('Fetching more songs... (current number of songs: ${_songs.length})');
    final loadedSongs = await songsCollectionQuery.getDocuments();
    final List<DocumentSnapshot> documents = loadedSongs.documents;
    _lastSongSnapshot = documents.last;
    _songs.addAll(documents.map((e) => Song.fromMap(e.documentID, e.data)));
    _songs.sort((s1, s2) => s1.title.compareTo(s2.title));
    notifyListeners();
    print('Songs fetched (current number of songs: ${_songs.length})');
  }

  Future<List<Song>> getSongsById(List<String> ids) async {
    final List<DocumentReference> songsRef = ids
        .map((e) => Firestore.instance.collection(_SONGS).document(e))
        .toList();
    final songs = songsRef.map((element) async {
      final docSnapshot = await element.get();
      return Song.fromMap(docSnapshot.documentID, docSnapshot.data);
    });
    return await Future.wait(songs);
  }

  Future<List<Song>> finByTitle(String title) async {
    final QuerySnapshot snapshot = await Firestore.instance
        .collection(_SONGS)
        .orderBy(_TITLE_FIELD)
        .where(_TITLE_FIELD, isGreaterThanOrEqualTo: title)
        .getDocuments();
    return snapshot.documents
        .map((e) => Song.fromMap(e.documentID, e.data))
        .toList();
  }

  clearLoadedSongs() {
    _songs.clear();
    _lastSongSnapshot = null;
  }

  Future<DocumentReference> addSong(Song song) {
    throw UnimplementedError();
//    return Firestore.instance.collection(_SONGS).add(song.toJson());
  }
}
