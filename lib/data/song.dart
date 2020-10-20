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
const String _LANGUAGE = 'language';
const String _VIEWS = 'views';
const String _DATE_REQUESTED = 'dateRequested';
const String _REQUESTED_BY = 'requestedBy';

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
  final String language;

  final int artistID;
  final int albumID;
  final int views;

  final DateTime dateRequested;
  final String requestedBy;

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
    this.language,
    this.artistID,
    this.albumID,
    this.views = 0,
    this.dateRequested,
    this.requestedBy,
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
        language = data[_LANGUAGE],
        artistID = data[_ARTIST],
        albumID = data[_ALBUM],
        views = data[_VIEWS],
        dateRequested = data[_DATE_REQUESTED],
        requestedBy = data[_REQUESTED_BY];

  Map<String, dynamic> toJson() {
    return {
      _ID: uuid,
      _TITLE: title,
      _TEXT: text,
      _AUTHOR: author,
      _KEY: key,
      _AKA: aka,
      _CAPO: capo,
      _COPYRIGHT: copyright,
      _PRESENTATION: presentation,
      _LANGUAGE: language,
      _ARTIST: artistID,
      _ALBUM: albumID,
      _VIEWS: views,
      _DATE_REQUESTED: dateRequested,
      _REQUESTED_BY: requestedBy,
    };
  }

  bool get hasChords {
    return text
        .split("\n")
        .where((element) => ChordsParser.isChordsLine(element))
        .isNotEmpty;
  }

  @override
  String toString() {
    return 'Song{uuid: $uuid, title: $title, text: $text, author: $author, '
        'key: $key, aka: $aka, capo: $capo, copyright: $copyright, '
        'presentation: $presentation, artistID: $artistID, albumID: $albumID}';
  }
}
