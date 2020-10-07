import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/auth_screen/auth_screen.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/buttons.dart';
import 'package:worshipsongs/widgets/carousel_with_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = "/on-boarding";

  static const double _TOP_INSET = 5;
  static const double _BOTTOM_INSET = 3;
  static const double _TITLE_HEIGHT = 4;
  static const double _DESCRIPTION_HEIGHT = 2.5;
  static const double _PICTURE_HEIGHT = 50;
  static const double _BUTTON_HEIGHT = 8;

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
        ImagePathsHolder.VALUE_PROP1,
        ImagePathsHolder.VALUE_PROP2,
        ImagePathsHolder.VALUE_PROP3,
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical * _TOP_INSET,
                ),
                CarouselWithIndicator(
                  autoPlay: true,
                  height: SizeConfig.safeBlockVertical *
                      (_TITLE_HEIGHT +
                          _DESCRIPTION_HEIGHT +
                          _PICTURE_HEIGHT +
                          10),
                  children: <Widget>[
                    ...[0, 1, 2]
                        .map(
                          (e) => buildCarouselChild(context, e),
                        )
                        .toList(),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: SizeConfig.safeBlockVertical * _BUTTON_HEIGHT,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  width: SizeConfig.safeBlockHorizontal * 100,
                  child: Button(
                    title: Strings.of(context).createNewAccount,
                    onPressed: () => _handleCreateAccount(context),
                  ),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 90,
                  height: SizeConfig.safeBlockVertical * _BUTTON_HEIGHT,
                  child: TextButton(
                    child: Text(
                      Strings.of(context).iAlreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: AppColors.blue,
                          ),
                    ),
                    onPressed: () => _handleLogin(context),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * _BOTTOM_INSET,
                ),
              ],
            ),
          ],
        ),
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
    final int horizontalPadding = 32;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            texts(context)['title'][index],
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            texts(context)['text'][index],
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Center(
          child: SizedBox(
            width: SizeConfig.safeBlockHorizontal * 100 - horizontalPadding,
            height: SizeConfig.safeBlockVertical * _PICTURE_HEIGHT,
            child: SvgPicture.asset(
              texts(context)['image'][index],
            ),
          ),
        ),
      ],
    );
  }
}
