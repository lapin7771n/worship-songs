import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/home_app_bar.dart';
import 'package:worshipsongs/screens/home_screen/home_songs_list.dart';
import 'package:worshipsongs/screens/search_screen.dart';
import 'package:worshipsongs/services/size_config.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocus.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _isSearchFocused || _controller.text.isNotEmpty
          ? SearchScreen(_controller)
          : _buildDefaultSection(),
    );
  }

  Widget _buildDefaultSection() {
    var songsProvider = Provider.of<SongsProvider>(context, listen: false);
    return songsProvider.songs.isEmpty
        ? FutureBuilder(
            future: songsProvider.loadSongs(),
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  Strings.of(context).error + ": " + snapshot.error.toString(),
                ));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return _buildSongList();
              }
            },
          )
        : _buildSongList();
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: HomeAppBar(
        controller: _controller,
        isSearchFocused: _isSearchFocused,
        searchFocusNode: _searchFocus,
        updateFiltersCallback: _updateFilters,
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        SizeConfig.safeBlockVertical * 20,
      ),
    );
  }

  void _updateFilters() {
    setState(() {
      var songsProvider = Provider.of<SongsProvider>(context, listen: false);
      songsProvider.clearLoadedSongs();
    });
  }

  Consumer<SongsProvider> _buildSongList() {
    return Consumer<SongsProvider>(
      builder: (_, songsProvider, __) => HomeSongsList(songsProvider.songs),
    );
  }
}
