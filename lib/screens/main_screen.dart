import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/home_screen/home_screen.dart';
import 'package:worshipsongs/screens/my_lyrics_screen.dart';
import 'package:worshipsongs/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main';

  Map routes(BuildContext context) {
    return {
      Strings.of(context).home: ImagePathsHolder.HOME_NOT_ACTIVE,
      Strings.of(context).myLyrics: ImagePathsHolder.MY_LYRICS,
      Strings.of(context).settings: ImagePathsHolder.SETTINGS,
    };
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedItem = index);
        },
        children: [
          HomeScreen(),
          MyLyricsScreen(_goToHomePage),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: widget
          .routes(context)
          .entries
          .map((e) => _buildBottomNavigationItem(e))
          .toList(),
      selectedItemColor: AppColors.blue,
      onTap: _handleBottomNavigationClick,
      currentIndex: _selectedItem,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedLabelStyle: Theme.of(context).textTheme.subtitle2,
      unselectedLabelStyle: Theme.of(context).textTheme.subtitle2,
    );
  }

  BottomNavigationBarItem _buildBottomNavigationItem(MapEntry entry) {
    return BottomNavigationBarItem(
      icon: _getIconForBottomNavigationBar(entry.value),
      label: entry.key,
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

  _handleBottomNavigationClick(int newSelectedItemIndex) {
    setState(() {
      _selectedItem = newSelectedItemIndex;
      _pageController.animateToPage(
        newSelectedItemIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  void _goToHomePage() {
    _handleBottomNavigationClick(0);
  }
}
