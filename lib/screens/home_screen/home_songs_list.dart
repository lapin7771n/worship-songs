import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';

class HomeSongsList extends StatefulWidget {
  final List<Song> songs;
  final Function(Song) onTap;

  const HomeSongsList({
    Key key,
    this.songs,
    this.onTap,
  }) : super(key: key);

  @override
  _HomeSongsListState createState() => _HomeSongsListState();
}

class _HomeSongsListState extends State<HomeSongsList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      // ignore: missing_return
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadMoreSongs(context);
        }
      },
      child: buildListView(context),
    );
  }

  Widget buildListView(BuildContext context) {
    return BrandContentList(
      title: Strings.of(context).allLyrics,
      content: widget.songs
          .map(
            (e) => ContentForList(
              title: e.title,
              subtitle: e.author,
              imageUrl: null,
              chipText: e.hasChords ? Strings.of(context).chords : null,
              onTap: () => widget.onTap != null
                  ? widget.onTap(e)
                  : songClickListenerFallback(e, context),
            ),
          )
          .toList(),
    );
  }

  Future _loadMoreSongs(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;
    await Provider.of<SongsProvider>(context, listen: false).loadSongs();
    _isLoading = false;
  }

  songClickListenerFallback(Song song, BuildContext context) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }
}
