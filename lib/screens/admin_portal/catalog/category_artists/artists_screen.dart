import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_artists/artists_searched.dart';
import 'package:worshipsongs/screens/admin_portal/create_content_screen.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';
import 'package:worshipsongs/widgets/infinite_brand_list.dart';
import 'package:worshipsongs/widgets/search_field.dart';

class ArtistsScreen extends StatefulWidget {
  @override
  _ArtistsScreenState createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() => setState(() => null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(
          focusNode: focusNode,
          controller: controller,
          hintText: Strings.of(context).typeArtistName,
        ),
        focusNode.hasFocus
            ? ArtistsSearched(
                controller: controller,
                onTap: onArtistClicked,
              )
            : buildArtistsList(context),
      ],
    );
  }

  Widget buildArtistsList(BuildContext context) {
    return FutureBuilder(
      future: loadFirstPageOfArtists(),
      builder: (_, snapshot) => Consumer<ArtistsProvider>(
        builder: (ctx, value, _) => InfiniteBrandList(
          title: buildTitle(context),
          contentForList: snapshot.data ?? [],
          loadMoreCallback: () => Provider.of<ArtistsProvider>(
            ctx,
            listen: false,
          ).read(),
          withArrow: true,
        ),
      ),
    );
  }

  Future<List<ContentForList>> loadFirstPageOfArtists() async {
    var provider = Provider.of<ArtistsProvider>(context, listen: false);
    provider.dispose();
    return buildContent((await provider.read()));
  }

  void onArtistClicked(Artist artist) async {
    final isDeleted = await Navigator.of(context).pushNamed(
      CreateContentScreen.routeName,
      arguments: {
        'contentType': ContentType.artist,
        'content': Content(
          uuid: artist.uuid,
          title: artist.title,
          description: artist.description,
          imagePath: artist.imageUrl,
          dateCreated: artist.dateCreated,
          dateEdited: artist.dateEdited,
        ),
      },
    );

    if (isDeleted != null) {
      final String message = isDeleted
          ? Strings.of(context).contentSuccessfullyDeleted
          : Strings.of(context).contentDeleteError;

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    setState(() {});
  }

  List<ContentForList> buildContent(List<Artist> artists) {
    return artists
        .map((e) => ContentForList(
            title: e.title,
            imageUrl: e.imageUrl,
            onTap: () => onArtistClicked(e)))
        .toList();
  }

  String buildTitle(BuildContext context) {
    return Strings.of(context).all + " " + Strings.of(context).artists(2);
  }
}
