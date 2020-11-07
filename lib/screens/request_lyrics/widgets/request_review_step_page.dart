import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/bloc/request_lyrics_bloc/request_lyrics_bloc.dart';
import 'package:worshipsongs/services/chords_parser.dart';

class RequestReviewStepPage extends StatelessWidget {
  const RequestReviewStepPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = BlocProvider.of<RequestLyricsBloc>(context).requestedSong;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 32,
          bottom: 200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(info.title, style: AppTextStyles.title2),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(info.artist.imageUrl),
                ),
                SizedBox(width: 8),
                Text(
                  info.artist.title,
                  style: AppTextStyles.guitarChordsRegular,
                ),
              ],
            ),
            SizedBox(height: 24),
            StyledText(
              newLineAsBreaks: true,
              text: ChordsParser.toFormattedChords(info.lyrics),
              styles: {
                'bold': AppTextStyles.guitarChordsRegular.copyWith(
                  color: AppColors.blue,
                ),
              },
              style: AppTextStyles.lyricsMiddle,
            )
          ],
        ),
      ),
    );
  }
}
