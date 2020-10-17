class ChordsParser {
  static final RegExp _singleChordRegExpr =
      RegExp(r'[CDEFGABH]' + '(b|bb)?' + '(#)?');
  static final RegExp _chordsLineRegExpr =
      RegExp(r'\b([CDEFGABH](#|##|b|bb|sus|maj|min|m|aug)?\b)');

  static const List<String> scale = [
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B"
  ];

  const ChordsParser();

  static String transposeChord(String chord, int amount) {
    var indexOf = scale.indexOf(chord);
    var length = scale.length;
    final index = (indexOf + amount) % length;
    return scale[index];
  }

  static String transposeSong(String songText, int amount) {
    final transposedText = songText.split('\n').map((e) {
      if (isChordsLine(e)) {
        return e.replaceAllMapped(_singleChordRegExpr,
            (match) => transposeChord(match.group(0), amount));
      }
      return e;
    }).join('\n');
    return transposedText;
  }

  static bool isChordsLine(String line) {
    var split =
        line.trim().split(" ").where((element) => element.trim().isNotEmpty);
    var isNotChords =
        split.where((element) => !element.contains(_chordsLineRegExpr));
    var isChords =
        split.where((element) => element.contains(_chordsLineRegExpr));
    return isChords.isNotEmpty && isChords.length >= isNotChords.length;
  }
}
