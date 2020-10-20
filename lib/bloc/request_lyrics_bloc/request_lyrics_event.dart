part of 'request_lyrics_bloc.dart';

@immutable
abstract class RequestLyricsEvent {}

class RequestLyricsSongNameAdded extends RequestLyricsEvent {
  final String songName;

  RequestLyricsSongNameAdded(this.songName);
}

class RequestLyricsArtistAdded extends RequestLyricsEvent {
  final Artist artist;

  RequestLyricsArtistAdded(this.artist);
}

class RequestLyricsLanguageChosen extends RequestLyricsEvent {
  final String languageCode;

  RequestLyricsLanguageChosen(this.languageCode);
}

class RequestLyricsTextChanged extends RequestLyricsEvent {
  final String songText;

  RequestLyricsTextChanged(this.songText);
}

class RequestLyricsNextStepClicked extends RequestLyricsEvent {}
class RequestLyricsBackClicked extends RequestLyricsEvent {}
