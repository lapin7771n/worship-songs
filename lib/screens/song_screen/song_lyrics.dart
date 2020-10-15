import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/services/chords_parser.dart';
import 'package:worshipsongs/services/size_config.dart';

import '../../app_colors.dart';

class SongLyrics extends StatefulWidget {
  final Song song;
  final bool showInstruments;

  const SongLyrics({
    this.song,
    this.showInstruments,
  });

  @override
  _SongLyricsState createState() => _SongLyricsState();
}

class _SongLyricsState extends State<SongLyrics> {
  bool _isChordsVisible = true;
  bool _isInit = false;

  int currentTone = 0;
  String currentKey;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      currentKey = widget.song.key;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 24.0,
        bottom: SizeConfig.blockSizeVertical * 50,
        right: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showInstruments) _buildInstrumentsRow(context),
          SizedBox(
            height: 24,
          ),
          StyledText(
            text: _isChordsVisible
                ? widget.song.formattedText(currentTone)
                : widget.song.formattedTextWithoutChords,
            style: Theme.of(context).textTheme.subtitle1,
            newLineAsBreaks: true,
            styles: {
              'bold': Theme.of(context).textTheme.bodyText1,
            },
          ),
        ],
      ),
    );
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
      if (currentKey != null) {
        currentKey = ChordsParser.transposeChord(widget.song.key, currentTone);
      }
    });
  }

  void _decreaseTone() {
    setState(() {
      --currentTone;
      if (currentKey != null) {
        currentKey = ChordsParser.transposeChord(widget.song.key, currentTone);
      }
    });
  }
}
