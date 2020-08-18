import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/favorite_songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class MyLyricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteSongsProvider>(
        builder: (ctx, favSongsProvider, child) {
          if (favSongsProvider.songs.isEmpty) {
            favSongsProvider.getAll();
            return Center(child: CircularProgressIndicator());
          }

          final List<Song> songs = favSongsProvider.songs;
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

  _handleSongClick(Song song, BuildContext context) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }
}
