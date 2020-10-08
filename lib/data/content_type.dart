import 'package:flutter/material.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/general_album_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/general_artist_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/general_lyrics_info_page.dart';

enum ContentType {
  lyrics,
  album,
  artist,
}

extension WidgetForContent on ContentType {
  Widget widget(Content content) {
    switch (this) {
      case ContentType.lyrics:
        return GeneralLyricsInfoPage();
      case ContentType.album:
        return GeneralAlbumInfo();
      case ContentType.artist:
        return GeneralArtistInfo(content);
      default:
        throw UnsupportedError("Unsupported type Error: $this");
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case ContentType.lyrics:
        return Strings.of(context).lyrics;
      case ContentType.album:
        return Strings.of(context).albums(1);
      case ContentType.artist:
        return Strings.of(context).artists(1);
      default:
        return null;
    }
  }
}
