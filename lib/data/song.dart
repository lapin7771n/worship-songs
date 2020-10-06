import 'package:worshipsongs/services/chords_parser.dart';

const String _ID = 'id';
const String _TITLE = 'title';
const String _TEXT = 'text';
const String _AUTHOR = 'author';
const String _ARTIST = 'artistID';
const String _ALBUM = 'albumID';
const String _KEY = 'chordsKey';
const String _AKA = 'aka';
const String _CAPO = 'capo';
const String _COPYRIGHT = 'copyright';
const String _PRESENTATION = 'presentation';

class Song {
  final int uuid;
  final String title;
  final String text;
  final String author;
  final String key;
  final String aka;
  final String capo;
  final String copyright;
  final String presentation;

  final int artistID;
  final int albumID;

  const Song({
    this.uuid,
    this.title,
    this.text,
    this.author = 'Unknown',
    this.key,
    this.aka,
    this.capo,
    this.copyright,
    this.presentation,
    this.artistID,
    this.albumID,
  });

  Song.fromMap(Map<String, dynamic> data)
      : uuid = data[_ID],
        title = data[_TITLE],
        author = data[_AUTHOR] ?? 'Unknown',
        aka = data[_AKA],
        text = data[_TEXT],
        capo = data[_CAPO],
        key = data[_KEY],
        copyright = data[_COPYRIGHT],
        presentation = data[_PRESENTATION],
        artistID = data[_ARTIST],
        albumID = data[_ALBUM];

  Map<String, dynamic> toJson() {
    return {
      _TITLE: title,
      _TEXT: text,
      _AUTHOR: author,
      _KEY: key,
      _AKA: aka,
      _CAPO: capo,
      _COPYRIGHT: copyright,
      _PRESENTATION: presentation,
      _ARTIST: artistID,
      _ALBUM: albumID,
    };
  }

  String formattedText([int amount = 0]) {
    String formattedText = _replaceMarkers();

    var transposedText = ChordsParser.transposeSong(formattedText, amount);
    return transposedText
        .split('\n')
        .map((e) => e.startsWith('.') ? ' <bold> ${e.substring(1)}</bold>' : e)
        .join('\n');
  }

  String get formattedTextWithoutChords {
    var formattedText = _replaceMarkers();

    return formattedText
        .split("\n")
        .where((e) => !e.startsWith("."))
        .join("\n");
  }

  String _replaceMarkers() {
    var formattedText = text
        .replaceAll('[V', '<bold>Verse ')
        .replaceAll('[C', '<bold>Chorus ')
        .replaceAll('[B', '<bold>Bridge ')
        .replaceAll('[P', '<bold>Pre-chorus ')
        .replaceAll(']', '</bold>');
    return formattedText;
  }

  @override
  String toString() {
    return 'Song{uuid: $uuid, title: $title, text: $text, author: $author, key: $key, aka: $aka, capo: $capo, copyright: $copyright, presentation: $presentation, artistID: $artistID, albumID: $albumID}';
  }
}
