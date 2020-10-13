import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/data/admin_page_route.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/catalog_screen.dart';
import 'package:worshipsongs/screens/admin_portal/create_content_screen.dart';
import 'package:worshipsongs/screens/admin_portal/requests_screen.dart';
import 'package:worshipsongs/services/size_config.dart';

class AdminMainScreen extends StatefulWidget {
  static const String routeName = '/admin-home';

  static List<AdminPageRoute> routes(BuildContext context) => [
        AdminPageRoute(
          title: Strings.of(context).requests,
          activeIconPath: ImagePathsHolder.REQUESTS_ACTIVE,
          iconPath: ImagePathsHolder.REQUESTS,
        ),
        AdminPageRoute(
          title: Strings.of(context).catalog,
          activeIconPath: ImagePathsHolder.CATALOG_ACTIVE,
          iconPath: ImagePathsHolder.CATALOG,
        ),
      ];

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int currentScreenIndex = 0;
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(currentScreenIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        selectedLabelStyle: AppTextStyles.titleNavigation,
        unselectedLabelStyle: AppTextStyles.titleNavigation,
        currentIndex: currentScreenIndex,
        items: [
          ...[0, 1].map(
            (e) => getBottomNavigationItem(
              e,
              AdminMainScreen.routes(context)[e],
            ),
          ),
        ],
        backgroundColor: Color(0xFFF2F4F6),
        elevation: 2,
        onTap: onBottomNavigationClicked,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.gray,
      ),
    );
  }

  Widget buildFab() {
    final actions = [
      buildSpeedDialAction(
        Strings.of(context).albums(1),
        ImagePathsHolder.MY_LYRICS,
        () => speedDialActionClicked(0),
      ),
      buildSpeedDialAction(
        Strings.of(context).lyrics,
        ImagePathsHolder.ADD_LYRICS,
        () => speedDialActionClicked(1),
      ),
      buildSpeedDialAction(
        Strings.of(context).artists(1),
        ImagePathsHolder.ADD_ARTIST,
        () => speedDialActionClicked(2),
      ),
    ];

    return SpeedDial(
      elevation: 2,
      children: actions,
      animatedIconTheme: IconThemeData(size: 22.0),
      marginBottom: SizeConfig.safeBlockVertical * 7,
      child: Icon(isOpened ? Icons.close : Icons.add),
      onOpen: () => setState(() => isOpened = true),
      onClose: () => setState(() => isOpened = false),
      marginRight: MediaQuery.of(context).size.width / 2 - 11,
    );
  }

  void onBottomNavigationClicked(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  void speedDialActionClicked(int index) async {
    print(index);
    ContentType contentType;
    switch (index) {
      case 0:
        contentType = ContentType.album;
        break;
      case 1:
        contentType = ContentType.lyrics;
        break;
      case 2:
        contentType = ContentType.artist;
        break;
      default:
        throw UnsupportedError("unknown id: $index");
    }

    Navigator.of(context).pushNamed(
      CreateContentScreen.routeName,
      arguments: {'contentType': contentType},
    );
  }

  SpeedDialChild buildSpeedDialAction(
      String title, String iconPath, Function onTap) {
    return SpeedDialChild(
      backgroundColor: AppColors.blue,
      child: Container(
        padding: EdgeInsets.all(12),
        child: SvgPicture.asset(
          iconPath,
          color: AppColors.white,
        ),
      ),
      label: title,
      labelStyle: Theme.of(context).textTheme.subtitle2,
      onTap: onTap,
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return RequestsScreen();
      case 1:
        return CatalogScreen();
      default:
        return RequestsScreen();
    }
  }

  BottomNavigationBarItem getBottomNavigationItem(
      int index, AdminPageRoute adminPageRoute) {
    final AdminPageRoute route = AdminMainScreen.routes(context)[index];
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        route.activeIconPath,
        color: AppColors.blue,
        width: 24,
        height: 24,
      ),
      icon: SvgPicture.asset(
        route.iconPath,
        color: AppColors.gray,
        width: 24,
        height: 24,
      ),
      label: route.title,
    );
  }
}
