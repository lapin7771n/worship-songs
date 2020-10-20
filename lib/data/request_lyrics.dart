import 'artist.dart';

class RequestedLyrics {
  String title;
  Artist artist;
  String languageCode;
  String lyrics;
  String requestedBy;
  DateTime requestDate;

  RequestedLyrics({
    this.title,
    this.artist,
    this.languageCode,
    this.lyrics,
    this.requestedBy,
    this.requestDate,
  });

  RequestedLyrics.empty()
      : title = null,
        artist = null,
        languageCode = null,
        lyrics = null,
        requestedBy = null,
        requestDate = DateTime.now();
}
