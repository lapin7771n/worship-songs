import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content_requests/requested_song.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/repositories/request_lyrics_repository.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_first_step_page.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_review_step_page.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_second_step_page.dart';

part 'request_lyrics_event.dart';

part 'request_lyrics_state.dart';

class RequestLyricsBloc extends Bloc<RequestLyricsEvent, RequestLyricsState> {
  final RequestSongsRepository requestLyricsRepository;
  final RequestedSong requestedSong = RequestedSong();

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
    requestedSong.title = event.songName;
    if (requestedSong.artistId != null) {
      yield RequestLyricsFirstStepCompleted(
        requestedSong.title,
        requestedSong.artistId,
      );
    } else {
      yield RequestLyricsSongNameAddedState();
    }
  }

  Stream<RequestLyricsState> _mapRequestArtistAddedToState(
      RequestLyricsArtistAdded event) async* {
    requestedSong.artist = event.artist;
    if (requestedSong.title != null) {
      yield RequestLyricsFirstStepCompleted(
        requestedSong.title,
        requestedSong.artist.uuid,
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
          requestedSong.title,
          requestedSong.artist.uuid,
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
    requestedSong.languageCode = event.languageCode;
    if (requestedSong.lyrics != null) {
      yield RequestLyricsSecondStepCompleted(
        languageCode: requestedSong.languageCode,
        artistId: requestedSong.artist.uuid,
        songName: requestedSong.title,
        songText: requestedSong.lyrics,
      );
    } else {
      yield RequestLyricsLanguageAddedState();
    }
  }

  Stream<RequestLyricsState> _mapRequestSongTextToState(
      RequestLyricsTextChanged event) async* {
    requestedSong.lyrics = event.songText;
    if (requestedSong.languageCode != null) {
      yield RequestLyricsSecondStepCompleted(
        languageCode: requestedSong.languageCode,
        artistId: requestedSong.artist.uuid,
        songName: requestedSong.title,
        songText: requestedSong.lyrics,
      );
    } else {
      yield RequestLyricsSongTextState();
    }
  }
}
