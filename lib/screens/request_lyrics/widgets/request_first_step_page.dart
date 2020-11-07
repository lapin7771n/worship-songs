import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worshipsongs/bloc/request_lyrics_bloc/request_lyrics_bloc.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/widgets/artist_selector.dart';
import 'package:worshipsongs/widgets/brand_field.dart';

import '../../../app_text_styles.dart';

class RequestFirstStepPage extends StatelessWidget {
  const RequestFirstStepPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = BlocProvider.of<RequestLyricsBloc>(context).requestedSong;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandField(
              controller: TextEditingController.fromValue(
                TextEditingValue(text: info.title ?? ""),
              ),
              title: Strings.of(context).lyricsTitle,
              hintText: Strings.of(context).exampleWayMaker,
              onChanged: (title) {
                BlocProvider.of<RequestLyricsBloc>(context).add(
                  RequestLyricsSongNameAdded(title),
                );
              },
            ),
            SizedBox(height: 40),
            Text(
              Strings.of(context).artists(1),
              style: AppTextStyles.title3,
            ),
            ArtistSelector(
              initialArtist: info.artist,
              onArtistSelected: (artist) => onArtistSelected(
                artist,
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onArtistSelected(Artist artist, BuildContext context) {
    BlocProvider.of<RequestLyricsBloc>(context).add(
      RequestLyricsArtistAdded(artist),
    );
  }
}
