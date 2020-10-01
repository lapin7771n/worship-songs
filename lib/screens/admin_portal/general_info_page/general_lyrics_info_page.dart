import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/add_lyrics_request.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/request_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/widgets/accept_content_button.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/widgets/main_info.dart';
import 'package:worshipsongs/widgets/settings_list_item.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';

class GeneralLyricsInfoPage extends StatefulWidget {
  final AddLyricsRequest addLyricsRequest;

  GeneralLyricsInfoPage() : addLyricsRequest = AddLyricsRequest.empty();

  @override
  _GeneralLyricsInfoPageState createState() => _GeneralLyricsInfoPageState();
}

class _GeneralLyricsInfoPageState extends State<GeneralLyricsInfoPage> {
  final TextEditingController songNameController = TextEditingController();

  @override
  void initState() {
    songNameController.addListener(textChangeListener);
    songNameController.text = widget.addLyricsRequest.title;
    super.initState();
  }

  @override
  void dispose() {
    songNameController.removeListener(textChangeListener);
    songNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: AcceptContentButton.ACCEPT_BUTTON_HEIGHT,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildMainInfo(context),
                  buildSpacer(),
                  buildSubtitle(Strings.of(context).artists(1), context),
                  SizedBox(height: 8),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 0),
                    leading:
                        SongCoverImage(title: 'Hillsong', author: 'Hillsong'),
                    title: Text(
                      'Hillsong Worship',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    trailing: SvgPicture.asset('assets/images/ArrowRight.svg'),
                  ),
                  buildSpacer(),
                  buildSubtitle(Strings.of(context).albums(1), context),
                  SettingsListItem.custom(
                    title: Strings.of(context).noAlbumAssigned,
                    subtitle: Strings.of(context).assignToAlbum,
                    onTap: (context) => () {},
                  ),
                  buildSpacer(),
                  buildSubtitle(Strings.of(context).databaseMatch, context),
                  buildNoDatabaseMatch(context),
                  buildSpacer(),
                  RequestInfo(
                    timestamp: widget.addLyricsRequest.timestamp,
                    authorID: widget.addLyricsRequest.authorID,
                  )
                ],
              ),
            ),
          ),
          AcceptContentButton(
            text: 'ada',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildNoDatabaseMatch(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.bluishGray,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/images/CheckIcon.svg'),
          ),
          Text(
            Strings.of(context).noMatchFound,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Text buildSubtitle(String subtitle, BuildContext context) {
    return Text(
      subtitle,
      style: Theme.of(context).textTheme.headline3,
    );
  }

  SizedBox buildSpacer() => SizedBox(height: 32);

  Widget buildMainInfo(BuildContext context) {
    return MainInfo(
      textEditingController: songNameController,
      fieldTitle: Strings.of(context).lyricsTitle,
      hintText: Strings.of(context).exampleWayMaker,
    );
  }

  void textChangeListener() {
    setState(() => null);
  }
}
