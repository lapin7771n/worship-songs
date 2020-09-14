import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/home_songs_list.dart';
import 'package:worshipsongs/screens/search_screen.dart';

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
                  Strings.of(context).error + ": " + snapshot.error,
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

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
          top: 50,
          bottom: 10,
        ),
        child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  focusNode: _searchFocus,
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/Search.svg',
                        color: AppColors.black,
                      ),
                    ),
                    hintText: Strings.of(context).typeSongName,
                  ),
                ),
              ),
              if (_isSearchFocused)
                FlatButton(
                  child: Text(Strings.of(context).cancel),
                  onPressed: () {
                    _controller.text = '';
                    _searchFocus.unfocus();
                  },
                ),
            ],
          ),
        ),
      ),
      preferredSize: Size(MediaQuery.of(context).size.width, 80),
    );
  }

  Consumer<SongsProvider> _buildSongList() {
    return Consumer<SongsProvider>(
      builder: (_, songsProvider, __) => HomeSongsList(songsProvider.songs),
    );
  }
}
