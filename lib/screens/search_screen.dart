import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/artist_screen.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';
import 'package:worshipsongs/widgets/songs/song_list_item.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController controller;
  final Function(Song) songClickListener;
  final bool isWithArtist;

  const SearchScreen({
    this.controller,
    this.songClickListener,
    this.isWithArtist = false,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const int _LIMIT = 3;

  List<Song> _searchedSongs = [];
  List<Artist> _searchedArtists = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      () => _searchContent(widget.controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...buildLyrics(),
          if (widget.isWithArtist) ...buildArtists(),
        ],
      ),
    );
  }

  void songClickListener(Song song) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }

  List<Widget> buildLyrics() {
    return [
      if (_searchedSongs.isNotEmpty)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            Strings.of(context).lyrics,
            style: AppTextStyles.title2,
          ),
        ),
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          var searchedSong = _searchedSongs[index];
          return SongListItem(
            song: searchedSong,
            onTap: () => widget.songClickListener != null
                ? widget.songClickListener(searchedSong)
                : songClickListener(searchedSong),
          );
        },
        itemCount: _searchedSongs.length,
      )
    ];
  }

  List<Widget> buildArtists() {
    return [
      if (_searchedArtists.isNotEmpty)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            Strings.of(context).artists(_searchedArtists.length),
            style: AppTextStyles.title2,
          ),
        ),
      BrandContentList(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        withSortedTitle: false,
        withLoadingAtTheEnd: false,
        scrollPhysics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        content: _searchedArtists
            .map(
              (e) => ContentForList(
                title: e.title,
                imageUrl: e.imageUrl,
                onTap: () => Navigator.of(context).pushNamed(
                  ArtistScreen.routeName,
                  arguments: e,
                ),
              ),
            )
            .toList(),
      )
    ];
  }

  void _searchContent(String title) async {
    _searchedSongs = await Provider.of<SongsProvider>(
      context,
      listen: false,
    ).finByTitle(title, _LIMIT);

    if (widget.isWithArtist) {
      _searchedArtists = await Provider.of<ArtistsProvider>(
        context,
        listen: false,
      ).findByTitle(title, _LIMIT);
    }

    setState(() => null);
  }
}
