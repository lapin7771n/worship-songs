import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/screens/home_screen.dart';
import 'package:worshipsongs/screens/onboarding_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worship songs',
      theme: ThemeData(
        fontFamily: "MavenPro",
        primaryColor: Color(0xFF0066CC),
        accentColor: AppColors.blue,
        buttonColor: AppColors.blue,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            height: 1.33,
            fontWeight: FontWeight.w900,
            fontSize: 32,
            color: AppColors.black,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
          headline3: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          headline4: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          subtitle1: TextStyle(
            height: 1.33,
            fontSize: 18,
          ),
        ),
      ),
      initialRoute: OnBoardingScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
