import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/services/songs_service.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class MyLyricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: favoriteSongsFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.error != null) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final List<Song> songs = snapshot.data as List<Song>;
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

  Future<List<Song>> get favoriteSongsFuture async {
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return SongsService.getFavorites(currentUser.uid);
  }
}
