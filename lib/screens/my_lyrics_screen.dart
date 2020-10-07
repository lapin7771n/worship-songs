import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/favorite_song.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/favorite_songs_provider.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';

class MyLyricsScreen extends StatelessWidget {
  final Function goToMainPage;

  const MyLyricsScreen(this.goToMainPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _getSongsFromFavorite(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            final List<Song> songs = snapshot.data as List<Song>;

            if (songs == null || songs.isEmpty) {
              return _buildEmptyState(context);
            }

            return ListView.builder(
              itemBuilder: (ctx, index) {
                Widget additionalWidget;
                if (index == 0) {
                  additionalWidget = _buildHeader(context);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (additionalWidget != null) additionalWidget,
                    BrandListItem(
                      song: songs[index],
                      onTap: () => _handleSongClick(songs[index], context),
                    ),
                  ],
                );
              },
              itemCount: songs.length,
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Text(
        Strings.of(context).myLyrics,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Future<List<Song>> _getSongsFromFavorite(BuildContext context) async {
    final List<FavoriteSong> favSongs =
        await Provider.of<FavoriteSongsProvider>(context).getAll();
    final List<int> ids = favSongs.map((e) => e.songId).toList();
    final List<Song> songs =
        await Provider.of<SongsProvider>(context, listen: false)
            .getSongsById(ids);
    songs.sort((o1, o2) => o1.title.compareTo(o2.title));
    return songs;
  }

  _handleSongClick(Song song, BuildContext context) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }

  Widget _buildEmptyState(BuildContext context) {
    final roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 3,
        ),
        _buildHeader(context),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 7,
        ),
        Center(
          child: SvgPicture.asset(
            ImagePathsHolder.MY_LYRICS_EMPTY_IMAGE,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Center(
          child: Text(
            Strings.of(context).noLyricsAdded,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockVertical * 7,
          ),
          child: Text(
            Strings.of(context).browseOurLyricsCatalogue,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 3,
        ),
        Center(
          child: Material(
            shape: roundedRectangleBorder,
            elevation: 3,
            child: OutlineButton(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockVertical * 8,
                ),
                child: Text(
                  Strings.of(context).exploreLyrics,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: AppColors.blue,
                      ),
                ),
              ),
              shape: roundedRectangleBorder,
              borderSide: BorderSide(
                color: AppColors.blue,
                width: 2,
              ),
              textColor: AppColors.blue,
              onPressed: goToMainPage,
            ),
          ),
        )
      ],
    );
  }
}
