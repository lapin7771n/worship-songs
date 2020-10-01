import 'package:flutter/foundation.dart';

class Artist {
  int uuid;
  String imageUrl;
  final String title;
  final String description;
  final DateTime dateCreated;
  final DateTime dateEdited;

  Artist({
    this.uuid,
    @required this.title,
    this.imageUrl,
    this.description,
    this.dateCreated,
    this.dateEdited,
  });

  @override
  String toString() {
    return 'Artist{uuid: $uuid, title: $title, imageUrl: $imageUrl, description: $description, dateCreated: $dateCreated, dateEdited: $dateEdited}';
  }
}
