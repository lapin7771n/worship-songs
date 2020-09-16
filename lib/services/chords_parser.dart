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

  final String _chordsLine;

  const ChordsParser(this._chordsLine);

  List<String> get getChordsSet {
    // print(_chordsLine);
    final matches = _regExp.allMatches(_chordsLine);

    return matches
        .where((element) => element.group(0).trim().isNotEmpty)
        .map((e) => e.group(0))
        .toSet().toList();
  }

  List<String> transpose(int amount) {
    print("Old: $getChordsSet");
    return getChordsSet.map((e) {
      final i = scale.indexOf(e) + amount % scale.length;
      return scale[i > scale.length ? i + scale.length : i];
    }).toSet().toList();
  }
}
