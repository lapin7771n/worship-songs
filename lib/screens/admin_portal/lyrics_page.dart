import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/new_content_provider.dart';
import 'package:worshipsongs/widgets/brand_field.dart';
import 'package:worshipsongs/widgets/languages_row.dart';

class LyricsPage extends StatefulWidget {
  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  final TextEditingController lyricsController = TextEditingController();

  @override
  void initState() {
    lyricsController.addListener(lyricsChangeListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lyricsController.text =
        Provider.of<NewContentProvider>(context, listen: false)
            .content
            .description;

    if (songLanguage == null) {
      Provider.of<NewContentProvider>(
        context,
        listen: false,
      ).languageCode = Localizations.localeOf(context).languageCode;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    lyricsController.removeListener(lyricsChangeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLanguages(),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Strings.of(context).lyricsAndChords,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              BrandField(
                dynamicLines: true,
                textStyle: Theme.of(context).textTheme.headline6,
                controller: lyricsController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void lyricsChangeListener() {
    Provider.of<NewContentProvider>(
      context,
      listen: false,
    ).description = lyricsController.text;
  }

  Widget buildLanguages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.of(context).lyrics + " " + Strings.of(context).language,
          style: AppTextStyles.titleSongPlaylist,
        ),
        SizedBox(height: 8),
        LanguagesRow(
          languagesSelectedCallback: (lang) {
            Provider.of<NewContentProvider>(
              context,
              listen: false,
            ).languageCode = lang[0];
          },
          initialLanguages: [songLanguage],
          isSingleLanguage: true,
          isWithAll: false,
        ),
      ],
    );
  }

  String get songLanguage {
    return Provider.of<NewContentProvider>(context, listen: false)
        .content
        .languageCode;
  }
}
