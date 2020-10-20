import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worshipsongs/bloc/request_lyrics_bloc/request_lyrics_bloc.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/widgets/brand_field.dart';
import 'package:worshipsongs/widgets/languages_row.dart';

class RequestSecondStepPage extends StatelessWidget {
  const RequestSecondStepPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = BlocProvider.of<RequestLyricsBloc>(context).requestedLyrics;
    final defaultLanguage = Localizations.localeOf(context).languageCode;

    BlocProvider.of<RequestLyricsBloc>(context).add(
      RequestLyricsLanguageChosen(info.languageCode ?? defaultLanguage),
    );

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
            LanguagesRow(
              isSingleLanguage: true,
              isWithAll: false,
              languagesSelectedCallback: (langs) {
                BlocProvider.of<RequestLyricsBloc>(context).add(
                  RequestLyricsLanguageChosen(langs[0]),
                );
              },
              initialLanguages: [info.languageCode ?? defaultLanguage],
            ),
            SizedBox(height: 24),
            BrandField(
              controller: TextEditingController.fromValue(
                TextEditingValue(text: info.lyrics ?? ""),
              ),
              dynamicLines: true,
              title: Strings.of(context).lyricsAndChords,
              hintText: Strings.of(context).addLyricsAndChords,
              onChanged: (text) {
                BlocProvider.of<RequestLyricsBloc>(context).add(
                  RequestLyricsTextChanged(text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
