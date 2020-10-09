import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/data/artist.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/artists_provider.dart';
import 'package:worshipsongs/services/debouncer.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';

class ArtistsSearched extends StatefulWidget {
  final TextEditingController controller;
  final Function(Artist) onTap;

  const ArtistsSearched({
    Key key,
    @required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  _ArtistsSearchedState createState() => _ArtistsSearchedState();
}

class _ArtistsSearchedState extends State<ArtistsSearched> {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    widget.controller.addListener(textChangeListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            Strings.of(context).artists(2),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        FutureBuilder(
          future: loadArtists(widget.controller.text),
          builder: (ctx, snapshot) {
            final artists = snapshot.data as List<Artist>;
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var artist = artists[index];
                return BrandListItem(
                  title: artist.title,
                  imageUrl: artist.imageUrl,
                  withArrow: true,
                  onTap: () => widget.onTap(artist),
                );
              },
              itemCount: snapshot.hasData ? (snapshot.data as List).length : 0,
            );
          },
        ),
      ],
    );
  }

  void textChangeListener() {
    _debouncer(() {
      setState(() {});
    });
  }

  Future<List<Artist>> loadArtists(String title) async {
    return await Provider.of<ArtistsProvider>(context, listen: false)
        .findByTitle(
      title,
    );
  }
}
