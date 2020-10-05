import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/search_field.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';
import 'package:worshipsongs/widgets/transparent_image.dart';

class AssignArtistScreen extends StatefulWidget {
  @override
  _AssignArtistScreenState createState() => _AssignArtistScreenState();
}

class _AssignArtistScreenState extends State<AssignArtistScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          minimum: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ArrowLeft.svg'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Provider.of<ArtistsProvider>(context, listen: false)
                          .dispose();
                    },
                  ),
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
          SizeConfig.blockSizeVertical * 15,
        ),
      ),
      body: NotificationListener(
        // ignore: missing_return
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadMoreArtists();
          }
        },
        child: Consumer<ArtistsProvider>(
          builder: (ctx, value, child) => ListView.builder(
            itemBuilder: (context, index) {
              if (index == value.loadedArtists.length) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final Artist artist = value.loadedArtists[index];
              return ListTile(
                title: Text(
                  artist.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                leading: buildLeading(artist),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
              );
            },
            itemCount: value.loadedArtists.length + 1,
          ),
        ),
      ),
    );
  }

  Widget buildLeading(Artist artist) {
    return artist.imageUrl == null
        ? SongCoverImage(title: artist.title, author: artist.title)
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(artist.imageUrl),
            ),
          );
  }

  void loadMoreArtists() async {
    if (isLoading) return;
    isLoading = true;
    await Provider.of<ArtistsProvider>(context, listen: false).read();
    isLoading = false;
  }
}
