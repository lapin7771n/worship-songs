import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/data/artist.dart';

import 'base_provider.dart';

class ArtistsProvider extends BaseProvider {
  static const String ROUTE = 'artists';

  final String accessToken;

  ArtistsProvider({
    @required this.accessToken,
  });

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
    return Future.value(response.statusCode == 201);
  }

  Future _uploadArtistCover(int artistID, String imagePath) async {
    var reference = FirebaseStorage().ref().child('artists/covers/$artistID');
    var uploadTask = reference.putFile(File(imagePath));
    return await (await uploadTask.onComplete).ref.getDownloadURL();
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
