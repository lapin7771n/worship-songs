import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SongCoverImage extends StatelessWidget {
  const SongCoverImage({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(
          Random().nextInt(200),
          Random().nextInt(200),
          Random().nextInt(200),
          0.3,
        ),
      ),
      child: Center(
        child: Text(
          title.substring(0, 1),
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
