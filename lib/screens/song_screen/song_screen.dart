import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/song_screen/song_favorite_action.dart';
import 'package:worshipsongs/services/chords_parser.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';

class SongScreen extends StatefulWidget {
  static const String routeName = '/song-screen';

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool _isChordsVisible = true;
  bool _isSongWithChords = false;
  bool _isInit = false;

  int currentTone = 0;
  String currentKey;
  Song song;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      song = ModalRoute.of(context).settings.arguments as Song;
      currentKey = song.key;
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
            if (_isSongWithChords) _buildInstrumentsRow(context),
            SizedBox(
              height: 24,
            ),
            StyledText(
              text: _isChordsVisible
                  ? song.formattedText(currentTone)
                  : song.formattedTextWithoutChords,
              style: Theme.of(context).textTheme.subtitle1,
              newLineAsBreaks: true,
              styles: {
                'bold': Theme.of(context).textTheme.bodyText1,
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
          CloseButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Hero(
            tag: song.uuid,
            child: SongCoverImage(
              title: song.title,
              author: song.author,
              isBig: true,
            ),
          ),
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

  Widget _buildInstrumentsRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChordsVisible,
          onChanged: _onGuitarChordsCheckBoxChanged,
        ),
        Text(
          Strings.of(context).chords,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 5,
        ),
        _buildTransposeButton(context, '-1', _decreaseTone),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentKey != null)
                Text(
                  currentKey,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: AppColors.blueText,
                      ),
                ),
              Text(
                '($currentTone)',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.gray,
                    ),
              ),
            ],
          ),
        ),
        _buildTransposeButton(context, '+1', _increaseTone),
      ],
    );
  }

  Container _buildTransposeButton(
    BuildContext context,
    String text,
    Function onTap,
  ) {
    return Container(
      width: 32,
      height: 32,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(
            4,
          ),
        ),
        onPressed: onTap,
        color: AppColors.bluishGray,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  void _onGuitarChordsCheckBoxChanged(bool isChecked) {
    setState(() {
      _isChordsVisible = isChecked;
    });
  }

  void _increaseTone() {
    setState(() {
      ++currentTone;
      currentKey = ChordsParser.transposeChord(song.key, currentTone);
    });
  }

  void _decreaseTone() {
    setState(() {
      --currentTone;
      currentKey = ChordsParser.transposeChord(song.key, currentTone);
    });
  }
}
