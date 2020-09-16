import 'package:worshipsongs/services/chords_parser.dart';

const String _TITLE = 'title';
const String _TEXT = 'text';
const String _AUTHOR = 'author';
const String _KEY = 'key';
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
  });

  Song.fromMap(Map<String, dynamic> data)
      : uuid = data["id"],
        title = data['title'],
        author = data['author'] ?? 'Unknown',
        aka = data['aka'],
        text = data['text'],
        capo = data['capo'],
        key = data["chordsKey"],
        copyright = data['copyright'],
        presentation = data['presentation'];

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
    };
  }

  String formattedText([int amount = 0]) {
    String formattedText = _replaceMarkers();

    final String stringsWithChorus = formattedText
        .split("\n")
        .where((element) => element.startsWith("."))
        .toList()
        .join(' , ');

    var chordsParser = ChordsParser(stringsWithChorus);
    final List<String> transposedChords = chordsParser.transpose(amount);
    final List<String> oldChords = chordsParser.getChordsSet;

    // print(transposedChords);

    return formattedText
        .split("\n")
        .map((e) => e.startsWith(".")
            ? _replaceChords(e, oldChords, transposedChords)
            : e)
        .map((e) => e.startsWith(".") ? " <bold> ${e.substring(1)} </bold>" : e)
        .toList()
        .join("\n");
  }

  String get formattedTextWithoutChords {
    var formattedText = _replaceMarkers();

    return formattedText
        .split("\n")
        .where((e) => !e.startsWith("."))
        .toList()
        .join("\n");
  }

  String _replaceChords(String text, List<String> old, List<String> newChords) {
    // print(text);
    for (int i = 0; i < old.length; i++) {
      print("${old[i]} replaced with ${newChords[i]}");
      text = text.replaceAll(old[i], newChords[i]);
    }
    return text;
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
}
