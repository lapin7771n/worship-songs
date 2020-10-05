import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/add_lyrics_request.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/assign_artist.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/request_info.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/widgets/main_info.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';
import 'package:worshipsongs/widgets/transparent_image.dart';

class GeneralLyricsInfoPage extends StatefulWidget {
  final AddLyricsRequest addLyricsRequest;

  GeneralLyricsInfoPage() : addLyricsRequest = AddLyricsRequest.empty();

  @override
  _GeneralLyricsInfoPageState createState() => _GeneralLyricsInfoPageState();
}

class _GeneralLyricsInfoPageState extends State<GeneralLyricsInfoPage> {
  final TextEditingController songNameController = TextEditingController();
  Artist artist;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMainInfo(context),
              buildSpacer(),
              buildSubtitle(Strings.of(context).artists(1), context),
              SizedBox(height: 8),
              buildArtist(),
              buildSpacer(),
              RequestInfo(
                timestamp: widget.addLyricsRequest.timestamp,
                authorID: widget.addLyricsRequest.authorID,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildArtist() {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      leading: artist == null ? null : buildArtistCoverImage(),
      title: Text(
        artist == null ? Strings.of(context).noAlbumAssigned : artist.title,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: artist == null
          ? Text(
              Strings.of(context).assignArtist,
              style: Theme.of(context).textTheme.subtitle2,
            )
          : null,
      trailing: SvgPicture.asset('assets/images/ArrowRight.svg'),
      onTap: onSelectArtist,
    );
  }

  void onSelectArtist() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AssignArtistScreen()),
    );
  }

  Widget buildArtistCoverImage() {
    return artist.uuid == null
        ? SongCoverImage(title: artist.title, author: artist.title)
        : Container(
            width: 56,
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(artist.imageUrl),
            ),
          );
  }

  Widget buildNoDatabaseMatch(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
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
