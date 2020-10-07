import 'package:flutter/foundation.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/admin_portal/providers/content.dart';
import 'package:worshipsongs/services/debouncer.dart';

class NewContentProvider with ChangeNotifier {
  final ContentType contentType;
  final ArtistsProvider artistsProvider;
  final SongsProvider songsProvider;

  final _debouncer = Debouncer(milliseconds: 300);

  NewContentProvider({
    this.contentType,
    this.songsProvider,
    this.artistsProvider,
  });

  Content _content = Content.empty();

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

  Future _saveLyrics() async {
    assert(_content.title != null);
    assert(_content.description != null);
    assert(_content.relatedToArtist != null);

    return songsProvider.create(Song(
      title: _content.title,
      text: _content.description,
      artistID: _content.relatedToArtist.uuid,
      albumID: _content.relatedToAlbum,
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
        return content.title != null &&
            (content.description != null && content.description.isNotEmpty) &&
            content.relatedToArtist != null;
        break;
      case ContentType.album:
        return content.title != null && content.relatedToArtist != null;
        break;
      case ContentType.artist:
        return content.title != null &&
            (content.description != null && content.description.isNotEmpty) &&
            content.imagePath != null;
        break;
    }
    throw UnsupportedError("Unsupported content type: $content");
  }
}
