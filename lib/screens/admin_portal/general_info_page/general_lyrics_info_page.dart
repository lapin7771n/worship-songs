import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/add_lyrics_request.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/new_content_provider.dart';
import 'package:worshipsongs/screens/admin_portal/general_info_page/request_info.dart';
import 'package:worshipsongs/screens/admin_portal/widgets/main_info.dart';
import 'package:worshipsongs/services/debouncer.dart';
import 'package:worshipsongs/widgets/artist_selector.dart';

class GeneralLyricsInfoPage extends StatefulWidget {
  final AddLyricsRequest addLyricsRequest;

  GeneralLyricsInfoPage() : addLyricsRequest = AddLyricsRequest.empty();

  @override
  _GeneralLyricsInfoPageState createState() => _GeneralLyricsInfoPageState();
}

class _GeneralLyricsInfoPageState extends State<GeneralLyricsInfoPage> {
  final TextEditingController songNameController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 300);

  bool _isInit = false;
  Artist artist;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      songNameController.addListener(textChangeListener);
      songNameController.text = widget.addLyricsRequest.title;
    });
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
    return ArtistSelector(
      initialArtist: artist,
      onArtistSelected: onSelectArtist,
    );
  }

  void onSelectArtist(Artist selectedArtist) {
    setState(() {
      artist = selectedArtist;
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
    _debouncer(() {
      setState(() => null);
    });
  }
}
