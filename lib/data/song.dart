
const String _TITLE = 'title';
const String _TEXT = 'text';
const String _AUTHOR = 'author';
const String _KEY = 'key';
const String _AKA = 'aka';
const String _CAPO = 'capo';
const String _COPYRIGHT = 'copyright';
const String _PRESENTATION = 'presentation';

class Song {
  final String uuid;
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

  static Song fromMap(String uid, Map<String, dynamic> data) {
    return Song(
      uuid: uid,
      title: data['title'],
      author: data['author'] ?? 'Unknown',
      aka: data['aka'],
      text: data['text'],
      capo: data['capo'],
      copyright: data['copyright'],
      presentation: data['presentation'],
    );
  }

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

  String get formattedText {
    var formattedText =
        text
            .replaceAll('[V', '<bold>Verse ')
            .replaceAll('[C', '<bold>Chorus ')
            .replaceAll(']', '</bold>');
    return formattedText;
  }
}
