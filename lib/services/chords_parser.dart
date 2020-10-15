class ChordsParser {
  static final RegExp _regExp = RegExp(r'[CDEFGABH]' + '(b|bb)?' + '(#)?');

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
    // chord = _regExp.stringMatch(chord);
    var indexOf = scale.indexOf(chord);
    var length = scale.length;
    final index = (indexOf + amount) % length;
    return scale[index];
  }

  static String transposeSong(String songText, int amount) {
    final transposedText = songText.split('\n').map((e) {
      if (isChordsLine(e)) {
        return e.replaceAllMapped(
            _regExp, (match) => transposeChord(match.group(0), amount));
      }
      return e;
    }).join('\n');
    return transposedText;
  }

  static bool isChordsLine(String line) {
    var split = line.trim().split(" ");
    split.removeWhere((e) => e.trim().isEmpty || e.trim().contains("."));
    return split.where((element) => element.contains(_regExp)).length >=
        split.length;
  }
}
