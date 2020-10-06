import 'package:worshipsongs/data/artist.dart';

class Content {
  String title;
  String imagePath;
  String description;
  Artist relatedToArtist;
  int relatedToAlbum;
  DateTime dateCreated;
  DateTime dateEdited;

  Content({
    this.title,
    this.imagePath,
    this.description,
    this.relatedToAlbum,
    this.relatedToArtist,
  });

  Content.empty();
}
