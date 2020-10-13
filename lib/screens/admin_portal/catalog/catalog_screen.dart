import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/catalog/categories_page.dart';
import 'package:worshipsongs/screens/main_screen.dart';
import 'package:worshipsongs/widgets/search_field.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final textController = TextEditingController();
  final searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(Strings.of(context).catalog),
        actions: [
          buildAction(context),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SearchField(
              controller: textController,
              hintText: Strings.of(context).typeSongName,
              focusNode: searchFocus,
            ),
          ),
          CategoriesPage(),
        ],
      ),
    );
  }

  Widget buildAction(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: Ink(
        decoration: ShapeDecoration(
          shape: CircleBorder(),
          color: Color(0xFFFAFAFA),
        ),
        child: IconButton(
          icon: SvgPicture.asset(ImagePathsHolder.LOGO),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              MainScreen.routeName,
            );
          },
        ),
      ),
    );
  }
}
