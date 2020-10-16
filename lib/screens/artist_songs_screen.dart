import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';

class ArtistSongsScreen extends StatelessWidget {
  static const String routeName = '/artist-songs';

  @override
  Widget build(BuildContext context) {
    final Artist artist = ModalRoute.of(context).settings.arguments as Artist;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          Strings.of(context).allLyrics,
          style: AppTextStyles.title3,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<SongsProvider>(context).findByArtistId(artist.uuid),
        builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return BrandContentList(
            withLoadingAtTheEnd: false,
            content: snapshot.data
                .map(
                  (e) => ContentForList(
                    title: e.title,
                    subtitle: e.author,
                    chipText: e.hasChords ? Strings.of(context).chords : null,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        SongScreen.routeName,
                        arguments: e,
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
