import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/screens/home_screen/home_screen.dart';
import 'package:worshipsongs/screens/my_lyrics_screen.dart';
import 'package:worshipsongs/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main';
  static const Map routes = {
    'Home': 'assets/images/HomeNotActive.svg',
    'My Lyrics': 'assets/images/MyLyrics.svg',
    'Settings': 'assets/images/Settings.svg',
  };

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyByIndex(selectedItem),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: MainScreen.routes.entries
          .map((e) => _buildBottomNavigationItem(e))
          .toList(),
      selectedItemColor: AppColors.blue,
      onTap: _handleBottomNavigationClick,
      currentIndex: selectedItem,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedLabelStyle: Theme.of(context).textTheme.subtitle2,
      unselectedLabelStyle: Theme.of(context).textTheme.subtitle2,
    );
  }

  BottomNavigationBarItem _buildBottomNavigationItem(MapEntry entry) {
    return BottomNavigationBarItem(
      icon: _getIconForBottomNavigationBar(entry.value),
      title: Text(entry.key),
      activeIcon: _getActiveIconForBottomNavigationBar(entry.value),
    );
  }

  Widget _getIconForBottomNavigationBar(String url) {
    return SvgPicture.asset(
      url,
      color: AppColors.gray,
    );
  }

  Widget _getActiveIconForBottomNavigationBar(String url) {
    return SvgPicture.asset(
      url.replaceAll('Not', ''),
      color: AppColors.blue,
    );
  }

  Widget _getBodyByIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return MyLyricsScreen();
      case 2:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }

  _handleBottomNavigationClick(int newSelectedItemIndex) {
    setState(() {
      selectedItem = newSelectedItemIndex;
    });
  }
}
