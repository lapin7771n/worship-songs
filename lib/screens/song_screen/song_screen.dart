import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_favorite_action.dart';

class SongScreen extends StatelessWidget {
  static const String routeName = '/song-screen';

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
            StyledText(
              text: song.formattedText,
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
}
