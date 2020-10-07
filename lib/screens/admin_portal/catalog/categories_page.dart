import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_list_item.dart';

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
            onTap: () => lyricsClickListener(context),
          ),
          CategoryListItem(
            title: Strings.of(context).artists(2),
            countFuture: Provider.of<ArtistsProvider>(context).count(),
            onTap: () => artistClickListener(context),
          ),
        ],
      ),
    );
  }

  void lyricsClickListener(BuildContext context) {
    
  }

  void artistClickListener(BuildContext context) {

  }
}
