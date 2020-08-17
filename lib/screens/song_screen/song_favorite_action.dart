import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/services/songs_service.dart';

class SongFavoriteAction extends StatefulWidget {
  final String songId;

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
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    isFavorite =
        await SongsService.isFavorite(user.uid, widget.songId) ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () => _toggleFavorite(widget.songId),
    );
  }

  _toggleFavorite(String songId) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    isFavorite
        ? SongsService.removeFromFavorites(user.uid, songId)
        : SongsService.addToFavorites(user.uid, songId);
    setState(() {
      isFavorite = !isFavorite;
    });
  }
}
