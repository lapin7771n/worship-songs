import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/request_lyrics.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/repositories/request_lyrics_repository.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_first_step_page.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_review_step_page.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_second_step_page.dart';

part 'request_lyrics_event.dart';

part 'request_lyrics_state.dart';

class RequestLyricsBloc extends Bloc<RequestLyricsEvent, RequestLyricsState> {
  final RequestLyricsRepository requestLyricsRepository;
  final RequestedLyrics requestedLyrics = RequestedLyrics.empty();

  int currentPage = 0;

  RequestLyricsBloc(this.requestLyricsRepository)
      : super(RequestLyricsInitial());

  @override
  Stream<RequestLyricsState> mapEventToState(
    RequestLyricsEvent event,
  ) async* {
    if (event is RequestLyricsSongNameAdded) {
      yield* _mapRequestSongNameAddedToState(event);
    } else if (event is RequestLyricsArtistAdded) {
      yield* _mapRequestArtistAddedToState(event);
    } else if (event is RequestLyricsNextStepClicked) {
      yield* _mapRequestNextStepToState();
    } else if (event is RequestLyricsLanguageChosen) {
      yield* _mapRequestLanguageToState(event);
    } else if (event is RequestLyricsTextChanged) {
      yield* _mapRequestSongTextToState(event);
    } else if (event is RequestLyricsBackClicked) {
      yield* _mapRequestBackToState();
    }
  }

  Stream<RequestLyricsState> _mapRequestSongNameAddedToState(
      RequestLyricsSongNameAdded event) async* {
    requestedLyrics.title = event.songName;
    if (requestedLyrics.artist != null) {
      yield RequestLyricsFirstStepCompleted(
        requestedLyrics.title,
        requestedLyrics.artist.uuid,
      );
    } else {
      yield RequestLyricsSongNameAddedState();
    }
  }

  Stream<RequestLyricsState> _mapRequestArtistAddedToState(
      RequestLyricsArtistAdded event) async* {
    requestedLyrics.artist = event.artist;
    if (requestedLyrics.title != null) {
      yield RequestLyricsFirstStepCompleted(
        requestedLyrics.title,
        requestedLyrics.artist.uuid,
      );
    } else {
      yield RequestLyricsArtistAddedState();
    }
  }

  Stream<RequestLyricsState> _mapRequestNextStepToState() async* {
    switch (currentPage) {
      case 0:
        currentPage = 1;
        yield RequestLyricsSecondStepInitial();
        break;
      case 1:
        currentPage = 2;
        yield RequestLyricsReviewInitial();
        break;
      case 2:
        currentPage = 3;
        yield RequestLyricsSentInitial();
        break;
    }
  }

  Stream<RequestLyricsState> _mapRequestBackToState() async* {
    switch (currentPage) {
      case 1:
        currentPage = 0;
        yield RequestLyricsFirstStepCompleted(
          requestedLyrics.title,
          requestedLyrics.artist.uuid,
        );
        break;
      case 2:
        currentPage = 1;
        yield RequestLyricsSecondStepCompleted();
        break;
    }
  }

  Stream<RequestLyricsState> _mapRequestLanguageToState(
      RequestLyricsLanguageChosen event) async* {
    requestedLyrics.languageCode = event.languageCode;
    if (requestedLyrics.lyrics != null) {
      yield RequestLyricsSecondStepCompleted(
        languageCode: requestedLyrics.languageCode,
        artistId: requestedLyrics.artist.uuid,
        songName: requestedLyrics.title,
        songText: requestedLyrics.lyrics,
      );
    } else {
      yield RequestLyricsLanguageAddedState();
    }
  }

  Stream<RequestLyricsState> _mapRequestSongTextToState(
      RequestLyricsTextChanged event) async* {
    requestedLyrics.lyrics = event.songText;
    if (requestedLyrics.languageCode != null) {
      yield RequestLyricsSecondStepCompleted(
        languageCode: requestedLyrics.languageCode,
        artistId: requestedLyrics.artist.uuid,
        songName: requestedLyrics.title,
        songText: requestedLyrics.lyrics,
      );
    } else {
      yield RequestLyricsSongTextState();
    }
  }
}
