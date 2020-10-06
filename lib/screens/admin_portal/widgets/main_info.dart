import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/providers/new_content_provider.dart';
import 'package:worshipsongs/widgets/brand_field.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';
import 'package:worshipsongs/widgets/transparent_image.dart';

class MainInfo extends StatefulWidget {
  final TextEditingController textEditingController;
  final String fieldTitle;
  final String hintText;
  final Function(String) imagePathCallBack;

  const MainInfo({
    @required this.textEditingController,
    this.fieldTitle,
    this.hintText,
    this.imagePathCallBack,
  });

  @override
  _MainInfoState createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  String coverPath;

  @override
  void initState() {
    widget.textEditingController.addListener(textListenerCallback);
    super.initState();
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(textListenerCallback);
    super.dispose();
  }

  void textListenerCallback() {
    setState(() => null);
    Provider.of<NewContentProvider>(
      context,
      listen: false,
    ).title = widget.textEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    final String writtenText = widget.textEditingController.text;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCover(writtenText),
            buildEditButton(context),
          ],
        ),
        SizedBox(
          width: 16,
        ),
        buildTextField(),
      ],
    );
  }

  Flexible buildTextField() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BrandField(
            title: widget.fieldTitle,
            hintText: widget.hintText,
            controller: widget.textEditingController,
          ),
        ],
      ),
    );
  }

  MaterialButton buildEditButton(BuildContext context) {
    return MaterialButton(
      height: 0,
      minWidth: 0,
      padding: EdgeInsets.all(8),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashColor: AppColors.gray.withOpacity(0.1),
      onPressed: showBottomSheetCover,
      child: Text(
        Strings.of(context).edit,
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: AppColors.blue,
            ),
      ),
    );
  }

  Widget buildCover(String writtenText) {
    return coverPath == null
        ? buildTapableCoverPhoto(
            SongCoverImage(
              title: writtenText.isNotEmpty
                  ? writtenText
                  : widget.hintText.substring(0),
              author: writtenText.isNotEmpty
                  ? writtenText
                  : widget.hintText.substring(0),
              isBig: true,
            ),
          )
        : buildTapableCoverPhoto(
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: 88,
              height: 88,
              clipBehavior: Clip.antiAlias,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(File(coverPath)),
              ),
            ),
          );
  }

  Widget buildTapableCoverPhoto(Widget child) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: showBottomSheetCover,
            ),
          ),
        ),
      ],
    );
  }

  void showBottomSheetCover() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(Strings.of(context).selectNewPhotoFromGallery),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onEditClicked();
                },
              ),
              if (coverPath != null)
                ListTile(
                  title: Text(Strings.of(context).deletePhoto),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    setState(() {
                      coverPath = null;
                    });
                  },
                ),
              ListTile(
                title: Text(Strings.of(context).cancel),
                onTap: Navigator.of(ctx).pop,
              ),
            ],
          ),
        );
      },
    );
  }

  void onEditClicked() async {
    final PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final file = File(pickedFile.path);
    final megaBytes = file.lengthSync() / 1000000;
    if (megaBytes > 10.0) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        Strings.of(context).fileShouldNotBeBigger + ' 10 Mb',
      )));
      return;
    }

    setState(() {
      coverPath = file.path;
      widget.imagePathCallBack(coverPath);
    });
  }
}
