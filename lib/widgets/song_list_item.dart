import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/widgets/rounded_label.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';

class SongListItem extends StatelessWidget {
  final Song song;
  final Function onTap;

  const SongListItem({
    this.song,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      onTap: onTap,
      leading: SongCoverImage(title: song.title),
      title: Text(
        song.title,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //TODO set max characters up to 20.
          Text(
            song.author,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 8),
          if (song.text.contains(".  ")) RoundedLabel(title: 'Guitar chords'),
        ],
      ),
    );
  }
}
