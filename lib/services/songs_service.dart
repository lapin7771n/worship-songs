import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:xml/xml.dart' as xml;

class SongsService {
  static const String _SONGS = 'songs-en';
  static const String _TITLE = 'title';
  static const String _TEXT = 'text';
  static const String _AUTHOR = 'author';
  static const String _KEY = 'key';
  static const String _AKA = 'aka';
  static const String _CAPO = 'capo';
  static const String _COPYRIGHT = 'copyright';
  static const String _PRESENTATION = 'presentation';

  loadAllXmls() async {
    final Directory extStorage = await getExternalStorageDirectory();
    final enDirectory = Directory('${extStorage.path}/en');
    final List<FileSystemEntity> files = enDirectory.listSync();
    files.where((e) => e is File).map((e) => e as File).map((file) {
      final fileString = file.readAsStringSync();
      final xmlDocument = xml.parse(fileString);
      return _xmlToSong(xmlDocument);
    }).forEach((element) {
      addSong(element);
    });
  }

  Future<DocumentReference> addSong(Song song) {
    return Firestore.instance.collection(_SONGS).add(_songToJson(song));
  }

  Map<String, dynamic> _songToJson(Song song) {
    return {
      _TITLE: song.title,
      _TEXT: song.text,
      _AUTHOR: song.author,
      _KEY: song.key,
      _AKA: song.aka,
      _CAPO: song.capo,
      _COPYRIGHT: song.copyright,
      _PRESENTATION: song.presentation,
    };
  }

  Song _xmlToSong(xml.XmlDocument xmlDocument) {
    final String aka = _getValueFromXml(xmlDocument, 'aka');
    final String title = _getValueFromXml(xmlDocument, 'title');
    final String lyrics = _getValueFromXml(xmlDocument, 'lyrics');
    final String author = _getValueFromXml(xmlDocument, 'author');
    final String key = _getValueFromXml(xmlDocument, 'key');
    final String capo = _getValueFromXml(xmlDocument, 'capo');
    final String copyright = _getValueFromXml(xmlDocument, 'copyright');
    final String presentation = _getValueFromXml(xmlDocument, 'presentation');
    return Song(
      title: title,
      text: lyrics,
      aka: aka,
      author: author,
      key: key,
      capo: capo,
      copyright: copyright,
      presentation: presentation,
    );
  }

  String _getValueFromXml(xml.XmlDocument document, String key) {
    final foundElements = document.findAllElements(key);
    return foundElements.isEmpty ? null : foundElements.first.text;
  }
}
