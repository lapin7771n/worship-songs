import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/content.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/data/popup_item.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/new_content_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/admin_portal/lyrics_page.dart';
import 'package:worshipsongs/screens/admin_portal/widgets/accept_content_button.dart';

import '../../app_colors.dart';

class CreateContentScreen extends StatefulWidget {
  static const String routeName = '/create-new-content';

  @override
  _CreateContentScreenState createState() => _CreateContentScreenState();
}

class _CreateContentScreenState extends State<CreateContentScreen> {
  Map popupMenu(BuildContext context) => {};

  final scaffoldKey = GlobalKey<ScaffoldState>();
  ContentType contentType;
  Content content;
  BuildContext providerContext;
  bool isCreateButtonActive = true;

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    contentType = map['contentType'];
    content = map['content'] ?? Content.empty();
    return ChangeNotifierProvider(
      create: (_) => NewContentProvider(
        contentType: contentType,
        songsProvider: Provider.of<SongsProvider>(context, listen: false),
        artistsProvider: Provider.of<ArtistsProvider>(context, listen: false),
        content: content,
      ),
      builder: (context, child) {
        providerContext = context;
        return DefaultTabController(
          length: contentType == ContentType.lyrics ? 2 : 1,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                contentType.name(context),
              ),
              actions: [buildAction()],
              bottom: contentType == ContentType.lyrics
                  ? TabBar(
                      tabs: [
                        Tab(text: Strings.of(context).generalInfo),
                        Tab(text: Strings.of(context).lyrics),
                      ],
                      unselectedLabelColor: AppColors.black,
                      labelColor: AppColors.blue,
                      indicatorColor: AppColors.blue,
                      labelStyle: Theme.of(context).textTheme.headline5,
                    )
                  : null,
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: AcceptContentButton.ACCEPT_BUTTON_HEIGHT,
                    ),
                    child: TabBarView(
                      children: [
                        contentType.widget(content),
                        if (contentType == ContentType.lyrics) LyricsPage(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer<NewContentProvider>(
                      builder: (ctx, value, __) => AcceptContentButton(
                        text: buttonText,
                        onTap: value.isContentValid && isCreateButtonActive
                            ? () => acceptContent(context)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAction() {
    return content.uuid != null
        ? IconButton(
            padding: EdgeInsets.all(16),
            icon: SvgPicture.asset(ImagePathsHolder.DELETE),
            onPressed: rejectClicked,
          )
        : buildPopupMenuButton();
  }

  String get buttonText {
    final String verb = content.uuid != null
        ? Strings.of(context).save
        : Strings.of(context).accept;

    final String noun = contentType.name(context);
    return "$verb $noun";
  }

  PopupMenuButton<PopupItem> buildPopupMenuButton() {
    return PopupMenuButton<PopupItem>(
      icon: Icon(Icons.more_vert_rounded),
      onSelected: popupSelected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      itemBuilder: (ctx) {
        return popupItems(ctx)
            .map(
              (e) => PopupMenuItem<PopupItem>(
                value: e,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      e.iconPath,
                      color: e.color,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      e.title,
                      style: Theme.of(ctx).textTheme.bodyText1.copyWith(
                            color: e.color,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            )
            .toList();
      },
    );
  }

  List<PopupItem> popupItems(BuildContext context) {
    return [
      PopupItem(
        title: Strings.of(context).preview,
        onTap: previewClicked,
        color: AppColors.black,
        iconPath: ImagePathsHolder.EYE_OPENED,
      ),
      if (content != null)
        PopupItem(
          title: Strings.of(context).reject,
          onTap: rejectClicked,
          color: AppColors.red,
          iconPath: ImagePathsHolder.DELETE,
        ),
    ];
  }

  void previewClicked() {
    print("Preview");
  }

  void rejectClicked() async {
    final response = await Provider.of<NewContentProvider>(
      providerContext,
      listen: false,
    ).deleteContent();
    showRejectStatusMessage(response);
  }

  void showRejectStatusMessage(bool isSuccess) async {
    Navigator.of(providerContext).pop(isSuccess);
  }

  void popupSelected(PopupItem item) {
    item.onTap();
  }

  void acceptContent(BuildContext ctx) async {
    setState(() {
      isCreateButtonActive = false;
    });
    final isSuccess = await Provider.of<NewContentProvider>(
      ctx,
      listen: false,
    ).saveContent();
    if (isSuccess) {
      Navigator.of(ctx).pop();
    } else {
      setState(() {
        isCreateButtonActive = true;
      });
    }
  }
}
