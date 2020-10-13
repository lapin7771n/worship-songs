import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';
import 'package:worshipsongs/widgets/search_field.dart';

class AssignArtistScreen extends StatefulWidget {
  @override
  _AssignArtistScreenState createState() => _AssignArtistScreenState();
}

class _AssignArtistScreenState extends State<AssignArtistScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  bool isLoading = false;
  bool _isInit = false;
  List<Artist> artists = List();

  @override
  void initState() {
    if (!_isInit) {
      controller.addListener(textListenerCallback);
      textListenerCallback();
      _isInit = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(textListenerCallback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(
                      icon: SvgPicture.asset(ImagePathsHolder.ARROW_LEFT),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Provider.of<ArtistsProvider>(context, listen: false)
                            .dispose();
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    Strings.of(context).assignArtist,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
              SearchField(
                controller: controller,
                hintText: Strings.of(context).typeArtistName,
                focusNode: searchFocusNode,
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(
          SizeConfig.blockSizeVertical * 20,
        ),
      ),
      body: NotificationListener(
        // ignore: missing_return
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadMoreArtists();
          }
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            final Artist artist = artists[index];
            return BrandListItem(
              title: artist.title,
              onTap: () {
                Navigator.of(context).pop(artist);
              },
              imageUrl: artist.imageUrl,
            );
          },
          itemCount: artists.length,
        ),
      ),
    );
  }

  Future textListenerCallback() async {
    final List<Artist> artists =
        await Provider.of<ArtistsProvider>(context, listen: false).findByTitle(
      controller.text,
    );
    setState(() {
      this.artists = artists;
    });
  }

  void loadMoreArtists() async {
    if (isLoading) return;
    isLoading = true;
    await Provider.of<ArtistsProvider>(context, listen: false).read();
    isLoading = false;
  }
}
