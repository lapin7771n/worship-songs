import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/home_songs_list.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<SongsProvider>(context, listen: false).loadSongs(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Consumer<SongsProvider>(
            builder: (_, songsProvider, __) =>
                HomeSongsList(songsProvider.songs),
          );
        },
      ),
    );
  }
}
