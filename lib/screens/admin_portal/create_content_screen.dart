import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/general_album_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/general_artist_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/general_lyrics_info_page.dart';
import 'package:worshipsongs/screens/admin_portal/lyrics_page.dart';
import 'package:worshipsongs/screens/admin_portal/providers/new_content_provider.dart';
import 'package:worshipsongs/screens/admin_portal/widgets/accept_content_button.dart';

import '../../app_colors.dart';

class CreateContentScreen extends StatefulWidget {
  static const String routeName = '/create-new-content';

  @override
  _CreateContentScreenState createState() => _CreateContentScreenState();
}

class _CreateContentScreenState extends State<CreateContentScreen> {
  final GlobalKey scaffoldKey = GlobalKey();
  ContentType contentType;

  @override
  Widget build(BuildContext context) {
    contentType = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (_) => NewContentProvider(
        contentType: contentType,
        songsProvider: Provider.of<SongsProvider>(context, listen: false),
        artistsProvider: Provider.of<ArtistsProvider>(context, listen: false),
      ),
      builder: (context, child) => DefaultTabController(
        length: contentType == ContentType.lyrics ? 2 : 1,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              contentType.name(context),
            ),
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
                      contentType.widget,
                      if (contentType == ContentType.lyrics) LyricsPage(),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<NewContentProvider>(
                    builder: (ctx, value, __) => AcceptContentButton(
                      text: Strings.of(context).accept +
                          " " +
                          contentType.name(context),
                      onTap: value.isContentValid
                          ? () => acceptContent(context)
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void acceptContent(BuildContext ctx) async {
    final isSuccess = await Provider.of<NewContentProvider>(
      ctx,
      listen: false,
    ).saveContent();
    if (isSuccess) {
      Navigator.of(ctx).pop();
    }
  }
}

extension WidgetForContent on ContentType {
  Widget get widget {
    switch (this) {
      case ContentType.lyrics:
        return GeneralLyricsInfoPage();
      case ContentType.album:
        return GeneralAlbumInfo();
      case ContentType.artist:
        return GeneralArtistInfo();
      default:
        throw UnsupportedError("Unsupported type Error: $this");
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case ContentType.lyrics:
        return Strings.of(context).lyrics;
      case ContentType.album:
        return Strings.of(context).albums(1);
      case ContentType.artist:
        return Strings.of(context).artists(1);
      default:
        return null;
    }
  }
}
