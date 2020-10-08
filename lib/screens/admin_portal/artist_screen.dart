import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/screens/admin_portal/create_content_screen.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';
import 'package:worshipsongs/widgets/search_field.dart';

class ArtistsScreen extends StatefulWidget {
  @override
  _ArtistsScreenState createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearchField(context),
        SizedBox(height: 32),
        buildArtistList(context),
      ],
    );
  }

  Widget buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SearchField(
        controller: controller,
        hintText: Strings.of(context).typeArtistName,
        focusNode: focusNode,
      ),
    );
  }

  Widget buildArtistList(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      // ignore: missing_return
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          loadMoreArtists(context);
        }
      },
      child: FutureBuilder(
        future: loadFirstPageOfArtists(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : BrandContentList(
                  title: buildTitle(context),
                  content: buildContent(snapshot, context),
                  withArrow: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16.0,
                  ),
                );
        },
      ),
    );
  }

  Future loadFirstPageOfArtists() async {
    var provider = Provider.of<ArtistsProvider>(context, listen: false);
    provider.dispose();
    return provider.read();
  }

  void onArtistClicked(Artist artist, BuildContext context) async {
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

  List<ContentForList> buildContent(
    AsyncSnapshot snapshot,
    BuildContext context,
  ) {
    return (snapshot.data as List<Artist>)
        .map(
          (e) => ContentForList(
            title: e.title,
            imageUrl: e.imageUrl,
            onTap: () => onArtistClicked(e, context),
          ),
        )
        .toList();
  }

  String buildTitle(BuildContext context) {
    return Strings.of(context).all + " " + Strings.of(context).artists(2);
  }

  void loadMoreArtists(BuildContext context) async {
    isLoading = true;
    await Provider.of<ArtistsProvider>(context, listen: false).read();
    isLoading = false;
  }
}
