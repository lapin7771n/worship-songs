import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class HomeSongsList extends StatelessWidget {
  final List<Song> _songs;

  bool _isLoading = false;

  HomeSongsList(this._songs);

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
        if (index == _songs.length) {
          return const Center(child: const CircularProgressIndicator());
        }
        final Song previousSong = index > 0 ? _songs[index - 1] : null;
        final Song currentSong = _songs[index];
        Widget header;
        if (previousSong == null ||
            !_isFirstLetterEqual(currentSong, previousSong)) {
          header = _buildHeader(currentSong, context);
        }

        return Column(
          children: [
            if (index == 0) _buildAllLyrics(context),
            if (header != null) header,
            SongListItem(
              song: currentSong,
              onTap: () => _handleSongClick(currentSong, context),
            ),
          ],
        );
      },
      itemCount: _songs.length + 1,
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

  Align _buildAllLyrics(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'All Lyrics',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
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
