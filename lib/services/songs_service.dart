import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worshipsongs/data/song.dart';

class SongsService {
  static const String _SONGS = 'songs';

  Future<DocumentReference> addSong(Song song) {
    return Firestore.instance.collection(_SONGS).add(song.toJson());
  }

  Future<List<Song>> getSongs(int limit) async {
    final value = await Firestore.instance.collection(_SONGS)
        .limit(limit)
        .getDocuments();
    return value.documents
        .map((doc) => Song.fromMap(doc.documentID, doc.data))
        .toList();
  }
//  loadAllXmls() async {
//    final Directory extStorage = await getExternalStorageDirectory();
//    final enDirectory = Directory('${extStorage.path}/ru');
//    final List<FileSystemEntity> files = enDirectory.listSync();
//    files.where((e) => e is File).map((e) => e as File).map((file) {
//      final fileString = file.readAsStringSync();
//      final xmlDocument = xml.parse(fileString);
//      return _xmlToSong(xmlDocument);
//    }).forEach((element) {
//      addSong(element);
//    });
//  }

//  Song _xmlToSong(xml.XmlDocument xmlDocument) {
//    final String aka = _getValueFromXml(xmlDocument, 'aka');
//    final String title = _getValueFromXml(xmlDocument, 'title');
//    final String lyrics = _getValueFromXml(xmlDocument, 'lyrics');
//    final String author = _getValueFromXml(xmlDocument, 'author');
//    final String key = _getValueFromXml(xmlDocument, 'key');
//    final String capo = _getValueFromXml(xmlDocument, 'capo');
//    final String copyright = _getValueFromXml(xmlDocument, 'copyright');
//    final String presentation = _getValueFromXml(xmlDocument, 'presentation');
//    return Song(
//      title: title,
//      text: lyrics,
//      aka: aka,
//      author: author,
//      key: key,
//      capo: capo,
//      copyright: copyright,
//      presentation: presentation,
//    );
//  }
//
//  String _getValueFromXml(xml.XmlDocument document, String key) {
//    final foundElements = document.findAllElements(key);
//    return foundElements.isEmpty ? null : foundElements.first.text;
//  }
}
