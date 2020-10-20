import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/auth_status.dart';
import 'package:worshipsongs/localizations/app_localizations_delegate.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
import 'package:worshipsongs/providers/favorite_songs_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/account_settings_screen.dart';
import 'package:worshipsongs/screens/admin_portal/admin_main_screen.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/category_screen.dart';
import 'package:worshipsongs/screens/admin_portal/create_content_screen.dart';
import 'package:worshipsongs/screens/artist_screen.dart';
import 'package:worshipsongs/screens/artist_songs_screen.dart';
import 'package:worshipsongs/screens/auth_screen/auth_screen.dart';
import 'package:worshipsongs/screens/home_screen/home_screen.dart';
import 'package:worshipsongs/screens/info_screen.dart';
import 'package:worshipsongs/screens/main_screen.dart';
import 'package:worshipsongs/screens/onboarding_screen.dart';
import 'package:worshipsongs/screens/request_lyrics/requested_lyrics.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/screens/splash_screen.dart';
import 'package:worshipsongs/screens/start_auth_screen/start_auth_screen.dart';
import 'package:worshipsongs/services/size_config.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, SongsProvider>(
          create: (_) => SongsProvider(accessToken: null),
          update: (_, auth, oldProvider) => SongsProvider(
            accessToken: auth.accessToken,
            songs: oldProvider?.songs ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ArtistsProvider>(
          create: (_) => ArtistsProvider(accessToken: null),
          update: (_, auth, oldProvider) => ArtistsProvider(
            accessToken: auth.accessToken,
          ),
        ),
        ChangeNotifierProxyProvider2<AuthProvider, SongsProvider,
            FavoriteSongsProvider>(
          create: (_) => FavoriteSongsProvider(accessToken: null),
          update: (_, authProvider, songsProvider, oldProvider) =>
              FavoriteSongsProvider(
            accessToken: authProvider.accessToken,
            favSongs: oldProvider?.songs ?? [],
          ),
        ),
      ],
      child: buildMaterialApp(context),
    );
  }

  MaterialApp buildMaterialApp(BuildContext context) {
    return MaterialApp(
      title: 'Worship songs',
      builder: (ctx, child) => Theme(
        data: _buildThemeData(ctx),
        child: child,
      ),
      home: Consumer<AuthProvider>(
        builder: (_, auth, __) {
          switch (auth.authStatus) {
            case AuthStatus.UNINITIALIZED:
              return SplashScreen();
            case AuthStatus.AUTHENTICATED:
              return MainScreen();
            case AuthStatus.UNAUTHENTICATED:
              return OnBoardingScreen();
            default:
              return OnBoardingScreen();
          }
        },
      ),
      routes: {
        OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        MainScreen.routeName: (ctx) => MainScreen(),
        SongScreen.routeName: (ctx) => SongScreen(),
        AccountSettingsScreen.routeName: (ctx) => AccountSettingsScreen(),
        AdminMainScreen.routeName: (ctx) => AdminMainScreen(),
        CreateContentScreen.routeName: (ctx) => CreateContentScreen(),
        CategoryScreen.routeName: (ctx) => CategoryScreen(),
        StartAuthScreen.routeName: (ctx) => StartAuthScreen(),
        InfoScreen.routeName: (ctx) => InfoScreen(),
        ArtistScreen.routeName: (ctx) => ArtistScreen(),
        ArtistSongsScreen.routeName: (ctx) => ArtistSongsScreen(),
        RequestLyrics.routeName: (ctx) => RequestLyrics(),
      },
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ru', ''),
        const Locale('ua', ''),
      ],
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    SizeConfig.init(context);
    return ThemeData(
      buttonTheme: ButtonThemeData(
        height: 56,
        buttonColor: AppColors.blue,
        focusColor: AppColors.blueText,
        disabledColor: Color(0xFF8FADCC),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.blue,
            width: 2,
          ),
        ),
      ),
      errorColor: AppColors.red,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: "Rubik",
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
      textTheme: TextTheme(
        /** Title 1 **/
        headline1: TextStyle(
          height: 1.33,
          fontWeight: FontWeight.w900,
          // fontSize: 32,
          fontSize: SizeConfig.blockSizeVertical * 4,
        ),
        /** Title 2 **/
        headline2: TextStyle(
          fontWeight: FontWeight.w700,
          // fontSize: 24,
          fontSize: SizeConfig.blockSizeVertical * 3,
        ),
        /** Title 3 **/
        headline3: TextStyle(
          fontWeight: FontWeight.w500,
          // fontSize: 18,
          fontSize: SizeConfig.blockSizeVertical * 2.25,
        ),
        /** Title/Songs; Playlists **/
        headline4: TextStyle(
          fontWeight: FontWeight.w500,
          // fontSize: 16,
          fontSize: SizeConfig.blockSizeVertical * 2,
        ),
        /** Input/Input Title **/
        headline5: TextStyle(
          // fontSize: 16,
          fontSize: SizeConfig.blockSizeVertical * 2,
          color: null,
        ),
        /** Input/Regular Input **/
        headline6: TextStyle(
          // fontSize: 14,
          fontSize: SizeConfig.blockSizeVertical * 1.75,
          fontWeight: FontWeight.normal,
        ),
        /** Lyrics/Middle **/
        subtitle1: TextStyle(
          height: 1.33,
          // fontSize: 18,
          fontSize: SizeConfig.blockSizeVertical * 2.25,
        ),
        /** Title/Navigation **/
        subtitle2: TextStyle(
          // fontSize: 12,
          fontWeight: FontWeight.normal,
          fontSize: SizeConfig.blockSizeVertical * 1.5,
        ),
        /** Guitar Chords **/
        bodyText1: TextStyle(
          // fontSize: 14,
          fontSize: SizeConfig.blockSizeVertical * 2,
          fontWeight: FontWeight.w500,
        ),
        /** Guitar Chords **/
        bodyText2: TextStyle(
          // fontSize: 10,
          fontSize: SizeConfig.blockSizeVertical * 1.25,
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
            // fontSize: 24,
            fontSize: SizeConfig.blockSizeVertical * 3,
          ),
        ),
      ),
    );
  }
}
