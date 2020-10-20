import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/admin_portal/assign_artist.dart';

import 'brand_list_item.dart';

class ArtistSelector extends StatefulWidget {
  final Function(Artist) onArtistSelected;
  final Artist initialArtist;

  const ArtistSelector({
    Key key,
    this.onArtistSelected,
    this.initialArtist,
  }) : super(key: key);

  @override
  _ArtistSelectorState createState() => _ArtistSelectorState();
}

class _ArtistSelectorState extends State<ArtistSelector> {
  Artist selectedArtist;

  @override
  void initState() {
    super.initState();
    selectedArtist = widget.initialArtist;
  }

  @override
  Widget build(BuildContext context) {
    return selectedArtist == null
        ? ListTile(
            onTap: () => onSelectArtist(context),
            contentPadding: EdgeInsets.only(left: 0),
            title: Text(
              Strings.of(context).noArtistAssigned,
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              Strings.of(context).assignArtist,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            trailing: SvgPicture.asset(ImagePathsHolder.ARROW_RIGHT),
          )
        : BrandListItem(
            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
            onTap: () => onSelectArtist(context),
            imageUrl: selectedArtist.imageUrl,
            title: selectedArtist.title,
          );
  }

  void onSelectArtist(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AssignArtistScreen()),
    );
    setState(() {
      selectedArtist = result ?? selectedArtist;
      widget.onArtistSelected(selectedArtist);
    });
  }
}
