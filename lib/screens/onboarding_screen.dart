import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/widgets/button.dart';
import 'package:worshipsongs/widgets/carousel_with_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = "/";

  final texts = const <String, List<String>>{
    'title': [
      'Words to Pray God',
      'Play songs you like',
      'The words of truth',
    ],
    'text': [
      'Find the lyrics of popular christian songs to sing with people you love',
      'Beside lyrics you also can find the chords for guitar and notes for piano!',
      'Read the great stories of great people how God change their lives!',
    ],
    'image': [
      'assets/images/illustrations/ValueProposition1.svg',
      'assets/images/illustrations/ValueProposition2.svg',
      'assets/images/illustrations/ValueProposition3.svg',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .18,
          ),
          CarouselWithIndicator(
            height: MediaQuery
                .of(context)
                .size
                .height * .55,
            children: <Widget>[
              ...[0, 1, 2]
                  .map(
                    (e) => buildCarouselChild(context, e),
              )
                  .toList(),
            ],
          ),
          Container(
            height: 56,
            margin: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Button(
              title: "Create new Account",
              onPressed: () {},
            ),
          ),
          TextButton(
            title: 'I already have an Account',
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Column buildCarouselChild(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            texts['title'][index],
            style: Theme
                .of(context)
                .textTheme
                .headline1,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            texts['text'][index],
            style: Theme
                .of(context)
                .textTheme
                .subtitle1,
          ),
        ),
        Container(
          transform: index != 2 ?Matrix4.translationValues(0, -30, 0) : null,
          child: Row(
            mainAxisAlignment: getImageAlignment(index),
            children: <Widget>[
              SvgPicture.asset(
                texts['image'][index],
              ),
            ],
          ),
        ),
      ],
    );
  }

  MainAxisAlignment getImageAlignment(int index) {
    switch (index) {
      case 0:
        return MainAxisAlignment.end;
      case 1:
        return MainAxisAlignment.start;
      case 2:
        return MainAxisAlignment.center;
    }
  }
}
