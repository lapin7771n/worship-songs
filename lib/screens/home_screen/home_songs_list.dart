import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_screen.dart';
import 'package:worshipsongs/services/songs_service.dart';
import 'package:worshipsongs/widgets/song_list_item.dart';

class HomeSongsList extends StatefulWidget {
  final List<Song> initialSongs;
  final int offset;

  HomeSongsList({this.initialSongs, this.offset});

  @override
  _HomeSongsListState createState() => _HomeSongsListState();
}

class _HomeSongsListState extends State<HomeSongsList> {
  bool isInit = false;

  bool isLoading = false;
  List<Song> loadedSongs = List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      loadedSongs.addAll(widget.initialSongs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      // ignore: missing_return
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          setState(() {
            isLoading = true;
          });
          _loadNewSongs();
        }
      },
      child: buildListView(context),
    );
  }

  ListView buildListView(BuildContext context) {
    Song previousSong;
    return ListView.builder(
      itemBuilder: (c, index) {
        if (index == loadedSongs.length) {
          return Center(child: CircularProgressIndicator());
        }

        final Song currentSong = loadedSongs[index];
        Widget header;
        if (previousSong == null ||
            !_isFirstLetterEqual(currentSong, previousSong)) {
          header = Container(
            color: AppColors.blue.withAlpha(25),
            child: ListTile(
              title: Text(
                currentSong.title.substring(0, 1),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
          previousSong = currentSong;
        }

        return Column(
          children: [
            if (header != null) header,
            SongListItem(
              song: currentSong,
              onTap: () => _handleSongClick(currentSong, context),
            ),
          ],
        );
      },
      itemCount: isLoading ? loadedSongs.length + 1 : loadedSongs.length,
    );
  }

  bool _isFirstLetterEqual(Song currentSong, Song previousSong) {
    return currentSong.title.substring(0, 1) ==
        previousSong.title.substring(0, 1);
  }

  _handleSongClick(Song song, BuildContext context) {
    Navigator.of(context).pushNamed(SongScreen.routeName, arguments: song);
  }

  _loadNewSongs() async {
    final List<Song> songs = await SongsService.getSongs(
      widget.initialSongs.length,
      orderByName: true,
      startAfter: loadedSongs[loadedSongs.length - 1].title,
    );
    setState(() {
      loadedSongs.addAll(songs);
      isLoading = false;
    });
  }
}
