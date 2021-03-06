import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/providers/favorite_songs_provider.dart';

class SongFavoriteAction extends StatefulWidget {
  final int songId;

  const SongFavoriteAction(this.songId);

  @override
  _SongFavoriteActionState createState() => _SongFavoriteActionState();
}

class _SongFavoriteActionState extends State<SongFavoriteAction> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    isFavorite =
        await Provider.of<FavoriteSongsProvider>(context, listen: false)
            .isFavorite(widget.songId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () => _toggleFavorite(widget.songId),
    );
  }

  _toggleFavorite(int songId) async {
    final provider = Provider.of<FavoriteSongsProvider>(context, listen: false);
    isFavorite ? provider.remove(songId) : provider.add(songId);
    setState(() {
      isFavorite = !isFavorite;
    });
  }
}
