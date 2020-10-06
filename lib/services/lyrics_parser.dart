class LyricsParser {
  String convert(String text) {
    return text.replaceAll(RegExp(r"^.\b"), ". ");
  }
}
