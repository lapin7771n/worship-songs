class Content {
  String title;
  String imagePath;
  String description;
  int relatedToArtist;
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
