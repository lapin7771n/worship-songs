import 'dart:math';

import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';

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
      onTap: onTap,
      leading: Container(
        width: 74,
        height: 74,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 0.2),
        ),
        child: Center(
          child: Text(song.title.substring(0, 1)),
        ),
      ),
      title: Text(song.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(song.author ?? "Unknown"),
          if (song.key != null) Text('Guitar chords'),
        ],
      ),
    );
  }
}
