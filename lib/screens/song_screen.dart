import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';

class SongScreen extends StatelessWidget {
  static const String routeName = '/song-screen';

  @override
  Widget build(BuildContext context) {
    final song = ModalRoute.of(context).settings.arguments as Song;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Hero(
              tag: song.uuid,
              child: SongCoverImage(title: song.title),
            ),
          ),
          Positioned(
            top: 60,
            left: 16,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.close,
                color: AppColors.black,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 16,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.favorite_border,
                color: AppColors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 120),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 20),
              child: _buildMainContent(context, song),
            ),
          )
        ],
      ),
    );
  }

  _buildMainContent(BuildContext context, Song song) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          song.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          song.author,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: AppColors.gray),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          song.text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
