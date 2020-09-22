import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_app_bar.dart';
import 'package:worshipsongs/screens/song_screen/song_lyrics.dart';

class SongScreen extends StatefulWidget {
  static const String routeName = '/song-screen';

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool _isInit = false;
  bool _isSongWithChords;

  Song song;
  ScrollController _scrollController;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _scrollController = ScrollController();
      song = ModalRoute.of(context).settings.arguments as Song;
      _isSongWithChords = song.text.contains(".  ");
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMainContent(context, song),
    );
  }

  _buildMainContent(BuildContext context, Song song) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          child: StickyHeader(
            header: SongAppBar(
              song,
              _scrollController,
            ),
            content: SongLyrics(
              song: song,
              showInstruments: _isSongWithChords,
            ),
          )),
    );
  }
}
