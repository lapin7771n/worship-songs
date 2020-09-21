import 'dart:math';

import 'package:flutter/material.dart';

class SongCoverImage extends StatelessWidget {
  const SongCoverImage({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final double saturation = _generate(0.1, 0.4);
    final double lightness = _generate(0.9, 1);
    final double hue = 210.0;
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: HSLColor.fromAHSL(
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
                color: HSLColor.fromAHSL(1, hue, saturation, 0.4).toColor(),
              ),
        ),
      ),
    );
  }

  double _generate(double low, double high) {
    double result = 0;
    do {
      result = Random().nextDouble();
    } while (result < low || result > high);
    return result;
  }
}
