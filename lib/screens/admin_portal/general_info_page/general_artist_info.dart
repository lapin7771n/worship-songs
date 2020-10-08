import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/new_content_provider.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/request_info.dart';
import 'package:worshipsongs/screens/admin_portal/widgets/main_info.dart';
import 'package:worshipsongs/widgets/brand_field.dart';

class GeneralArtistInfo extends StatefulWidget {
  final Content content;

  GeneralArtistInfo(this.content);

  @override
  _GeneralArtistInfoState createState() => _GeneralArtistInfoState();
}

class _GeneralArtistInfoState extends State<GeneralArtistInfo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String coverPath;

  @override
  void didChangeDependencies() {
    titleController.text = widget.content?.title ?? "";
    descriptionController.text = widget.content?.description ?? "";
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
              const SizedBox(height: 32),
              BrandField(
                maxLines: 4,
                title: Strings.of(context).artistDescription,
                hintText: Strings.of(context).describeThisArtist,
                controller: descriptionController,
              ),
              const SizedBox(height: 32),
              RequestInfo(
                timestamp: widget.content.dateCreated,
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
    provider.dateCreated = widget.content.dateCreated;
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
