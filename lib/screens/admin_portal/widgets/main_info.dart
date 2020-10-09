import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/new_content_provider.dart';
import 'package:worshipsongs/widgets/brand_field.dart';
import 'package:worshipsongs/widgets/songs/song_cover_image.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final Content content = Provider.of<NewContentProvider>(
          context,
          listen: false,
        ).content;
        widget.textEditingController.text = content.title;
        widget.textEditingController.addListener(textListenerCallback);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(textListenerCallback);
    super.dispose();
  }

  void textListenerCallback() {
    setState(() {
      Provider.of<NewContentProvider>(
        context,
        listen: false,
      ).title = widget.textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<NewContentProvider>(
              builder: (ctx, provider, child) => buildCover(provider.content),
            ),
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
            maxLength: 40,
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

  Widget buildCover(Content content) {
    return coverPath == null && content.imagePath == null
        ? buildTapableCoverPhoto(
            SongCoverImage(
              title: content.title.isNotEmpty
                  ? content.title
                  : widget.hintText.substring(0),
              author: content.title.isNotEmpty
                  ? content.title
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
                image: coverPath != null
                    ? FileImage(File(coverPath))
                    : NetworkImage(content.imagePath),
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
