import 'package:flutter/material.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_all_lyrics/category_all_lyrics.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_artists/artists_list_screen.dart';

class CategoryScreen extends StatelessWidget {
  static const String routeName = '/category-screen';

  @override
  Widget build(BuildContext context) {
    final ContentType contentType = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(contentType.name(context)),
        centerTitle: false,
        elevation: 0,
      ),
      body: buildBody(contentType, context),
    );
  }

  Widget buildBody(ContentType contentType, BuildContext context) {
    switch (contentType) {
      case ContentType.lyrics:
        return CategoryAllLyricsScreen();
      case ContentType.album:
        // TODO: Handle this case.
        break;
      case ContentType.artist:
        return ArtistsListScreen();
    }
    throw UnsupportedError('Unsupported content type $contentType');
  }
}
