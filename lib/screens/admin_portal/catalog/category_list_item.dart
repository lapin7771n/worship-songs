import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';

class CategoryListItem extends StatelessWidget {
  final String title;
  final Future countFuture;
  final Function onTap;

  CategoryListItem({
    @required this.title,
    @required this.countFuture,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: FutureBuilder(
        future: countFuture,
        builder: (_, snapshot) => Text(
          '${snapshot.data ?? Strings.of(context).loading} $title',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      trailing: onTap == null
          ? null
          : SvgPicture.asset(
              ImagePathsHolder.ARROW_RIGHT,
            ),
      onTap: onTap,
    );
  }
}
