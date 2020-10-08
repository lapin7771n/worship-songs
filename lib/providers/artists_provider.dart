import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/services/storage_repository.dart';

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

  /// Method to create and update Artist
  Future<bool> create(Artist artist, String imagePath) async {
    final response = await put(
      '$API_URL/$ROUTE',
      accessToken,
      artist.encodedJson,
    );
    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final id = body["id"];
      final downloadUrl = await StorageRepository().uploadArtistCover(
        id,
        imagePath,
      );
      artist.imageUrl = downloadUrl;
      artist.uuid = id;
      put('$API_URL/$ROUTE', accessToken, artist.encodedJson);
    }
    notifyListeners();
    return Future.value(response.statusCode == 201);
  }

  ///Method to fetch $_current page of Artists
  ///to fetch first page call ArtistsProvider::dispose first
  Future<List<Artist>> read() async {
    final url = '$API_URL/$ROUTE?page=$_currentPage';

    final parsedArtists = await _getByUrl(url);
    _loadedArtists.addAll(parsedArtists);
    _loadedArtists = _loadedArtists.toSet().toList();
    _currentPage++;
    notifyListeners();
    return _loadedArtists.toList();
  }

  ///Method to remove Artist
  Future<bool> remove(int uuid) async {
    final url = '$API_URL/$ROUTE/$uuid';
    final response = await delete(url, accessToken);
    await StorageRepository().removeArtistCover(uuid);
    return response.statusCode == 204;
  }

  Future<List<Artist>> findByTitle(String title) async {
    final url = '$API_URL/$ROUTE?title=$title';
    return _getByUrl(url);
  }

  Future count() async {
    final url = '$API_URL/$ROUTE/count';
    final response = await get(url, accessToken);
    return jsonDecode(response.body);
  }

  void dispose() {
    _loadedArtists.clear();
    _currentPage = 0;
  }

  Future<List<Artist>> _getByUrl(String url) async {
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
