import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/widgets/rounded_label.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';
import 'package:worshipsongs/widgets/transparent_image.dart';

class BrandListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String chipText;
  final EdgeInsets contentPadding;
  final bool withArrow;

  final Function onTap;

  const BrandListItem({
    @required this.title,
    this.imageUrl,
    this.subtitle,
    this.chipText,
    this.withArrow = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 16,
    ),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      isThreeLine: chipText != null,
      onTap: onTap,
      leading: buildLeading(),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: buildSubtitle(context),
      trailing: withArrow
          ? SvgPicture.asset(
              ImagePathsHolder.ARROW_RIGHT,
              color: AppColors.gray,
            )
          : null,
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return subtitle != null || chipText != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (subtitle != null)
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (chipText != null) SizedBox(height: 8),
              if (chipText != null)
                RoundedLabel(title: Strings.of(context).chords),
            ],
          )
        : null;
  }

  Widget buildLeading() {
    return Hero(
      tag: title.hashCode + subtitle.hashCode,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: imageUrl == null
            ? SongCoverImage(title: title, author: title)
            : FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(imageUrl),
              ),
      ),
    );
  }
}
