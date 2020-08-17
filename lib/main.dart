import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/screens/auth_screen/auth_screen.dart';
import 'package:worshipsongs/screens/home_screen.dart';
import 'package:worshipsongs/screens/main_screen.dart';
import 'package:worshipsongs/screens/onboarding_screen.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        final FirebaseUser user = snapshot.data as FirebaseUser;
        return MaterialApp(
          title: 'Worship songs',
          theme: _buildThemeData(context),
          initialRoute:
              user == null ? OnBoardingScreen.routeName : MainScreen.routeName,
          routes: {
            OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            MainScreen.routeName: (ctx) => MainScreen(),
            SongScreen.routeName: (ctx) => SongScreen(),
          },
        );
      },
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppColors.red,
        width: 1,
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      buttonTheme: ButtonThemeData(
        height: 56,
        buttonColor: AppColors.blue,
        focusColor: AppColors.blueText,
        disabledColor: Color(0xFF8FADCC),
      ),
      errorColor: AppColors.red,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: "MavenPro",
      primaryColor: AppColors.blue,
      primaryColorDark: AppColors.darkBlue,
      accentColor: AppColors.blue,
      buttonColor: AppColors.blue,
      disabledColor: AppColors.gray,
      cursorColor: AppColors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonBarTheme: ButtonBarThemeData(),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: AppColors.gray),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFF8DB1D9),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.blue,
            width: 2,
          ),
        ),
        errorBorder: _buildErrorBorder(),
        focusedErrorBorder: _buildErrorBorder(),
        errorStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          height: 1.33,
          fontWeight: FontWeight.w900,
          fontSize: 32,
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
        subtitle2: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ).apply(
        displayColor: AppColors.black,
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: AppColors.white,
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
