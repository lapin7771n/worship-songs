import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';
import 'package:worshipsongs/widgets/transparent_image.dart';

class ArtistListItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final String coverUrl;
  final EdgeInsets contentPadding;

  ArtistListItem({
    this.title,
    this.onTap,
    this.coverUrl,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 16,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      onTap: onTap,
      leading: buildLeading(),
      title: buildTitle(context),
      trailing: buildTrailing(),
    );
  }

  Widget buildLeading() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: coverUrl == null
          ? SongCoverImage(title: title, author: title)
          : FadeInImage(
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(coverUrl),
            ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Widget buildTrailing() {
    return SvgPicture.asset(
      'assets/images/ArrowRight.svg',
      color: AppColors.gray,
    );
  }
}
