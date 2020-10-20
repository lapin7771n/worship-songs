part of 'request_lyrics_bloc.dart';

@immutable
abstract class RequestLyricsState {
  const RequestLyricsState();

  String getTitle(BuildContext context);

  String getDescription(BuildContext context);

  String getButtonText(BuildContext context);

  Widget getPage(BuildContext context);

  double get progress;
}

mixin CompletedStep {}

class RequestLyricsInitial extends RequestLyricsState {
  @override
  String getTitle(BuildContext context) {
    return Strings.of(context).generalInfo;
  }

  @override
  String getDescription(BuildContext context) {
    return Strings.of(context).addSongNameAndArtist;
  }

  @override
  String getButtonText(BuildContext context) {
    return Strings.of(context).nextToLyrics;
  }

  @override
  double get progress => 0.3;

  const RequestLyricsInitial();

  @override
  Widget getPage(BuildContext context) {
    return RequestFirstStepPage();
  }
}

class RequestLyricsSongNameAddedState extends RequestLyricsInitial {}

class RequestLyricsArtistAddedState extends RequestLyricsInitial {}

class RequestLyricsFirstStepCompleted extends RequestLyricsInitial
    with CompletedStep {
  final String songName;
  final int artistId;

  const RequestLyricsFirstStepCompleted(this.songName, this.artistId);
}

class RequestLyricsSecondStepInitial extends RequestLyricsState {
  @override
  String getTitle(BuildContext context) {
    return Strings.of(context).addLyrics;
  }

  @override
  String getDescription(BuildContext context) {
    return Strings.of(context).addLyricsAndChords;
  }

  @override
  String getButtonText(BuildContext context) {
    return Strings.of(context).nextToReview;
  }

  @override
  double get progress => 0.6;

  const RequestLyricsSecondStepInitial();

  @override
  Widget getPage(BuildContext context) {
    return RequestSecondStepPage();
  }
}

class RequestLyricsLanguageAddedState extends RequestLyricsSecondStepInitial {}

class RequestLyricsSongTextState extends RequestLyricsSecondStepInitial {}

class RequestLyricsSecondStepCompleted extends RequestLyricsSecondStepInitial
    with CompletedStep {
  final String songName;
  final int artistId;
  final String languageCode;
  final String songText;

  const RequestLyricsSecondStepCompleted({
    this.songName,
    this.artistId,
    this.languageCode,
    this.songText,
  });
}

class RequestLyricsReviewInitial extends RequestLyricsState {
  @override
  String getTitle(BuildContext context) {
    return Strings.of(context).review;
  }

  @override
  String getDescription(BuildContext context) {
    return Strings.of(context).bePreciseAndReviewAllInformation;
  }

  @override
  String getButtonText(BuildContext context) {
    return Strings.of(context).submitRequest;
  }

  @override
  double get progress => 0.9;

  const RequestLyricsReviewInitial();

  @override
  Widget getPage(BuildContext context) {
    return RequestReviewStepPage();
  }
}

class RequestLyricsReviewCompleted extends RequestLyricsReviewInitial
    with CompletedStep {
  final Song song;

  RequestLyricsReviewCompleted(this.song);
}

class RequestLyricsSentInitial extends RequestLyricsState {
  @override
  String getButtonText(BuildContext context) {
    return Strings.of(context).close;
  }

  @override
  String getTitle(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  String getDescription(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  double get progress => throw UnimplementedError();

  @override
  Widget getPage(BuildContext context) {
    // TODO: implement getPage
    throw UnimplementedError();
  }
}
