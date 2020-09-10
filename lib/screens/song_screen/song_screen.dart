import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_favorite_action.dart';

class SongScreen extends StatefulWidget {
  static const String routeName = '/song-screen';

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool _isChordsVisible = true;

  @override
  Widget build(BuildContext context) {
    final song = ModalRoute.of(context).settings.arguments as Song;
    return Scaffold(
      appBar: AppBar(
        actions: [SongFavoriteAction(song.uuid)],
      ),
      body: _buildMainContent(context, song),
    );
  }

  _buildMainContent(BuildContext context, Song song) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 24.0,
          bottom: 80.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              song.author,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: AppColors.gray),
            ),
            SizedBox(
              height: 24,
            ),
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

  void _onGuitarChordsCheckBoxChanged(bool isChecked) {
    setState(() {
      _isChordsVisible = isChecked;
    });
  }
}
