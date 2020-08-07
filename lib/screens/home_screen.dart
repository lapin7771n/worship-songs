import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/services/songs_service.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: SongsService().getSongs(3),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Waiting...'));
            }

            return Container(
              child: ListView.builder(
                itemExtent: 90.0,
                itemBuilder: (c, index) => SongListItem(
                  song: snapshot.data[index],
                  onTap: _handleSongClick(
                    snapshot.data[index],
                  ),
                ),
                itemCount: snapshot.data.length,
              ),
            );
          },
        ),
      ),
    );
  }

  _handleSongClick(Song song) {}
}
