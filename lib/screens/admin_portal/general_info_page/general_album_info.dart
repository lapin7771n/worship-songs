import 'package:flutter/material.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/widgets/main_info.dart';

class GeneralAlbumInfo extends StatefulWidget {
  @override
  _GeneralAlbumInfoState createState() => _GeneralAlbumInfoState();
}

class _GeneralAlbumInfoState extends State<GeneralAlbumInfo> {
  final TextEditingController albumTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              buildMainInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMainInfo(BuildContext context) {
    var albumTitle = albumTitleController.text;
    return MainInfo(
      textEditingController: albumTitleController,
      fieldTitle: albumTitle,
      hintText: Strings.of(context).exampleAlive,
    );
  }
}
