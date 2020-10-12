import 'package:flutter/foundation.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/services/debouncer.dart';

class NewContentProvider with ChangeNotifier {
  final _debouncer = Debouncer(milliseconds: 300);

  final ContentType contentType;
  final ArtistsProvider artistsProvider;
  final SongsProvider songsProvider;

  Content _content;

  NewContentProvider({
    @required this.contentType,
    @required this.songsProvider,
    @required this.artistsProvider,
    Content content,
  }) : _content = content;

  set title(String title) {
    _content.title = title;
    _updateIsContentValid();
  }

  set localImagePath(String localImagePath) {
    _content.imagePath = localImagePath;
    _updateIsContentValid();
  }

  set description(String description) {
    _content.description = description;
    _updateIsContentValid();
  }

  set artist(Artist artist) {
    _content.relatedToArtist = artist;
    _updateIsContentValid();
  }

  set albumID(int albumID) {
    _content.relatedToAlbum = albumID;
    _updateIsContentValid();
  }

  set dateCreated(DateTime dateCreated) {
    _content.dateCreated = dateCreated;
    _updateIsContentValid();
  }

  set dateEdited(DateTime dateEdited) {
    _content.dateEdited = dateEdited;
    _updateIsContentValid();
  }

  set languageCode(String languageCode) {
    _content.languageCode = languageCode;
    _updateIsContentValid();
  }

  Content get content => _content;

  bool isContentValid = false;

  void _updateIsContentValid() {
    _debouncer(() {
      isContentValid = contentType.isValid(_content);
      notifyListeners();
    });
  }

  Future saveContent() async {
    switch (contentType) {
      case ContentType.lyrics:
        return _saveLyrics();
        break;
      case ContentType.album:
        return _saveAlbum();
        break;
      case ContentType.artist:
        return _saveArtist();
        break;
    }
  }

  Future<bool> deleteContent() async {
    switch (contentType) {
      case ContentType.lyrics:
        return songsProvider.remove(content.uuid);
      case ContentType.album:
        // TODO: Handle this case.
        break;
      case ContentType.artist:
        return artistsProvider.remove(content.uuid);
    }
    return false;
  }

  Future _saveLyrics() async {
    assert(_content.title != null);
    assert(_content.description != null);
    assert(_content.relatedToArtist != null);

    return songsProvider.create(Song(
      uuid: _content.uuid,
      title: _content.title,
      text: _content.description,
      artistID: _content.relatedToArtist.uuid,
      albumID: _content.relatedToAlbum,
      language: content.languageCode,
    ));
  }

  Future _saveAlbum() async {
    assert(_content.title != null);
    assert(_content.relatedToArtist != null);
    // todo implement album saving
  }

  Future _saveArtist() async {
    assert(_content.title != null);

    return artistsProvider.create(
      Artist(
        uuid: content.uuid,
        title: _content.title,
        description: _content.description,
        dateEdited: _content.dateEdited,
        dateCreated: _content.dateCreated,
      ),
      _content.imagePath,
    );
  }
}

extension NewContentProviderExtention on ContentType {
  bool isValid(Content content) {
    switch (this) {
      case ContentType.lyrics:
        return isLyricsValid(content);
        break;
      case ContentType.album:
        return isAlbumValid(content);
        break;
      case ContentType.artist:
        return isArtistValid(content);
        break;
    }
    throw UnsupportedError("Unsupported content type: $content");
  }

  bool isArtistValid(Content content) {
    return content.title != null &&
        (content.description != null && content.description.isNotEmpty) &&
        content.imagePath != null;
  }

  bool isAlbumValid(Content content) =>
      content.title != null && content.relatedToArtist != null;

  bool isLyricsValid(Content content) {
    return content.title != null &&
        (content.description != null && content.description.isNotEmpty) &&
        content.relatedToArtist != null &&
        content.languageCode != null;
  }
}
