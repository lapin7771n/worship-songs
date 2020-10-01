import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/request_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/widgets/main_info.dart';
import 'package:worshipsongs/screens/admin_portal/providers/new_content_provider.dart';
import 'package:worshipsongs/widgets/brand_field.dart';

class GeneralArtistInfo extends StatefulWidget {
  @override
  _GeneralArtistInfoState createState() => _GeneralArtistInfoState();
}

class _GeneralArtistInfoState extends State<GeneralArtistInfo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String coverPath;
  DateTime timeStamp = DateTime.now();

  @override
  void didChangeDependencies() {
    descriptionController.addListener(descriptionChangesListener);
    addTimeStamp();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    descriptionController.removeListener(descriptionChangesListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            children: [
              MainInfo(
                textEditingController: titleController,
                fieldTitle: Strings.of(context).artistTitle,
                hintText: Strings.of(context).exampleRoomForMore,
                imagePathCallBack: onImageChosen,
              ),
              SizedBox(height: 32),
              BrandField(
                maxLines: 4,
                title: Strings.of(context).artistDescription,
                hintText: Strings.of(context).describeThisArtist,
                controller: descriptionController,
              ),
              SizedBox(height: 32),
              RequestInfo(
                timestamp: timeStamp,
                authorID: null,
              )
            ],
          ),
        ),
      ),
    );
  }

  void addTimeStamp() {
    var provider = Provider.of<NewContentProvider>(
      context,
      listen: false,
    );
    provider.dateCreated = timeStamp;
    provider.dateEdited = DateTime.now();
  }

  void descriptionChangesListener() {
    Provider.of<NewContentProvider>(
      context,
      listen: false,
    ).description = descriptionController.text;
  }

  void onImageChosen(String imagePath) {
    Provider.of<NewContentProvider>(
      context,
      listen: false,
    ).localImagePath = imagePath;
  }
}
