import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class CarouselWithIndicator extends StatefulWidget {
  static const double _COEF = 50;

  final List<Widget> children;
  final double height;
  final bool autoPlay;

  const CarouselWithIndicator({
    this.children,
    this.height,
    this.autoPlay = false,
  });

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  var _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: widget.children.length,
          itemBuilder: (ctx, index) {
            return widget.children[index];
          },
          options: CarouselOptions(
              viewportFraction: 1.0,
              disableCenter: true,
              height: widget.height - widget.height / CarouselWithIndicator._COEF,
              autoPlay: widget.autoPlay,
              scrollPhysics: BouncingScrollPhysics(),
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.children.map((url) {
            int index = widget.children.indexOf(url);
            return Container(
              width: widget.height / CarouselWithIndicator._COEF,
              height: widget.height / CarouselWithIndicator._COEF,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? AppColors.blue
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
