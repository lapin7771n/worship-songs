import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/widgets/carousel_with_indicator.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            CarouselWithIndicator(
              children: <Widget>[
                Container(
                  child: SvgPicture.asset(
                      "assets/images/illustrations/WeekendPray.svg"),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                ),
                Container(
                  child: SvgPicture.asset(
                      "assets/images/illustrations/WeekendPray.svg"),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                ),
                Container(
                  child: SvgPicture.asset(
                      "assets/images/illustrations/WeekendPray.svg"),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
