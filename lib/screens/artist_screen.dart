import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/artist_songs_screen.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';
import 'package:worshipsongs/widgets/transparent_image.dart';

// ignore: must_be_immutable
class ArtistScreen extends StatelessWidget {
  static const String routeName = '/artist-screen';
  static const double _IMAGE_HEIGHT = 304;
  static const int _POPULAR_SONGS_LIMIT = 5;

  Artist artist;

  @override
  Widget build(BuildContext context) {
    artist = ModalRoute.of(context).settings.arguments as Artist;
    SystemChrome.setSystemUIOverlayStyle(
      artist.imageUrl != null
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFB0D7FF),
            height: _IMAGE_HEIGHT,
            width: double.infinity,
          ),
          if (artist.imageUrl != null)
            FadeInImage.memoryNetwork(
              fit: BoxFit.cover,
              height: _IMAGE_HEIGHT,
              width: double.infinity,
              placeholder: kTransparentImage,
              image: artist.imageUrl,
              fadeInDuration: Duration(milliseconds: 100),
              fadeOutDuration: Duration(milliseconds: 100),
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                buildMainCard(context),
              ],
            ),
          ),
          buildActionsRow(context),
        ],
      ),
    );
  }

  Widget buildActionsRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60, left: 16),
      // clipBehavior: Clip.antiAlias,
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: CircleBorder(),
        color: Color(0xFFFAFAFA),
        child: IconButton(
          icon: SvgPicture.asset(ImagePathsHolder.ARROW_LEFT),
          onPressed: Navigator.of(context).pop,
        ),
      ),
    );
  }

  Widget buildMainCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: _IMAGE_HEIGHT - 80),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildArtistTitle(),
            SizedBox(height: 24),
            ...buildAbout(context),
            SizedBox(height: 32),
            buildSongsList(context),
          ],
        ),
      ),
    );
  }

  Widget buildArtistTitle() {
    return Text(
      artist.title,
      style: AppTextStyles.title1,
    );
  }

  List<Widget> buildAbout(BuildContext context) {
    return [
      Text(
        Strings.of(context).about,
        style: AppTextStyles.title2,
      ),
      SizedBox(height: 16),
      ReadMoreText(
        artist.description,
        style: AppTextStyles.bodyTextRegular,
        trimLines: 3,
        trimMode: TrimMode.Line,
      ),
    ];
  }

  Widget buildSongsList(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SongsProvider>(context).findByArtistId(artist.uuid),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(child: Text(Strings.of(context).error));
        }
        final songList = snapshot.data as List<Song>;
        return Column(
          children: [
            ...buildPopularSongs(context, songList),
          ],
        );
      },
    );
  }

  List<Widget> buildPopularSongs(BuildContext context, List<Song> songs) {
    songs.sort((s1, s2) => s2.views.compareTo(s1.views));
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.of(context).popularLyrics,
            style: AppTextStyles.title2,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                ArtistSongsScreen.routeName,
                arguments: artist,
              );
            },
            child: Text(
              Strings.of(context).viewAllLyrics,
              style: AppTextStyles.buttonLink.copyWith(color: AppColors.blue),
            ),
          )
        ],
      ),
      BrandContentList(
        withSortedTitle: false,
        withLoadingAtTheEnd: false,
        scrollPhysics: NeverScrollableScrollPhysics(),
        contentPadding: const EdgeInsets.all(0),
        shrinkWrap: true,
        content: songs
            .take(_POPULAR_SONGS_LIMIT)
            .map(
              (e) => ContentForList(
                title: e.title,
                chipText: e.hasChords ? Strings.of(context).chords : null,
                subtitle: e.author,
                onTap: () => Navigator.of(context)
                    .pushNamed(SongScreen.routeName, arguments: e),
              ),
            )
            .toList(),
      ),
    ];
  }
}
