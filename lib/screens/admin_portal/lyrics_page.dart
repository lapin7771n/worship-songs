import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/providers/new_content_provider.dart';
import 'package:worshipsongs/services/debouncer.dart';
import 'package:worshipsongs/services/lyrics_parser.dart';
import 'package:worshipsongs/widgets/brand_field.dart';

class LyricsPage extends StatefulWidget {
  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  final TextEditingController lyricsController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  final lyricsParser = LyricsParser();

  @override
  void initState() {
    lyricsController.addListener(lyricsChangeListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lyricsController.text =
        Provider.of<NewContentProvider>(context).content.description;
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
              buildInfoCard(context),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Strings.of(context).lyricsAndChords,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              BrandField(
                maxLines: 20,
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
    _debouncer(() {
      final selection = lyricsController.selection;
      var oldText = lyricsController.text;
      lyricsController.text = lyricsParser.convert(oldText);
      lyricsController.selection = TextSelection.fromPosition(
        TextPosition(
          offset: selection.baseOffset +
              (lyricsController.text.length - oldText.length),
        ),
      );
      Provider.of<NewContentProvider>(
        context,
        listen: false,
      ).description = lyricsController.text;
    });
  }

  Widget buildInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF7CC),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).howToAddChords,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 8),
          Text(
            Strings.of(context).toAddChordsToTheLyrics,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}