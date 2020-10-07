import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/admin_page_route.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/catalog_screen.dart';
import 'package:worshipsongs/screens/admin_portal/create_content_screen.dart';
import 'package:worshipsongs/screens/admin_portal/requests_screen.dart';
import 'package:worshipsongs/widgets/speed_dial/flutter_speed_dial_material_design.dart';

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
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(currentScreenIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getBottomNavigationItem(0, AdminMainScreen.routes(context)[0]),
            SizedBox(
              height: 0,
            ),
            getBottomNavigationItem(1, AdminMainScreen.routes(context)[1]),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Color(0xFFF2F4F6),
        notchMargin: 10,
      ),
    );
  }

  Widget buildFab() {
    final icons = [
      buildSpeedDialAction(
        Strings.of(context).albums(1),
        ImagePathsHolder.MY_LYRICS,
      ),
      buildSpeedDialAction(
        Strings.of(context).lyrics,
        ImagePathsHolder.ADD_LYRICS,
      ),
      buildSpeedDialAction(
        Strings.of(context).artists(1),
        ImagePathsHolder.ADD_ARTIST,
      ),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Icon(Icons.add),
      useRotateAnimation: true,
      onAction: speedDialActionClicked,
    );
  }

  void requestsClicked() {
    setState(() {
      currentScreenIndex = 0;
    });
  }

  void catalogClicked() {
    setState(() {
      currentScreenIndex = 1;
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

    setState(() {
      isFabVisible = !isFabVisible;
    });
    await Navigator.of(context).pushNamed(
      CreateContentScreen.routeName,
      arguments: contentType,
    );
    setState(() {
      isFabVisible = !isFabVisible;
    });
  }

  SpeedDialAction buildSpeedDialAction(String title, String iconPath) {
    return SpeedDialAction(
      backgroundColor: AppColors.blue,
      child: SvgPicture.asset(
        iconPath,
        color: AppColors.white,
        height: 16,
        width: 16,
      ),
      label: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
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

  Widget getBottomNavigationItem(int index, AdminPageRoute adminPageRoute) {
    final AdminPageRoute route = AdminMainScreen.routes(context)[index];
    var isSelected = currentScreenIndex == index;
    return FlatButton(
      onPressed: index == 0 ? requestsClicked : catalogClicked,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? route.activeIconPath : route.iconPath,
              color: isSelected ? AppColors.blue : AppColors.gray,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              route.title,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: isSelected ? AppColors.blue : AppColors.gray,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
