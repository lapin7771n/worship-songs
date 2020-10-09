import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';

class SongListItem extends StatelessWidget {
  final Song song;
  final Function onTap;

  SongListItem({this.song, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BrandListItem(
      title: song.title,
      subtitle: song.author,
      chipText: song.hasChords ? Strings.of(context).chords : null,
      onTap: onTap,
    );
  }
}
