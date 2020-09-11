import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_favorite_action.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';

class SongScreen extends StatefulWidget {
  static const String routeName = '/song-screen';

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool _isChordsVisible = true;
  bool _isSongWithChords = false;

  @override
  Widget build(BuildContext context) {
    final song = ModalRoute.of(context).settings.arguments as Song;
    _isSongWithChords = song.text.contains(".  ");
    return Scaffold(
      // appBar: AppBar(
      //   actions: [SongFavoriteAction(song.uuid)],
      // ),
      body: _buildMainContent(context, song),
    );
  }

  _buildMainContent(BuildContext context, Song song) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 50.0,
          bottom: 80.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildTopBar(song, context),
            SizedBox(
              height: 24,
            ),
            if (_isSongWithChords)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChordsVisible,
                    onChanged: _onGuitarChordsCheckBoxChanged,
                  ),
                  Text(
                    'Guitar chords',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            SizedBox(
              height: 40,
            ),
            StyledText(
              text: _isChordsVisible
                  ? song.formattedText
                  : song.formattedTextWithoutChords,
              style: Theme.of(context).textTheme.subtitle1,
              newLineAsBreaks: true,
              styles: {
                'bold': Theme.of(context).textTheme.headline4,
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTopBar(Song song, BuildContext context) {
    return [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Hero(tag: song.uuid, child: SongCoverImage(title: song.title)),
          SongFavoriteAction(song.uuid),
        ],
      ),
      SizedBox(
        height: 24,
      ),
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: song.uuid + song.title.hashCode,
              child: Text(
                song.title,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Hero(
              tag: song.uuid + song.author.hashCode,
              child: Text(
                song.author,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: AppColors.gray),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )
    ];
  }

  void _onGuitarChordsCheckBoxChanged(bool isChecked) {
    setState(() {
      _isChordsVisible = isChecked;
    });
  }
}
