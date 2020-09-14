import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/auth_screen/auth_screen.dart';
import 'package:worshipsongs/widgets/button.dart';
import 'package:worshipsongs/widgets/carousel_with_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = "/on-boarding";

  Map<String, List<String>> texts(BuildContext context) {
    return {
      'title': [
        Strings.of(context).wordsToPrayGod,
        Strings.of(context).playSongsYouLike,
        Strings.of(context).theWordsOfTruth,
      ],
      'text': [
        Strings.of(context).findTheLyricsOfPopular,
        Strings.of(context).besideLyricsYouAlso,
        Strings.of(context).readTheGreatStories,
      ],
      'image': [
        'assets/images/illustrations/ValueProposition1.svg',
        'assets/images/illustrations/ValueProposition2.svg',
        'assets/images/illustrations/ValueProposition3.svg',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .18,
          ),
          CarouselWithIndicator(
            autoPlay: true,
            height: MediaQuery.of(context).size.height * .55,
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
            width: MediaQuery.of(context).size.width,
            child: Button(
              title: Strings.of(context).createNewAccount,
              onPressed: () => _handleCreateAccount(context),
            ),
          ),
          TextButton(
            title: Strings.of(context).iAlreadyHaveAnAccount,
            onPressed: () => _handleLogin(context),
          )
        ],
      ),
    );
  }

  _handleCreateAccount(BuildContext context) {
    Navigator.of(context).pushNamed(
      AuthScreen.routeName,
      arguments: false,
    );
  }

  _handleLogin(BuildContext context) {
    Navigator.of(context).pushNamed(
      AuthScreen.routeName,
      arguments: true,
    );
  }

  Column buildCarouselChild(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            texts(context)['title'][index],
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            texts(context)['text'][index],
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          transform: index != 2 ? Matrix4.translationValues(0, -15, 0) : null,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: getImageMainAxisAlignment(index),
            children: <Widget>[
              SvgPicture.asset(
                texts(context)['image'][index],
                alignment: getImageAlignment(index),
              ),
            ],
          ),
        ),
      ],
    );
  }

  MainAxisAlignment getImageMainAxisAlignment(int index) {
    switch (index) {
      case 0:
        return MainAxisAlignment.end;
      case 1:
        return MainAxisAlignment.start;
      case 2:
        return MainAxisAlignment.center;
    }
    return MainAxisAlignment.center;
  }

  Alignment getImageAlignment(int index) {
    switch (index) {
      case 0:
        return Alignment.centerRight;
      case 1:
        return Alignment.centerLeft;
      case 2:
        return Alignment.center;
    }
    return Alignment.center;
  }
}
