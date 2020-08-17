import 'package:flutter/material.dart';
import 'package:worshipsongs/screens/home_screen/home_songs_list.dart';
import 'package:worshipsongs/services/songs_service.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SongsService.getSongs(10, orderByName: true),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return HomeSongsList(
            initialSongs: snapshot.data,
          );
        },
      ),
    );
  }
}
