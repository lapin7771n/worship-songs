import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController _controller;

  const SearchScreen(this._controller);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Song> _searchedSongs = [];

  @override
  void initState() {
    super.initState();
    widget._controller.addListener(
      () => _searchSongs(widget._controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return BrandListItem(
          song: _searchedSongs[index],
          onTap: () {
            Navigator.of(context).pushNamed(
              SongScreen.routeName,
              arguments: _searchedSongs[index],
            );
          },
        );
      },
      itemCount: _searchedSongs.length,
    );
  }

  _searchSongs(String title) async {
    List<Song> foundSongs =
        await Provider.of<SongsProvider>(context, listen: false)
            .finByTitle(title);
    setState(() => _searchedSongs = foundSongs);
  }
}
