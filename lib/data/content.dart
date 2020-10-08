import 'package:worshipsongs/data/artist.dart';

class Content {
  int uuid;
  String title;
  String imagePath;
  String description;
  Artist relatedToArtist;
  int relatedToAlbum;
  DateTime dateCreated;
  DateTime dateEdited;

  Content({
    this.uuid,
    this.title,
    this.imagePath,
    this.description,
    this.relatedToAlbum,
    this.relatedToArtist,
    this.dateEdited,
    this.dateCreated,
  });

  Content.empty()
      : title = "",
        description = "",
        dateCreated = DateTime.now();
}
