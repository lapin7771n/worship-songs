import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/favorite_song.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/favorite_songs_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class MyLyricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getSongsFromFavorite(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          final List<Song> songs = snapshot.data as List<Song> ?? [];
          return ListView.builder(
            itemBuilder: (ctx, index) => SongListItem(
              song: songs[index],
              onTap: () => _handleSongClick(songs[index], context),
            ),
            itemCount: songs.length,
          );
        },
      ),
    );
  }

  Future<List<Song>> _getSongsFromFavorite(BuildContext context) async {
    final List<FavoriteSong> favSongs =
        await Provider.of<FavoriteSongsProvider>(context)
            .getAll();
    final List<int> ids = favSongs.map((e) => e.songId).toList();
    final List<Song> songs =
        await Provider.of<SongsProvider>(context, listen: false)
            .getSongsById(ids);
    songs.sort((o1, o2) => o1.title.compareTo(o2.title));
    return songs;
  }

  _handleSongClick(Song song, BuildContext context) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }
}
