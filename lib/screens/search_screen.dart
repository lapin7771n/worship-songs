import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/songs/song_list_item.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController controller;

  const SearchScreen({this.controller});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Song> _searchedSongs = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      () => _searchSongs(widget.controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        var searchedSong = _searchedSongs[index];
        return SongListItem(
          song: searchedSong,
          onTap: () => songClickListener(searchedSong),
        );
      },
      itemCount: _searchedSongs.length,
    );
  }

  void songClickListener(Song song) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }

  _searchSongs(String title) async {
    List<Song> foundSongs =
        await Provider.of<SongsProvider>(context, listen: false)
            .finByTitle(title);
    setState(() => _searchedSongs = foundSongs);
  }
}
