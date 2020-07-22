import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Widget> children;
  final double height;

  const CarouselWithIndicator({
    this.children,
    this.height,
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
            height: widget.height,
            autoPlay: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason){
              setState(() {
                _current = index;
              });
            }
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.children.map((url) {
            int index = widget.children.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
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
