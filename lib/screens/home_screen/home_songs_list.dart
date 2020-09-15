import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/filter_bottom_sheet.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class HomeSongsList extends StatefulWidget {
  final List<Song> _songs;

  HomeSongsList(this._songs);

  @override
  _HomeSongsListState createState() => _HomeSongsListState();
}

class _HomeSongsListState extends State<HomeSongsList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      // ignore: missing_return
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadMoreSongs(context);
        }
      },
      child: buildListView(context),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, index) {
        if (index == widget._songs.length) {
          return const Center(child: const CircularProgressIndicator());
        }
        final Song previousSong = index > 0 ? widget._songs[index - 1] : null;
        final Song currentSong = widget._songs[index];
        Widget header;
        if (previousSong == null ||
            !_isFirstLetterEqual(currentSong, previousSong)) {
          header = _buildHeader(currentSong, context);
        }

        return Column(
          children: [
            if (index == 0) _buildFilters(context),
            if (index == 0) _buildAllLyrics(context),
            if (header != null) header,
            SongListItem(
              song: currentSong,
              onTap: () => _handleSongClick(currentSong, context),
            ),
          ],
        );
      },
      itemCount: widget._songs.length + 1,
    );
  }

  Container _buildHeader(Song currentSong, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: double.infinity,
      height: 37,
      color: AppColors.blue.withAlpha(25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          currentSong.title.substring(0, 1),
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  Widget _buildAllLyrics(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          Strings.of(context).allLyrics,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final languagesToLoad = Provider.of<SongsProvider>(
      context,
      listen: false,
    ).languagesToLoad.map((e) => _getLanguageFromCode(e));
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: MaterialButton(
          color: AppColors.blue,
          textColor: AppColors.white,
          onPressed: () => _showFilterBottomSheet(context),
          child: Text(
            '${Strings.of(context).filters}: ${languagesToLoad.join(', ')}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  String _getLanguageFromCode(String languageId) {
    switch (languageId) {
      case 'en':
        return Strings.of(context).english;
      case 'ru':
        return Strings.of(context).russian;
      case 'ua':
        return Strings.of(context).ukrainian;
    }
    return '';
  }

  void _showFilterBottomSheet(BuildContext context) async {
    await showCupertinoModalBottomSheet(
        context: context,
        bounce: true,
        expand: false,
        barrierColor: Colors.black45,
        builder: (ctx, scrollController) => FilterBottomSheet());

    setState(() {
      var songsProvider = Provider.of<SongsProvider>(context, listen: false);
      songsProvider.clearLoadedSongs();
      songsProvider.loadSongs();
    });
  }

  Future _loadMoreSongs(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;
    await Provider.of<SongsProvider>(context, listen: false).loadSongs();
    _isLoading = false;
  }

  bool _isFirstLetterEqual(Song currentSong, Song previousSong) {
    return currentSong.title.substring(0, 1) ==
        previousSong.title.substring(0, 1);
  }

  _handleSongClick(Song song, BuildContext context) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }
}
