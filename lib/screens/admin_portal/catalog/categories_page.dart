import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_list_item.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_screen.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 32),
          CategoryListItem(
            title: Strings.of(context).lyrics,
            countFuture: Provider.of<SongsProvider>(context).count(),
            onTap: () => itemClickListener(context, ContentType.lyrics),
          ),
          CategoryListItem(
            title: Strings.of(context).artists(2),
            countFuture: Provider.of<ArtistsProvider>(context).count(),
            onTap: () => itemClickListener(context, ContentType.artist),
          ),
        ],
      ),
    );
  }

  void itemClickListener(BuildContext context, ContentType contentType) {
    Navigator.of(context).pushNamed(
      CategoryScreen.routeName,
      arguments: contentType,
    );
  }
}
