import 'dart:math';

import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
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
    return Container(
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color.fromRGBO(
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
              0.4,
            ),
          ),
          child: Center(
            child: Text(
              song.title.substring(0, 1),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        title: Text(
          song.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              song.author ?? "Unknown",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 8),
            //if (song.key != null)
            RoundedLabel(title: 'Guitar chords')
          ],
        ),
      ),
    );
  }
}

class RoundedLabel extends StatelessWidget {
  final String title;

  const RoundedLabel({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFC8D7E5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}
