import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/data/artist.dart';

import 'base_provider.dart';

class ArtistsProvider extends BaseProvider {
  static const String ROUTE = 'artists';

  final String accessToken;

  List<Artist> _loadedArtists = List();
  int _currentPage = 0;

  ArtistsProvider({
    @required this.accessToken,
  });

  List<Artist> get loadedArtists => [..._loadedArtists];

  Future<bool> create(Artist artist, String imagePath) async {
    final response = await put(
      '$API_URL/$ROUTE',
      accessToken,
      artist.encodedJson,
    );
    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final id = body["id"];
      final downloadUrl = await _uploadArtistCover(id, imagePath);
      artist.imageUrl = downloadUrl;
      artist.uuid = id;
      put('$API_URL/$ROUTE', accessToken, artist.encodedJson);
    }
    notifyListeners();
    return Future.value(response.statusCode == 201);
  }

  Future _uploadArtistCover(int artistID, String imagePath) async {
    var reference = FirebaseStorage().ref().child('artists/covers/$artistID');
    var uploadTask = reference.putFile(File(imagePath));
    notifyListeners();
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<List<Artist>> read() async {
    final url = '$API_URL/$ROUTE?page=$_currentPage';

    final parsedArtists = await getByUrl(url);
    _loadedArtists.addAll(parsedArtists);
    _loadedArtists = _loadedArtists.toSet().toList();
    _currentPage++;
    notifyListeners();
    return _loadedArtists.toList();
  }

  Future<List<Artist>> findByTitle(String title) async {
    final url = '$API_URL/$ROUTE?title=$title';
    return getByUrl(url);
  }

  Future<List<Artist>> getByUrl(String url) async {
    final response = await get(url, accessToken);
    if (response.statusCode != 200) {
      return Future.error(
        throw HttpException(
          "Status code: ${response.statusCode} | " + jsonDecode(response.body),
        ),
      );
    }

    final List loadedArtistsJson = jsonDecode(response.body);
    return loadedArtistsJson.map((e) => Artist.fromMap(e)).toList();
  }

  void dispose() {
    _loadedArtists.clear();
    _currentPage = 0;
    notifyListeners();
  }
}

extension ArtistSerializable on Artist {
  String get encodedJson {
    return jsonEncode({
      if (uuid != null) 'id': uuid,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'creationDate': dateCreated.toIso8601String(),
      'lastEditDate': dateEdited.toIso8601String(),
    });
  }
}
