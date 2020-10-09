import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageRepository {
  final StorageReference _storageReference = FirebaseStorage().ref();

  ///
  /// Artist
  ///

  Future<String> uploadArtistCover(int artistUuid, String imagePath) async {
    return _uploadFile(getArtistCoverPath(artistUuid), File(imagePath));
  }

  Future removeArtistCover(int artistUuid) async {
    return _removeFile(getArtistCoverPath(artistUuid));
  }

  String getArtistCoverPath(int uuid) {
    return _rootFolder + "artists/covers/$uuid";
  }

  Future<String> _uploadFile(String path, File file) async {
    final StorageReference reference = _storageReference.child(path);
    final StorageUploadTask uploadTask = reference.putFile(file);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future _removeFile(String path) async {
    final reference = FirebaseStorage().ref().child(path);
    return await reference.delete();
  }

  String get _rootFolder {
    if (kReleaseMode) {
      return "release/";
    }
    return "debug/";
  }
}
