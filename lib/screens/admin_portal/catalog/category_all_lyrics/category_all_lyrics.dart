import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/admin_portal/create_content_screen.dart';
import 'package:worshipsongs/screens/home_screen/home_songs_list.dart';
import 'package:worshipsongs/screens/search_screen.dart';
import 'package:worshipsongs/widgets/search_field.dart';

class CategoryAllLyricsScreen extends StatefulWidget {
  @override
  _CategoryAllLyricsScreenState createState() =>
      _CategoryAllLyricsScreenState();
}

class _CategoryAllLyricsScreenState extends State<CategoryAllLyricsScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() => setState(() => null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchField(
            focusNode: focusNode,
            controller: searchController,
            hintText: Strings.of(context).typeSongName,
          ),
          focusNode.hasFocus
              ? Expanded(
                  child: SearchScreen(
                    controller: searchController,
                    songClickListener: songClickListener,
                  ),
                )
              : buildAllLyrics(),
        ],
      ),
    );
  }

  Widget buildAllLyrics() {
    return Expanded(
      child: FutureBuilder(
        future: reloadSongs(),
        builder: (_, __) => Consumer<SongsProvider>(
          builder: (ctx, value, children) => HomeSongsList(
            songs: value.songs,
            onTap: songClickListener,
          ),
        ),
      ),
    );
  }

  void songClickListener(Song song) async {
    Artist artist;
    try {
      artist = await Provider.of<ArtistsProvider>(
        context,
        listen: false,
      ).fingById(song.artistID);
    } catch (e) {}

    final Content content = Content(
      uuid: song.uuid,
      title: song.title,
      description: song.text,
      relatedToArtist: artist,
      languageCode: song.language,
    );

    await Navigator.of(context)
        .pushNamed(CreateContentScreen.routeName, arguments: {
      'content': content,
      'contentType': ContentType.lyrics,
    });
    setState(() {});
  }

  Future reloadSongs() async {
    await Provider.of<SongsProvider>(context, listen: false).clearLoadedSongs();
    await Provider.of<SongsProvider>(context, listen: false).loadSongs();
  }
}
