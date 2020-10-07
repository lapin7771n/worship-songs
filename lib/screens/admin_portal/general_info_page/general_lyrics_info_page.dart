import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/add_lyrics_request.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/assign_artist.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/request_info.dart';
import 'package:worshipsongs/providers/new_content_provider.dart';
import 'package:worshipsongs/screens/admin_portal/widgets/main_info.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';

class GeneralLyricsInfoPage extends StatefulWidget {
  final AddLyricsRequest addLyricsRequest;

  GeneralLyricsInfoPage() : addLyricsRequest = AddLyricsRequest.empty();

  @override
  _GeneralLyricsInfoPageState createState() => _GeneralLyricsInfoPageState();
}

class _GeneralLyricsInfoPageState extends State<GeneralLyricsInfoPage> {
  final TextEditingController songNameController = TextEditingController();

  bool _isInit = false;
  Artist artist;

  @override
  void initState() {
    songNameController.addListener(textChangeListener);
    songNameController.text = widget.addLyricsRequest.title;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final provider = Provider.of<NewContentProvider>(context, listen: false);
      songNameController.text = provider.content.title;
      artist = provider.content.relatedToArtist;
    }
    super.didChangeDependencies();
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
    return artist == null
        ? ListTile(
            onTap: onSelectArtist,
            contentPadding: EdgeInsets.only(left: 0),
            title: Text(
              Strings.of(context).noArtistAssigned,
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              Strings.of(context).assignArtist,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            trailing: SvgPicture.asset(ImagePathsHolder.ARROW_RIGHT),
          )
        : BrandListItem(
            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
            onTap: onSelectArtist,
            imageUrl: artist.imageUrl,
            title: artist.title,
          );
  }

  void onSelectArtist() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AssignArtistScreen()),
    );
    setState(() {
      artist = result;
      Provider.of<NewContentProvider>(context, listen: false).artist = artist;
    });
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
