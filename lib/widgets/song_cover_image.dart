import 'dart:math';

import 'package:flutter/material.dart';

class SongCoverImage extends StatelessWidget {
  const SongCoverImage({
    Key key,
    @required this.title,
    @required this.author,
    this.isBig = false,
  }) : super(key: key);

  final String title;
  final String author;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    final double saturation = _generate(author, 0.1, 0.4);
    final double lightness = _generate(title, 0.9, 1);
    final double hue = 210.0;
    return Container(
      width: isBig ? 88 : 56,
      height: isBig ? 88 : 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: HSVColor.fromAHSV(
          1,
          hue,
          saturation,
          lightness,
        ).toColor(),
      ),
      child: Center(
        child: Text(
          title.substring(0, 1),
          style: Theme.of(context).textTheme.headline3.copyWith(
                color: HSVColor.fromAHSV(1, hue, saturation, 0.4).toColor(),
              ),
        ),
      ),
    );
  }

  double _generate(String source, double low, double high) {
    double result = 0;
    int index = 0;
    do {
      int indexToGet = index % source.length;
      var codeUnitAt = source.codeUnitAt(indexToGet);
      result += min(codeUnitAt, 300) / low / high / 8000;
      index++;
    } while (result < low);
    return min(result, high);
  }
}
