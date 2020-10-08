import 'package:flutter/material.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/screens/admin_portal/artist_screen.dart';
import 'package:worshipsongs/screens/home_screen/home_screen.dart';

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
      body: buildBody(contentType),
    );
  }

  Widget buildBody(ContentType contentType) {
    switch (contentType) {
      case ContentType.lyrics:
        return HomeScreen();
        break;
      case ContentType.album:
        // TODO: Handle this case.
        break;
      case ContentType.artist:
        return ArtistsScreen();
        break;
    }
    throw UnsupportedError('Unsupported content type $contentType');
  }
}
